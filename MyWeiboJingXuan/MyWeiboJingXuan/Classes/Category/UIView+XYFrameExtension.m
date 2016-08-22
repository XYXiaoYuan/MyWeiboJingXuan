//
//  UIView+XYFrameExtension.m
//  budejie
//
//  Created by yuan on 15/11/6.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "UIView+XYFrameExtension.h"

@implementation UIView (XYFrameExtension)

// 加载xib
+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

// 宽度
- (CGFloat)xy_width
{
    return self.bounds.size.width;
}
- (void)setXy_width:(CGFloat)xy_width
{
    CGRect frame = self.frame;
    frame.size.width = xy_width;
    self.frame = frame;
}

// 高度
- (CGFloat)xy_height
{
    return self.bounds.size.height;
}
- (void)setXy_height:(CGFloat)xy_height
{
    CGRect frame = self.frame;
    frame.size.height = xy_height;
    self.frame = frame;
}

// x
- (CGFloat)xy_x
{
    return self.frame.origin.x;
}
- (void)setXy_x:(CGFloat)xy_x
{
    CGRect frame = self.frame;
    frame.origin.x = xy_x;
    self.frame = frame;
    
}

// y
- (CGFloat)xy_y
{
    return self.frame.origin.y;
}
- (void)setXy_y:(CGFloat)xy_y
{
    CGRect frame = self.frame;
    frame.origin.y = xy_y;
    self.frame = frame;
    
}


- (void)setXy_centerX:(CGFloat)xy_centerX{
    CGPoint center = self.center;
    center.x = xy_centerX;
    self.center = center;
}

- (CGFloat)xy_centerX
{
    return self.center.x;
}

- (void)setXy_centerY:(CGFloat)xy_centerY{
    CGPoint center = self.center;
    center.y = xy_centerY;
    self.center = center;
}

- (CGFloat)xy_centerY
{
    return self.center.y;
}


@end
