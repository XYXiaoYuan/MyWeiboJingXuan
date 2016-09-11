//
//  XYAdViewController.m
//  BuDeJie
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYAdViewController.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "XYAdTool.h"
#import "XYAdItem.h"
#import "XYTabBarController.h"
/*
    1.广告业务逻辑
    2.占位视图思想:有个控件不确定尺寸,但是层次结构已经确定,就可以使用占位视图思想
    3.屏幕适配.通过屏幕高度判断
 */

@interface XYAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property (nonatomic, weak) UIImageView *adView;
@property (nonatomic, strong) XYAdItem *item;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation XYAdViewController

- (UIImageView *)adView
{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.adContainView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        
        imageView.userInteractionEnabled = YES;
        
        _adView = imageView;
    }
    
    return _adView;
}

// 点击跳转做的事情
- (IBAction)clickJump:(id)sender {
    // 销毁广告界面,进入主框架界面
    XYTabBarController *tabBarVc = [[XYTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    
    // 干掉定时器
    [_timer invalidate];
}

// 点击广告界面调用
- (void)tap
{
    // 跳转到界面 => safari
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置启动图片
    [self setupLaunchImage];
    
    // 加载广告数据 => 拿到活时间 => 服务器 => 查看接口文档 1.判断接口对不对 2.解析数据(w_picurl,ori_curl:跳转到广告界面,w,h) => 请求数据(AFN)
    [self loadAdData];
    
    // 创建定时器
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange
{
    // 倒计时
    static int i = 3;
    if (i == 0) {
        [self clickJump:nil];
    }
    i--;
    // 设置跳转按钮文字
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转 (%d)",i] forState:UIControlStateNormal];
}

#pragma mark - 加载广告数据
- (void)loadAdData
{
    // 发送请求
    [XYAdTool adDataWithSuccess:^(NSDictionary *result) {
        // 获取字典
        NSDictionary *adDict = [result[@"ad"] lastObject];
        
        // 字典转模型
        _item = [XYAdItem mj_objectWithKeyValues:adDict];
        
        // 创建UIImageView展示图片 =>
        CGFloat h = XYSCREEN_W / _item.w * _item.h;
        
        self.adView.frame = CGRectMake(0, 0, XYSCREEN_W, h);
        // 加载广告网页
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
    } failure:^(NSError *error) {
         NSLog(@"%@",error);
    }];
}

// 设置启动图片
- (void)setupLaunchImage
{
    // 6p:LaunchImage-800-Portrait-736h@3x.png
    // 6:LaunchImage-800-667h@2x.png
    // 5:LaunchImage-568h@2x.png
    // 4s:LaunchImage@2x.png
    if (XYiPhone6Plus_OR_6sPlus) { // 6p
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (XYiPhone6_OR_6s) { // 6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (XYiPhone5_OR_5c_OR_5s) { // 5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
        
    } else if (XYiPhone4_OR_4s) { // 4
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

@end
