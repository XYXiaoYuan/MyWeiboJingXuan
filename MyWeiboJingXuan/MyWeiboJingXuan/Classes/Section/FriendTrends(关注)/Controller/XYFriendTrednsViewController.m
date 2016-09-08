//
//  XYFriendTrednsViewController.m
//  bai
//
//  Created by yuan on 15/11/9.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYFriendTrednsViewController.h"
#import "XYLoginRegisterViewController.h"
#import "XYRecommendViewController.h"

@interface XYFriendTrednsViewController ()

@end

@implementation XYFriendTrednsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(recommendClick)];
}

- (IBAction)loginOrRegister
{
    XYLoginRegisterViewController *loginRegisterViewController = [[XYLoginRegisterViewController alloc] init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:loginRegisterViewController animated:NO completion:nil];
}


- (void)recommendClick
{
    XYRecommendViewController *recommendVc = [[XYRecommendViewController alloc] init];
    recommendVc.navigationItem.title = @"推荐关注";
    [self.navigationController pushViewController:recommendVc animated:YES];
}

@end
