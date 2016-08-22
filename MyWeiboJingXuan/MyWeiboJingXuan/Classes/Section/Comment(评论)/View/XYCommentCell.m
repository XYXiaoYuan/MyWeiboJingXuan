//
//  XYCommentCell.m
//  bai
//
//  Created by yuan on 15/11/24.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYCommentCell.h"
#import "XYCommentItem.h"
#import "XYUserItem.h"

@interface XYCommentCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 性别 */
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
/** 用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
/** 点赞数 */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 声音按钮 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation XYCommentCell

- (void)setComment:(XYCommentItem *)comment
{
    _comment = comment;
    
    // 头像
    [self.profileImageView setHeader:comment.user.profile_image];
    
    // 性别
    NSString *sexImageName = [comment.user.sex isEqualToString:XYUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image = [UIImage imageNamed:sexImageName];
    
    // 用户名
    self.usernameLabel.text = comment.user.username;
    
    // 点赞数
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    // 评论内容
    self.contentLabel.text = comment.content;
    if (comment.voiceuri.length) {
        // 有评论显示
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    } else {
        // 没有评论隐藏
        self.voiceButton.hidden = YES;
    }
}

- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

@end
