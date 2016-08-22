//
//  XYNavigationController.m
//  bai
//
//  Created by yuan on 15/11/9.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYNavigationController.h"

@interface XYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条的背景图片
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置侧滑手势的代理
    self.interactivePopGestureRecognizer.delegate = self;
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断当前是不是根控制器
    if (self.childViewControllers.count > 0) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        
        // 设置文字正常状态下的颜色
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置文字高亮状态下的颜色
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        
        // 设置按钮的图片
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        // 设置按钮尺寸
        [backButton sizeToFit];
        
        // 设置按钮的内边距
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        // 给按钮添加点击事件
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 把自定义按钮设置在左边的leftBarButton上
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        // push时隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


#pragma mark - UIGestureRecognizerDelegate
/**
 *  每当用户触发(返回手势)时都会调用这个方法
 *  @return 返回值:返回YES,手势有效;返回NO,手势失效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 如果当前显示的是第一个子控制器,就应该禁止掉(返回手势)
    return self.childViewControllers.count > 1;
}

@end
