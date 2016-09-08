//
//  XYRefreshAutoFooter.m
//  bai
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYRefreshAutoFooter.h"

@implementation XYRefreshAutoFooter

- (void)prepare
{
    [super prepare];
    
    // 设置下拉刷新的提示文字颜色
    self.stateLabel.textColor = [UIColor grayColor];
    
    [self setTitle:@"没有数据啦,不要再上拉了" forState:MJRefreshStateNoMoreData];

}

@end
