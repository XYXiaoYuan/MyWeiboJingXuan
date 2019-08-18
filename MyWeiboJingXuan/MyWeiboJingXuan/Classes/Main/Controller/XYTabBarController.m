//
//  XYTabBarController.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/9.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTabBarController.h"

#import "XYEssenceViewController.h"
#import "XYNewViewController.h"
#import "XYFriendTrednsViewController.h"
#import "XYMineViewController.h"

#import "XYTabBar.h"

#import "LFNavigationController.h"



@interface XYTabBarController ()

@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置所有控制器
    [self setupAllViewControllers];
    
    // 2.设置tabBar的字体属性
    [self setupTabBarAttrs];
    
    // 3.自定义tabBar
    [self setupTabBar];
}

#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    [self setValue:[[XYTabBar alloc] init] forKeyPath:@"tabBar"];
}

#pragma mark - 设置tabBar上的字体属性
- (void)setupTabBarAttrs
{
    // 正常状态下的文字
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    // 选中状态下的文字
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    // 统一设置文字的正常和选中状态下的属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
}


#pragma mark - 创建所有的子控制器
- (void)setupAllViewControllers
{
    // 精华
    [self setupOneViewController:[[XYEssenceViewController alloc] init] image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    // 新帖
    [self setupOneViewController:[[XYNewViewController alloc] init] image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"] title:@"新帖"];
    
    // 关注
    [self setupOneViewController:[[XYFriendTrednsViewController alloc] init] image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    
    // 我的
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([XYMineViewController class]) bundle:nil];
    // 加载箭头指向控制器
    XYMineViewController *mineVc = [storyboard instantiateInitialViewController];
    [self setupOneViewController:mineVc image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"] title:@"我的"];
}
    
    
#pragma mark - 创建一个子控制器
- (void)setupOneViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    // 创建导航控制器并且设置对应的vc为其根控制器
    LFNavigationController *nav = [[LFNavigationController alloc] initWithRootViewController:vc];
    
    // 设置tabBar的文字和图片
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = selectedImage;
    
    // 将创建好的导航控制器添加为 XYTabBarController 的子控制器
    [self addChildViewController:nav];
    
    nav.fullScreenPopGestureEnabled = YES;
    // 到此主流框架搭建完毕
    
}
    
    
@end
