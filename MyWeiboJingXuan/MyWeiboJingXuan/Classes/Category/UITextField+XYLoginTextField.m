//
//  UITextField+XYLoginTextField.m
//  bai
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "UITextField+XYLoginTextField.h"

#define XYPlaceholderColorKey @"_placeholderLabel.textColor"

@implementation UITextField (XYLoginTextField)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    // 恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:XYPlaceholderColorKey];
}

- (UIColor *)placeholderColor
{
    return [self valueForKey:XYPlaceholderColorKey];
}

@end
