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

#import "XYAllViewController.h"
#import "XYVideoViewController.h"
#import "XYVoiceViewController.h"
#import "XYPictureViewController.h"
#import "XYWordViewController.h"

@interface XYEssenceViewController ()
/** 导航栏选择视图 */
@property(nonatomic,strong) XYNavSelectedView *selectedView;
/** 把其它的子控制器加到scrollView中  */
@property(nonatomic, weak) UIScrollView *scrollView;
@end

@implementation XYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupNav];
    
    // 创建所有的控制器
    [self seupAllChildViewControllers];

    // 设置scrollView
    [self setupScrollView];

    // 设置默认加载XYAllViewController
    [self addChildVc];
}

#pragma mark - 设置scrollView
- (void)setupScrollView
{
    // 取消自动调整额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.frame = self.view.bounds;
    // 设置代理
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 加载所有的子控制器
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.xy_width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

#pragma mark - 设置所有的子控制器
- (void)seupAllChildViewControllers
{
    XYAllViewController *all = [[XYAllViewController alloc] init];
    [self addChildViewController:all];
    
    XYVideoViewController *video = [[XYVideoViewController alloc] init];
    [self addChildViewController:video];
    
    XYVoiceViewController *voice = [[XYVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    XYPictureViewController *picture = [[XYPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    XYWordViewController *word = [[XYWordViewController alloc] init];
    [self addChildViewController:word];
}

#pragma mark - <UIScrollViewDelegate>
// 当我们的手指停止滚动的调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVc];
}

// 我们利用代码手动让它移动到对应的子控制器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 调用里面的block,改变偏移量,加载对应的控制器
    XYWeakSelf;
    [self.selectedView setSelectedBlock:^(XYNavType type) {
        [weakSelf.scrollView setContentOffset:CGPointMake(type * self.scrollView.xy_width,0) animated:YES];
    }];
    
    [self addChildVc];
}


#pragma mark - 添加子控制器的view
- (void)addChildVc
{
    // 计算当前子控制器的索引
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.xy_width;
    UIViewController *childVc = self.childViewControllers[index];
    
    
    // 如果当前view加载过,那么就不再加载,直接返回
    if ([childVc isViewLoaded]) return;
    
    // scrollView的bounds 就是子控制器的frame
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
    
}


#pragma mark -   设置导航条
- (void)setupNav
{
    // 设置导航条左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    
    // 设置顶部选择视图
    XYNavSelectedView *selectedView = [[XYNavSelectedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    selectedView.xy_x = 45 * XYWidthRatio;
    selectedView.xy_width = XYSCREEN_W - selectedView.xy_x;
    [selectedView setSelectedBlock:^(XYNavType type) {
        [self.scrollView setContentOffset:CGPointMake(type * XYSCREEN_W, 0) animated:YES];
    }];
    self.navigationItem.titleView = selectedView;
    _selectedView = selectedView;
}

#pragma mark - 标签按钮的点击
- (void)tagClick
{
    XYTagViewController *tag = [[XYTagViewController alloc] init];
    
    [self.navigationController pushViewController:tag animated:YES];
}

@end
