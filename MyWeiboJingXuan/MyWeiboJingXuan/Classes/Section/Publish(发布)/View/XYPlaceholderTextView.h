//
//  XYPlaceholderTextView.h
//  MyWeiboJingXuan
//
//  Created by yuan on 16/7/29.
//  Copyright (c) 2016年 袁小荣. All rights reserved.
//  拥有占位文字功能的TextView

#import <UIKit/UIKit.h>

@interface XYPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
