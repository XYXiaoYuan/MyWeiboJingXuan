//
//  XYLoginButton.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYVerticalButton.h"

@implementation XYVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

// 通过xib/storyboard创建的控件初始化的时候就会调用这个方法
- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


/**
 *  重新布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片的位置
    self.imageView.xy_x = 0;
    self.imageView.xy_y = 0;
    self.imageView.xy_width = self.xy_width;
    self.imageView.xy_height = self.imageView.xy_width;
    
    
    // 调整文字的位置
    self.titleLabel.xy_x = 0;
    self.titleLabel.xy_y = self.imageView.xy_height;
    self.titleLabel.xy_width = self.xy_width;
    self.titleLabel.xy_height = self.xy_height - self.titleLabel.xy_y;
    
}


@end
