//
//  XYTagParam.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYTagParam.h"

@implementation XYTagParam

- (instancetype)init
{
    if (self = [super init]) {
        self.a = @"tag_recommend";
        self.c = @"topic";
        self.action = @"sub";
    }
    return self;
}

@end
