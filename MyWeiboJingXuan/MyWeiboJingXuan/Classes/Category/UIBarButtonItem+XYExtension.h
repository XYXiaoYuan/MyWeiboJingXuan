//
//  UIBarButtonItem+XYExtension.h
//  baisi
//
//  Created by yuan on 15/10/20.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XYExtension)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;

@end
