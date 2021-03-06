//
//  UIImage+XYImageExtension.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYImageExtension)
/**
 *  返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 *  返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;

/**
 *  返回一张圆角矩形图片
 */
- (instancetype)circleRectangleImage;

/**
 *  返回一张圆角矩形图片
 */
+ (instancetype)circleRectangleImageNamed:(NSString *)name;

@end
