//
//  XYCommentCell.m
//  MyWeiboJingXuan
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

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}


#pragma mark - commentItem的set方法
- (void)setCommentItem:(XYCommentItem *)commentItem
{
    _commentItem = commentItem;
    
    // 头像
    [self.profileImageView setHeader:commentItem.user.profile_image];
    
    // 性别
    NSString *sexImageName = [commentItem.user.sex isEqualToString:XYUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image = [UIImage imageNamed:sexImageName];
    
    // 用户名
    self.usernameLabel.text = commentItem.user.username;
    
    // 点赞数
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",commentItem.like_count];
    
    // 评论内容
    self.contentLabel.text = commentItem.content;
    if (commentItem.voiceuri.length) {
        // 有评论显示
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",commentItem.voicetime] forState:UIControlStateNormal];
    } else {
        // 没有评论隐藏
        self.voiceButton.hidden = YES;
    }
}


@end
