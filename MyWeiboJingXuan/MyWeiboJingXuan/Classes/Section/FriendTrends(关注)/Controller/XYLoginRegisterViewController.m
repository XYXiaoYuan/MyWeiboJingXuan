//
//  XYLoginRegisterViewController.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYLoginRegisterViewController.h"

@interface XYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation XYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // 设置登录,注册按钮的圆角
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.clipsToBounds = YES;
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.clipsToBounds = YES;
}

- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginOrRegister:(UIButton *)button
{
    [self.view endEditing:YES];
    
    // 修改约束
    if (self.leftSpace.constant == 0) {
        self.leftSpace.constant = - self.view.xy_width;
        button.selected = YES;
        
    } else {
        self.leftSpace.constant = 0;
        button.selected = NO;
        
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    // 设置状态栏的颜色
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
