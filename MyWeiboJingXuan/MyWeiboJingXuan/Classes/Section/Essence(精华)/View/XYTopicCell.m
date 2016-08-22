//
//  XYTopicCell.m
//  bai
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTopicCell.h"
#import "XYTopicItem.h"

#import "XYUserItem.h"
#import "XYCommentItem.h"

#import "XYTopicVideoView.h"
#import "XYTopicVoiceView.h"
#import "XYTopicPictureView.h"

@interface XYTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *created_atLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

// 声音,视频,图片的view
/** 声音 */
@property(nonatomic,weak) XYTopicVoiceView *voiceView;
/**  */
@property(nonatomic,weak) XYTopicPictureView *pictureView;
/** 声音 */
@property(nonatomic,weak) XYTopicVideoView *videoView;

@end

@implementation XYTopicCell

// 从队列里面复用时调用
- (void)prepareForReuse {
    
    [super prepareForReuse];
    [_videoView reset];
    [_voiceView reset];
}


#pragma mark - 懒加载
/** voiceView */
- (XYTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        XYTopicVoiceView *voiceView = [XYTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

/** _videoView */
- (XYTopicVideoView *)videoView
{
    if (_videoView == nil) {
        XYTopicVideoView *videoView = [XYTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

/** pictureView */
- (XYTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        XYTopicPictureView *pictureView = [XYTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}


/**
 *  设置模型
 */
- (void)setTopic:(XYTopicItem *)topic
{
    _topic = topic;
    
    [self.profile_imageImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.created_atLabel.text = topic.created_at;
    self.text_Label.text = topic.text;

    [self setButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    // 最热评论
    if (topic.top_cmt) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        // 面向模型开发
        NSString *username = topic.top_cmt.user.username; // 用户名
        NSString *content = topic.top_cmt.content; // 评论内容
        
        // 语音评论
        if (topic.top_cmt.voiceuri.length) {
            content = @"语音评论";
        }
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    }else{ // 没有最热评论
        self.topCmtView.hidden = YES;
    }


    // 中间内容
    if (topic.type == XYTopicTypePicture) { // 图片
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.contentF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    } else if (topic.type == XYTopicTypeVoice){ // 音频
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.contentF;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;

        
    } else if (topic.type == XYTopicTypeVideo){ // 视频
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.contentF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;

    } else if (topic.type == XYTopicTypeWord){ // 段子
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        
    }
}

- (void)setButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib
{
    // 设置背景图片,cell会模糊
//    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}


/** 重写setFrame,先覆盖然后让cell自己调用计算 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= XYCommonMargin;
    frame.origin.y += XYCommonMargin;
    
    [super setFrame:frame];
}

- (IBAction)more
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        XYLog(@"收藏");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        XYLog(@"举报");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        XYLog(@"取消");
    }]];
    
    // 展示
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}



@end
