//
//  XYTitleButton.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYTitleButton.h"

@implementation XYTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 按钮的一些初始化操作可以在这里进行
        // 设置文字颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}


// 重写highlight方法,取消高亮状态的按钮点击效果
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
