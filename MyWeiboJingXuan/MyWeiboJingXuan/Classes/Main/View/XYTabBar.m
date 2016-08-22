//
//  XYTabBar.m
//  bai
//
//  Created by yuan on 15/11/9.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTabBar.h"



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
    
    // 设置按钮的中心点
    
    // 定义索引
    int index = 0;
    
    self.publishButton.center = CGPointMake(self.xy_width * 0.5, self.xy_height * 0.5);
    
    CGFloat tabBarButtonY = 0;
    CGFloat tabBarButtonW = self.xy_width / 5;
    CGFloat tabBarButtonH = self.xy_height;
    for (UIView *tabBarButton in self.subviews)
    {
        // 判断当前控件是不是UITabBarButton,如果不是,那么跳当前循环,继续下一循环
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        // 在这里设置发布按钮的frame
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


@end
