//
//  XYSettingViewController.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/9.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYSettingViewController.h"
#import <SVProgressHUD.h>
#import "XYWebViewController.h"
#import "XYCacheFileTool.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


@interface XYSettingViewController ()
/** 缓存总大小 */
@property (nonatomic, assign) NSInteger totalSize;
/** XYSettingArrowItem */
@property(nonatomic,strong) XYSettingArrowItem *cacheItem;
@end

@implementation XYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.配置第0组模型
    [self setupGroup1];
    
    // 2.配置第1组模型
    [self setupGroup2];
    
    // 3.计算缓存大小
    [self calculateFileCacheSize];
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
    // 定义weakSelf
    XYWeakSelf;
    
    XYSettingGroupItem *group = [[XYSettingGroupItem alloc] init];
    group.headTitle = @"其他";
    
    XYSettingArrowItem *item1 = [XYSettingArrowItem initWithTitle:@"清除缓存"];
    self.cacheItem = item1;

    // 点击消除缓存
    __weak __typeof(item1)weakCacheItem = item1;
    item1.operation = ^(){
        [XYCacheFileTool removeDirectoryPath:CachePath];
        
        NSString *showStr = [NSString stringWithFormat:@"清除缓存了%@",[weakSelf sizeStr]];
        [SVProgressHUD showSuccessWithStatus:showStr];
        
        // 把缓存尺寸大小置为0
        weakSelf.totalSize = 0;
        weakCacheItem.subTitle = @"暂无缓存";
        [weakSelf.tableView reloadData];
    };
    
    XYSettingArrowItem *item2 = [XYSettingArrowItem initWithTitle:@"推荐给朋友"];
    
    XYSettingArrowItem *item3 = [XYSettingArrowItem initWithTitle:@"帮助"];
    item3.operation = ^(){
        XYWebViewController *webVc = [[XYWebViewController alloc] init];
        webVc.url = [NSURL URLWithString:@"http://www.budejie.com/budejie/help.html"];
        [weakSelf.navigationController pushViewController:webVc animated:YES];
    };
    
    XYSettingItem *item4 = [XYSettingItem initWithTitle:@"当前版本: 4.3"];
    
    XYSettingArrowItem *item5 = [XYSettingArrowItem initWithTitle:@"关于我们"];
    item5.operation = ^(){
        XYWebViewController *webVc = [[XYWebViewController alloc] init];
        webVc.url = [NSURL URLWithString:@"http://www.budejie.com/budejie/aboutus.html?client=iphone&market=&ver=4.3&device=ios%20device&uid=&sex=m&udid=&mac=&openudid=0855398ed0cd64dd8ad14832ca16ccd1585ab719&asid=8E6ACD13-D8CC-42BC-B565-1640CAB44A06&jbk=1&appname=bs0315&1473404594"];
        [weakSelf.navigationController pushViewController:webVc animated:YES];
    };

    
    XYSettingArrowItem *item6 = [XYSettingArrowItem initWithTitle:@"隐私政策"];
    item6.operation = ^(){
        XYWebViewController *webVc = [[XYWebViewController alloc] init];
        webVc.url = [NSURL URLWithString:@"http://www.budejie.com/budejie/privacy.html?client=iphone&market=&ver=4.3&device=ios%20device&uid=&sex=m&udid=&mac=&openudid=0855398ed0cd64dd8ad14832ca16ccd1585ab719&asid=8E6ACD13-D8CC-42BC-B565-1640CAB44A06&jbk=1&appname=bs0315"];
        [weakSelf.navigationController pushViewController:webVc animated:YES];
    };
    
    XYSettingArrowItem *item7 = [XYSettingArrowItem initWithTitle:@"打分支持不得姐!"];
    item7.operation = ^(){
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/bai-si-bu-jie-zui-da-gao-xiao/id1093382986?mt=8"];
        [[UIApplication sharedApplication] openURL:url];

    };
    
    
    group.items = @[item1,item2,item3,item4,item5,item6,item7];
    [self.groups addObject:group];
}

#pragma mark - 3.计算缓存大小
- (void)calculateFileCacheSize
{
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸...."];
    
    // 获取文件夹尺寸
    // 文件夹非常小,如果我的文件非常大
    XYWeakSelf;
    __weak __typeof(_cacheItem)weakCacheItem = _cacheItem;
    [XYCacheFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        
        weakSelf.totalSize = totalSize;
        
        weakCacheItem.subTitle = [weakSelf sizeStr];
        [weakSelf.tableView reloadData];
        
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - 获取缓存尺寸大小字符串
- (NSString *)sizeStr
{
    NSInteger totalSize = _totalSize;
    NSString *sizeStr = @"";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@%.1fMB",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@%.1fKB",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@%.ldB",sizeStr,totalSize];
    }
    
    return sizeStr;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

@end
