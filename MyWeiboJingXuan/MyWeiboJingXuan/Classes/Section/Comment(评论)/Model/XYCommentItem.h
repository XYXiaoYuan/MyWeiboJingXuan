//
//  XYComment.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/20.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYUserItem;

@interface XYCommentItem : NSObject

/** 评论内容 */
@property(nonatomic,strong) NSString *content;
/** 用户 */
@property(nonatomic,strong) XYUserItem *user;
/** id */
@property(nonatomic,strong) NSString *ID;
/** 被点赞数 */
@property(nonatomic,assign) NSInteger like_count;
/** 音频文件的时长 */
@property(nonatomic,assign) NSInteger voicetime;
/** 音频文件的url */
@property(nonatomic,strong) NSString *voiceuri;

@end
