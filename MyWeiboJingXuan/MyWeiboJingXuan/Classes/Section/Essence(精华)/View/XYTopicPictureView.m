//
//  XYTopicPictureView.m
//  bai
//
//  Created by yuan on 15/11/22.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTopicPictureView.h"
#import "XYTopicItem.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "XYSeeBigPictureViewController.h"

@interface XYTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *isGif;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
/** 进度条 */
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation XYTopicPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 设置进度条的值
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.trackTintColor = [UIColor whiteColor];
    self.progressView.progressLabel.textColor = [UIColor darkGrayColor];
    
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
    // 设置背景图片,同时设置进度条
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.big_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 在这里设置进度条的值
        self.progressView.hidden = NO;
        CGFloat progress =  1.0 *receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"加载%.0f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 下载完图片,移除进度条
        self.progressView.hidden = YES;
    }];
    
    // 是否显示gif
    self.isGif.hidden = !topic.is_gif;
    
    // 查看大图
    self.seeBigPictureButton.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) { // 超长图片
        
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
    } else {
        
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
        
    }
}


@end
