//
//  XYRecommendParam.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/8.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYRecommendUserParam.h"

@implementation XYRecommendUserParam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.a = @"list";
        self.c = @"subscribe";
    }
    return self;
}

@end
