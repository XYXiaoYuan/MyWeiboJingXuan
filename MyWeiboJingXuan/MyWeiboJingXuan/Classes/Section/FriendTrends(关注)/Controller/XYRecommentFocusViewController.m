//
//  XYRecommentFocusViewController.m
//  bai
//
//  Created by yuan on 15/11/22.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYRecommentFocusViewController.h"

@interface XYRecommentFocusViewController ()

@end

@implementation XYRecommentFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置Nav
    [self seupNav];
    
    // 设置table
    [self setupTable];
}

- (void)seupNav
{
    self.navigationItem.title = @"推荐关注";
}

- (void)setupTable
{
    
}

@end
