//
//  UIImage+XYImageExtension.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "UIImage+XYImageExtension.h"

@implementation UIImage (XYImageExtension)
- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上面画一张图片
    [self drawInRect:rect];
    
    // 获得上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}


- (instancetype)circleRectangleImage
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
   
    // 2.描述正切于图片矩形的圆形
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:4];
    
    // 3.设置为裁剪区域
    [clipPath addClip];
    
    // 4.绘制图片
    [self drawAtPoint:CGPointZero];
    
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}


+ (instancetype)circleRectangleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleRectangleImage];
}



@end
