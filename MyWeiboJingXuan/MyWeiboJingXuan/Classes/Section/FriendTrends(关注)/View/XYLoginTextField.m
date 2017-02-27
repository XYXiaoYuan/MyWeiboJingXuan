//
//  XYLoginTextField.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYLoginTextField.h"

@implementation XYLoginTextField

- (void)awakeFromNib
{
    [super awakeFromNib];

    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    self.placeholderColor = self.textColor;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.placeholderColor = [UIColor grayColor];
     return [super resignFirstResponder];
}

@end
