//
//  XYCommentViewController.h
//  bai
//
//  Created by yuan on 15/11/23.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTopicItem;
@interface XYCommentViewController : UIViewController

/** 帖子数据模型 */
@property(nonatomic,strong) XYTopicItem *topic;


@end
