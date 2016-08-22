//
//  XYTopicVideoView.m
//  bai
//
//  Created by yuan on 15/11/22.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTopicVideoView.h"
#import "XYTopicItem.h"
#import <UIImageView+WebCache.h>
#import "XYSeeBigPictureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "KRVideoPlayerController.h"

@interface XYTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@end

@implementation XYTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 查看大图
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
    
}

- (void)seeBig
{
    XYSeeBigPictureViewController *seeBig = [[XYSeeBigPictureViewController alloc] init];
    // 设置数据
    seeBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}


- (void)setTopic:(XYTopicItem *)topic
{
    _topic = topic;
    
    // 设置背景图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.big_image]];
    // 设置播放量
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    // 设置视频时长
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

#pragma mark - 播放视频
- (IBAction)playBtnClick:(UIButton *)sender
{
    [self playVideoWithURL:[NSURL URLWithString:self.topic.videouri]];
    [self addSubview:self.videoController.view];
}

- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:self.imageView.bounds];
        XYWeakSelf;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
    }
    self.videoController.contentURL = url;
}

//停止视频的播放
- (void)reset {
    [self.videoController dismiss];
    self.videoController = nil;
}


@end
