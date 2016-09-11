//
//  XYTagTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYTagTool.h"

@implementation XYTagTool

+ (void)tagWithParam:(XYTagParam *)param success:(void (^)(XYTagResultItem *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:XYRequestURL param:param resultClass:[XYTagResultItem class] success:success failure:failure];
}

@end
