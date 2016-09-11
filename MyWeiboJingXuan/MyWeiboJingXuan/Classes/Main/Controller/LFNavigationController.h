//
//  LFNavigationController.h
//  LeFly
//
//  Created by 袁小荣 on 16/7/21.
//  Copyright © 2016年 YouXingChangYou. All rights reserved.
//  自定义的导航控制器

#import <UIKit/UIKit.h>

@interface LFWrapViewController : UIViewController

/** 传进来的被包装的控制器 */
@property (nonatomic, strong, readonly) UIViewController *rootViewController;

/** 将传进来的控制器用导航控制器 ----> 解决懒加载问题 --> 将类工厂方法改成对象方法*/
- (LFWrapViewController *)wrapViewController:(UIViewController *)viewController;
//+ (LFWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;
@end

@interface LFNavigationController : UINavigationController
/** 返回按钮图片 */
@property (nonatomic, strong) UIImage *backButtonImage;
/** 全屏右滑返回手势是否可用 */
@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;
/** 栈里传进被包装的控制器数组 */
@property (nonatomic, copy, readonly) NSArray *lf_viewControllers;
@end
