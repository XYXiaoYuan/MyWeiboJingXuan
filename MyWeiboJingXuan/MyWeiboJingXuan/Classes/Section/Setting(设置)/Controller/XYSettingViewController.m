//
//  XYSettingViewController.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/9.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYSettingViewController.h"

@interface XYSettingViewController ()

@end

@implementation XYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.配置第0组模型
    [self setupGroup1];
    
    // 2.配置第1组模型
    [self setupGroup2];

}

#pragma mark - 1.配置第1组模型
- (void)setupGroup1
{
    XYSettingGroupItem *group = [[XYSettingGroupItem alloc] init];
    group.headTitle = @"功能设置";
    
    XYSettingArrowItem *item1 = [XYSettingArrowItem initWithTitle:@"字体大小"];
    XYSettingSwitchItem *item2 = [XYSettingSwitchItem initWithTitle:@"摇一摇夜间模式"];
    
    group.items = @[item1,item2];
    [self.groups addObject:group];
}

#pragma mark - 2.配置第2组模型
- (void)setupGroup2
{
    XYSettingGroupItem *group = [[XYSettingGroupItem alloc] init];
    group.headTitle = @"其他";
    
    XYSettingArrowItem *item1 = [XYSettingArrowItem initWithTitle:@"清除缓存"];
    XYSettingArrowItem *item2 = [XYSettingArrowItem initWithTitle:@"推荐给朋友"];
    XYSettingArrowItem *item3 = [XYSettingArrowItem initWithTitle:@"帮助"];
    XYSettingItem *item4 = [XYSettingItem initWithTitle:@"当前版本: 4.3"];
    XYSettingArrowItem *item5 = [XYSettingArrowItem initWithTitle:@"关于我们"];
    XYSettingArrowItem *item6 = [XYSettingArrowItem initWithTitle:@"隐私政策"];
    XYSettingArrowItem *item7 = [XYSettingArrowItem initWithTitle:@"打分支持不得姐"];
    
    
    group.items = @[item1,item2,item3,item4,item5,item6,item7];
    [self.groups addObject:group];
}

@end
