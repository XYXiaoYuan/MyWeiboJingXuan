//
//  XYLoginRegisterViewController.m
//  bai
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYLoginRegisterViewController.h"

@interface XYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;

@end

@implementation XYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginOrRegister:(UIButton *)button
{
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
