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

@interface XYTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

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
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.big_image]];
    // 设置播放量
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    // 设置音频时长
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}


@end
