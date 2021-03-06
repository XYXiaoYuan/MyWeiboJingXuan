//
//  UIView+XYFrameExtension.h
//  budejie
//
//  Created by yuan on 15/11/6.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYFrameExtension)

@property (nonatomic, assign) CGFloat xy_width;
@property (nonatomic, assign) CGFloat xy_height;
@property (nonatomic, assign) CGFloat xy_x;
@property (nonatomic, assign) CGFloat xy_y;
@property(nonatomic,assign) CGFloat xy_centerX;
@property(nonatomic,assign) CGFloat xy_centerY;
@property (nonatomic, assign) CGSize xy_size;


+ (instancetype)viewFromXib;
#pragma mark - 插入view
- (BOOL)intersectWithView:(UIView *)view;
#pragma mark - 切圆角
- (void)lf_setUpAllCornerWithChildView:(UIView *)child;

@end
