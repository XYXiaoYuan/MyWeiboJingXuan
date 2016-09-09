//
//  UIBarButtonItem+XYExtension.m
//  baisi
//
//  Created by yuan on 15/10/20.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "UIBarButtonItem+XYExtension.h"

@implementation UIBarButtonItem (XYExtension)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button  setImage:highlightImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 这里用self
    return [[self alloc] initWithCustomView:button];
    
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button  setImage:selectedImage forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 这里用self
    return [[self alloc] initWithCustomView:button];
    
}


@end
