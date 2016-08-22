//
//  XYEssenceViewController.m
//  bai
//
//  Created by yuan on 15/11/9.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYEssenceViewController.h"
#import "XYTagViewController.h"
#import "XYTitleButton.h"

#import "XYAllViewController.h"
#import "XYVideoViewController.h"
#import "XYVoiceViewController.h"
#import "XYPictureViewController.h"
#import "XYWordViewController.h"


@interface XYEssenceViewController () <UIScrollViewDelegate>
/** 底部的横线view */
@property(nonatomic,weak) UIView *indicatorView;
/** 选中的按钮 */
@property(nonatomic,weak) XYTitleButton *selectedTitleButton;
/** 把其它的子控制器加到scrollViewK  */
@property(nonatomic,weak) UIScrollView *scrollView;
/** 标题view */
@property(nonatomic,weak) UIView *titlesView;
@end

@implementation XYEssenceViewController

#pragma mark - 程序view刚加载的是时候调用 viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupNav];
    
    // 创建所有的控制器
    [self seupAllChildViewControllers];
    
    // 设置scrollView
    [self setupScrollView];
    
    // 设置按钮文字
    [self setuptitlesView];
    
    // 设置默认加载XYAllViewController
    [self addChildVc];
    
}

#pragma mark - 设置所有的子控制器
- (void)seupAllChildViewControllers
{
    XYAllViewController *all = [[XYAllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    XYVideoViewController *video = [[XYVideoViewController alloc] init];
    all.title = @"视频";
    [self addChildViewController:video];
    
    XYVoiceViewController *voice = [[XYVoiceViewController alloc] init];
    all.title = @"声音";
    [self addChildViewController:voice];
    
    XYPictureViewController *picture = [[XYPictureViewController alloc] init];
    all.title = @"图片";
    [self addChildViewController:picture];
    
    XYWordViewController *word = [[XYWordViewController alloc] init];
    all.title = @"段子";
    [self addChildViewController:word];
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

#pragma mark - 设置标题按钮
- (void)setuptitlesView
{
    // 标签栏的整体view
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(44 * XYWidthRatio, 20, XYSCREEN_W - 44 * XYWidthRatio, 44);
    self.navigationItem.titleView = titlesView;
    self.titlesView = titlesView;

    // 标签栏按钮
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSInteger count = titles.count;
    // 几个frame值
    CGFloat titleButtonW = (self.view.xy_width - 44 * XYWidthRatio) / count;
    CGFloat titleButtonH = titlesView.xy_height;
    
    for (NSInteger i = 0; i < count; i++) {
        // 创建按钮
        XYTitleButton *titleButton = [XYTitleButton buttonWithType:UIButtonTypeCustom];
        
        // 绑定tag
        titleButton.tag = i;
        
        // 把创建的按钮添加到view中
        [titlesView addSubview:titleButton];
        
        // 设置文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];

        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
        // 给按钮添加点击事件
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 添加底部的指示器红色横线
    XYTitleButton *firstTitleButotn = titlesView.subviews.firstObject;
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButotn titleColorForState:UIControlStateSelected];
    indicatorView.xy_height = 2;
    indicatorView.xy_y = titlesView.xy_height - indicatorView.xy_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 根据lable的宽度计算出指示条的宽度
    [firstTitleButotn.titleLabel sizeToFit];
    indicatorView.xy_width = firstTitleButotn.titleLabel.xy_width;
    indicatorView.xy_centerX = firstTitleButotn.xy_centerX;
    
    // 默认情况下: 选中最前面的标题按钮
    firstTitleButotn.selected = YES;
    self.selectedTitleButton = firstTitleButotn;
    
}

#pragma mark - 标题按钮的点击
- (void)titleButtonClick:(XYTitleButton *)titleButton
{
    
    // 按钮交替选中三步曲
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.xy_width = titleButton.titleLabel.xy_width;
        self.indicatorView.xy_centerX = titleButton.xy_centerX;
    } completion:nil];
    
    // 点击按钮的时候跳到相应的控制器
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.xy_width;
    [self.scrollView setContentOffset:offset animated:YES];
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
    // 取出当前子控制对应的索引
     NSInteger index = self.scrollView.contentOffset.x / self.scrollView.xy_width;
    
    // 把当控制器的按钮索赋值给当前按钮
    XYTitleButton *titleButton = self.titlesView.subviews[index];
    
    // 模仿用户,调用代码去点击按钮,切换到相应的子控制器
    [self titleButtonClick:titleButton];
    
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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
}

#pragma mark - 标签按钮的点击
- (void)tagClick
{
    XYTagViewController *tag = [[XYTagViewController alloc] init];
    tag.title = @"标签订阅";
    [self.navigationController pushViewController:tag animated:YES];
}

@end
