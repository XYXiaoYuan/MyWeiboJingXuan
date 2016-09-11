//
//  UIViewController+LFNavigationExtension.h
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/7/21.
//  Copyright © 2016年 YouXingChangYou. All rights reserved.
//  设置控制器的是否支持全屏手势 

#import <UIKit/UIKit.h>

@class LFNavigationController;

@interface UIViewController (LFNavigationExtension)
/** 全屏右滑返回手势是否可用 */
@property (nonatomic, assign) BOOL lf_fullScreenPopGestureEnabled;
/** 每个VC外包的导航控制器 */
@property (nonatomic, weak) LFNavigationController *lf_navigationController;
@end
