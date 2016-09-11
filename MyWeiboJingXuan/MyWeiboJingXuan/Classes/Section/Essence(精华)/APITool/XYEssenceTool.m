//
//  XYEssenceTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYEssenceTool.h"

@implementation XYEssenceTool

+ (void)essenceWithParam:(XYEssenceParam *)param success:(void (^)(XYEssenceResult *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:XYRequestURL param:param resultClass:[XYEssenceResult class] success:success failure:failure];
}

@end
