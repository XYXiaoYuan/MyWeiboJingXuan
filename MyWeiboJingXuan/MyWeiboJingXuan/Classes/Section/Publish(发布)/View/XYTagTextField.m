//
//  XYTagTextField.m
//  bai
//
//  Created by yuan on 16/7/29.
//  Copyright (c) 2016年 袁小荣. All rights reserved.
//

#import "XYTagTextField.h"

@implementation XYTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 设置了占位文字内容以后, 才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.xy_height = XYTagH;
    }
    return self;
}

- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
}

@end
