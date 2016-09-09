//
//  XYSettingViewController.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/9.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYSettingViewController.h"
#import "XYWebViewController.h"

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
    item3.operation = ^(){
        XYWebViewController *webVc = [[XYWebViewController alloc] init];
        webVc.url = [NSURL URLWithString:@"http://www.budejie.com/budejie/help.html"];
        [self.navigationController pushViewController:webVc animated:YES];
    };
    
    XYSettingItem *item4 = [XYSettingItem initWithTitle:@"当前版本: 4.3"];
    
    XYSettingArrowItem *item5 = [XYSettingArrowItem initWithTitle:@"关于我们"];
    item5.operation = ^(){
        XYWebViewController *webVc = [[XYWebViewController alloc] init];
        webVc.url = [NSURL URLWithString:@"http://www.budejie.com/budejie/aboutus.html?client=iphone&market=&ver=4.3&device=ios%20device&uid=&sex=m&udid=&mac=&openudid=0855398ed0cd64dd8ad14832ca16ccd1585ab719&asid=8E6ACD13-D8CC-42BC-B565-1640CAB44A06&jbk=1&appname=bs0315&1473404594"];
        [self.navigationController pushViewController:webVc animated:YES];
    };

    
    XYSettingArrowItem *item6 = [XYSettingArrowItem initWithTitle:@"隐私政策"];
    item6.operation = ^(){
        XYWebViewController *webVc = [[XYWebViewController alloc] init];
        webVc.url = [NSURL URLWithString:@"http://www.budejie.com/budejie/privacy.html?client=iphone&market=&ver=4.3&device=ios%20device&uid=&sex=m&udid=&mac=&openudid=0855398ed0cd64dd8ad14832ca16ccd1585ab719&asid=8E6ACD13-D8CC-42BC-B565-1640CAB44A06&jbk=1&appname=bs0315"];
        [self.navigationController pushViewController:webVc animated:YES];
    };
    
    XYSettingArrowItem *item7 = [XYSettingArrowItem initWithTitle:@"打分支持不得姐!"];
    item7.operation = ^(){
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/bai-si-bu-jie-zui-da-gao-xiao/id1093382986?mt=8"];
        [[UIApplication sharedApplication] openURL:url];

    };
    
    
    group.items = @[item1,item2,item3,item4,item5,item6,item7];
    [self.groups addObject:group];
}

@end
