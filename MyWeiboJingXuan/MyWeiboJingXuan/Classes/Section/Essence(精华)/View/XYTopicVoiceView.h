//
//  XYTopicVoiceView.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/22.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTopicItem;

@interface XYTopicVoiceView : UIView
// 模型数据
@property(nonatomic,strong) XYTopicItem *topic;
/** 重置播放器 */
- (void)reset;
@end
