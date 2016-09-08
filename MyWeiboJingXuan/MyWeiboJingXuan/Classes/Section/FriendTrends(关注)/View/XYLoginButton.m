//
//  XYLoginButton.m
//  bai
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYLoginButton.h"

@implementation XYLoginButton

// 通过xib/storyboard创建的控件初始化的时候就会调用这个方法
- (void)awakeFromNib
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
    self.imageView.xy_y = 0;
    self.imageView.xy_centerX = self.xy_width * 0.5;
    
    
    // 调整文字的位置
    self.titleLabel.xy_x = 0;
    self.titleLabel.xy_y = self.xy_height * 0.8;
    self.titleLabel.xy_width = self.xy_width;
    self.titleLabel.xy_height = self.xy_height - self.imageView.xy_height;
    
}


@end
