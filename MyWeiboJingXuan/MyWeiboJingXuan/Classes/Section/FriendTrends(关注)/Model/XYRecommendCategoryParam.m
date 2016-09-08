//
//  XYCategoryParam.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/8.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYRecommendCategoryParam.h"

@implementation XYRecommendCategoryParam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.a = @"category";
        self.c = @"subscribe";
    }
    return self;
}

@end
