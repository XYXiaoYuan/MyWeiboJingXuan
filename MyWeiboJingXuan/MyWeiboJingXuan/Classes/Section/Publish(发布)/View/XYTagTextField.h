//
//  XYTagTextField.h
//  MyWeiboJingXuan
//
//  Created by yuan on 16/7/29.
//  Copyright (c) 2016年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYTagTextField : UITextField

/** 按了删除键后的回调 */
@property (nonatomic, copy) void (^deleteBlock)();

@end
