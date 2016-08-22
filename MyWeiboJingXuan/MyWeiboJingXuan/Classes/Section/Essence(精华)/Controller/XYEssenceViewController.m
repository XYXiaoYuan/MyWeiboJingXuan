//
//  XYEssenceViewController.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYEssenceViewController.h"
#import "XYTagViewController.h"
#import "XYNavSelectedView.h"

@interface XYEssenceViewController ()
/** 导航栏选择视图 */
@property(nonatomic,strong) XYNavSelectedView *selectedView;
/** UIScrollView */
@property(nonatomic, weak) UIScrollView *scrollView;
@end

@implementation XYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupNav];

    
}

#pragma mark -   设置导航条
- (void)setupNav
{
    // 设置导航条左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    
    // 设置顶部选择视图
    XYNavSelectedView *selectedView = [[XYNavSelectedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    selectedView.xy_x = 45;
    selectedView.xy_width = XYSCREEN_W - 45 * 2;
    [selectedView setSelectedBlock:^(XYNavType type) {
        [self.scrollView setContentOffset:CGPointMake(type * XYSCREEN_W, 0) animated:YES];
    }];
    [self.navigationController.navigationBar addSubview:selectedView];
    _selectedView = selectedView;
}

#pragma mark - 标签按钮的点击
- (void)tagClick
{
    XYTagViewController *tag = [[XYTagViewController alloc] init];
    
    [self.navigationController pushViewController:tag animated:YES];
}

@end
