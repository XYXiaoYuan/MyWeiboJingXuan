//
//  XYNavSelectedView.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//  精华/新帖 导航的顶部选择视图

#import <UIKit/UIKit.h>

// 定义一个枚举,存储不同的帖子枚举类型
typedef NS_ENUM(NSUInteger, XYNavType)  {
    /** 全部 */
    XYNavTypeTypeAll,
    /** 视频 */
    XYNavTypeTypeVideo,
    /** 声音 */
    XYNavTypeTypeVoice,
    /** 图片 */
    XYNavTypeTypePicture,
    /** 段子 */
    XYNavTypeTypeWord
} ;


@interface XYNavSelectedView : UIView
/** 选中了 */
@property(nonatomic, copy) void (^selectedBlock)(XYNavType type);
/** 下划线 */
@property (nonatomic, weak, readonly) UIView *underLine;
/** 设置滑动选中的按钮 */
@property(nonatomic, assign) XYNavType selectedType;
@end
