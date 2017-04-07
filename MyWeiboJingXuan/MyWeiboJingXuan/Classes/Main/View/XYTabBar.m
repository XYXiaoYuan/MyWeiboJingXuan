//
//  XYTabBar.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/9.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTabBar.h"
#import "XYPublishViewController.h"


@interface XYTabBar ()

/** 发布按钮 */
@property(nonatomic,weak) UIButton *publishButton;

@end

@implementation XYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置tabBar的背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        // 自定义中间的发布按钮
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        // 设置按钮普通状态下的图片
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        // 设置按钮高亮状态下的图片
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        // 给按钮添加点击事件
        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮的图片尺寸大小自适应
        [publishBtn sizeToFit];
        
        // 把按钮赋值给创建好的属性
        _publishButton = publishBtn;
        
        // 把创建好的按钮添加到tabBar上
        [self addSubview:publishBtn];
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    // 设置中间加号按钮的中心点
    self.publishButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    CGFloat tabBarButtonY = 0;
    CGFloat tabBarButtonW = self.bounds.size.width * 0.2;
    CGFloat tabBarButtonH = self.bounds.size.height;
    // 定义索引
    NSInteger index = 0;
    for (UIButton *tabBarButton in self.subviews)
    {
        // 判断当前控件是不是UITabBarButton,如果不是,那么跳当前循环,继续下一循环
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        // 在这里设置tabBar按钮的frame
        CGFloat tabBarButtonX = tabBarButtonW * index;
        
        // 如果是第3个位置,那么 tabBarButtonX 加一个 tabBarButtonW
        if (index >= 2){
            tabBarButtonX += tabBarButtonW;
        }
        
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        
        // 索引增加
        index++;
        
    }
}

#pragma mark - 中间tabBar的点击事件处理
- (void)publishClick
{
    XYPublishViewController *publish = [[XYPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
}


@end
