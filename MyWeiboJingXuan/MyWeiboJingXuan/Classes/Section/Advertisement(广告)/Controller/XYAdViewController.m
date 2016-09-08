//
//  XMGAdViewController.m
//  BuDeJie
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XYADItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "XYTabBarController.h"
/*
    1.广告业务逻辑
    2.占位视图思想:有个控件不确定尺寸,但是层次结构已经确定,就可以使用占位视图思想
    3.屏幕适配.通过屏幕高度判断
 */

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface XYAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (nonatomic, weak) UIImageView *adView;
@property (nonatomic, strong) XYADItem *item;
@property (nonatomic, weak) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
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
    // Do any additional setup after loading the view.
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
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    // 3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        // 获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        
        // 字典转模型
        _item = [XYADItem mj_objectWithKeyValues:adDict];
        
        // 创建UIImageView展示图片 =>
        CGFloat h = XYSCREEN_W / _item.w * _item.h;
        
        self.adView.frame = CGRectMake(0, 0, XYSCREEN_W, h);
        // 加载广告网页
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
