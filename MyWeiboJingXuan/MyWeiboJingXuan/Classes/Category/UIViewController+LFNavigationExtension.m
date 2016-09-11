//
//  UIViewController+LFNavigationExtension.m
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/7/21.
//  Copyright © 2016年 YouXingChangYou. All rights reserved.
//

#import "UIViewController+LFNavigationExtension.h"
#import "LFNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (LFNavigationExtension)

- (BOOL)lf_fullScreenPopGestureEnabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLf_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled
{
    objc_setAssociatedObject(self, @selector(lf_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (LFNavigationController *)lf_navigationController
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLf_navigationController:(LFNavigationController *)navigationController
{
    objc_setAssociatedObject(self, @selector(lf_navigationController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}


@end
