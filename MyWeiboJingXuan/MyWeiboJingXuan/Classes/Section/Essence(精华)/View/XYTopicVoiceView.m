//
//  XYTopicVoiceView.m
//  bai
//
//  Created by yuan on 15/11/22.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTopicVoiceView.h"
#import "XYTopicItem.h"
#import <UIImageView+WebCache.h>
#import "XYSeeBigPictureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XFVociePlayerController.h"

@interface XYTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,strong) XFVociePlayerController *voicePlayer;
@end

@implementation XYTopicVoiceView

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
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.middle_image]];
    // 设置播放量
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    // 设置音频时长
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}

#pragma mark - 播放按钮的点击
- (IBAction)playBtnClick:(UIButton *)sender
{
    self.playBtn.hidden = YES;
    self.voicePlayer = [[XFVociePlayerController alloc]initWithNibName:NSStringFromClass([XFVociePlayerController class]) bundle:nil];
    self.voicePlayer.url = self.topic.voiceuri;
    self.voicePlayer.totalTime = self.topic.voicetime;
    self.voicePlayer.view.xy_width = self.imageView.xy_width;
    self.voicePlayer.view.xy_y = self.imageView.xy_height - self.voicePlayer.view.xy_height;
    [self addSubview:self.voicePlayer.view];

}

//重置
-(void)reset {
    
    [self.voicePlayer dismiss];
    [self.voicePlayer.view removeFromSuperview];
    self.voicePlayer = nil;
    self.playBtn.hidden = NO;
}


@end
