//
//  XYRefreshNormalHeader.m
//  bai
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYRefreshGifHeader.h"

@implementation XYRefreshGifHeader

- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImagesArray = [NSMutableArray arrayWithCapacity:1];
    UIImage *idleImage = [UIImage imageNamed:@"bdj_mj_refresh_2"];
    [idleImagesArray addObject:idleImage];
    [self setImages:idleImagesArray forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImagesArray = [NSMutableArray arrayWithCapacity:1];
    UIImage *pullingImage = [UIImage imageNamed:@"bdj_mj_refresh_1"];
    [pullingImagesArray addObject:pullingImage];
    [self setImages:pullingImagesArray forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImagesArray = [NSMutableArray arrayWithCapacity:1];
    UIImage *refreshingImage = [UIImage imageNamed:@"bdj_mj_refresh_3"];
    [refreshingImagesArray addObject:refreshingImage];
    [self setImages:refreshingImagesArray forState:MJRefreshStateRefreshing];
    
    // 设置文字
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    
    
}

@end
