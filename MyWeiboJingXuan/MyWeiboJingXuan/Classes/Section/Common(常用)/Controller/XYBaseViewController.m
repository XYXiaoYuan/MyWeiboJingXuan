//
//  XYBaseViewController.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYBaseViewController.h"

@interface XYBaseViewController ()

@end

@implementation XYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XYCommonBgColor;
}

/** 重写dealloc方法,看控制器有没有销毁 */
- (void)dealloc
{
    XYLog(@"%@控制器被销毁了",[self class]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    XYLog(@"%@控制器接收到了内存警告",[self class]);
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}


@end
