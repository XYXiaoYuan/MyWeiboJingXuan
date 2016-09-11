//
//  XYMineTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/9.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYMineTool.h"

@implementation XYMineTool

+ (void)mineDataWithParam:(XYMineParam *)param success:(void (^)(XYMineResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:XYRequestURL param:param resultClass:[XYMineResult class] success:success failure:failure];
}

@end
