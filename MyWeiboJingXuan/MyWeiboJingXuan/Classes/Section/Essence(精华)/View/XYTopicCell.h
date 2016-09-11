//
//  XYTopicCell.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTopicItem;

@interface XYTopicCell : UITableViewCell

// 模型数据
@property(nonatomic,strong) XYTopicItem *topic;
/** 评论点击的block */
@property(nonatomic,copy) void(^commentBlock)();

@end
