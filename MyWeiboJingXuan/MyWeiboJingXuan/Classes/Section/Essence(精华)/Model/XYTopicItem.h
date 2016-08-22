//
//  XYTopic.h
//  baisi
//
//  Created by yuan on 15/11/12.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义一个枚举,存储不同的帖子枚举类型
typedef NS_ENUM(NSUInteger, XYTopicType)  {
    /** 全部 */
    XYTopicTypeAll = 1,
    /** 图片 */
    XYTopicTypePicture = 10,
    /** 段子 */
    XYTopicTypeWord = 29,
    /** 声音 */
    XYTopicTypeVoice = 31,
    /** 视频 */
    XYTopicTypeVideo = 41
    // 	1为全部，10为图片，29为段子，31为音频，41为视频，默认为10
} ;


@class XYCommentItem;
@interface XYTopicItem : NSObject

// 用户 -- 发帖者
/** id */
@property(nonatomic,copy) NSString *ID;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 最热评论 */
@property(nonatomic,strong) XYCommentItem *top_cmt;

/** 类型 */
@property(nonatomic,assign) XYTopicType type;

/** 文字宽度 */
@property(nonatomic,assign) NSInteger width;

/** 文字高度 */
@property(nonatomic,assign) NSInteger height;

/********  关于图片的大小   **********/
/** 小图 */
@property(nonatomic,copy) NSString *small_image;
/** 中图 */
@property(nonatomic,copy) NSString *middle_image;
/** 大图 */
@property(nonatomic,copy) NSString *big_image;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频的播放地址 */
@property (copy, nonatomic) NSString *voiceuri;

/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频的播放地址 */
@property (copy, nonatomic) NSString *videouri;

/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;


/*************    增加额外的属性,方便开发    ***************/
/** cell的高度 */
@property(nonatomic,assign) NSInteger cellHeight;
/** 中间内容的frame */
@property(nonatomic,assign) CGRect contentF;
/** 是否为大图 */
@property(nonatomic,assign,getter=isBigPicture) BOOL bigPicture;
/** 是否为gif图 */
@property(nonatomic,assign) BOOL is_gif;

@end
