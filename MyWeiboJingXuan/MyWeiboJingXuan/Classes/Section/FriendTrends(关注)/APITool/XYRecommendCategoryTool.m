//
//  XYCategoryTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/8.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYRecommendCategoryTool.h"

@implementation XYRecommendCategoryTool

+ (void)recommendCategoryWithParam:(XYRecommendCategoryParam *)param success:(void (^)(XYRecommendCategoryResult *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:XYRequestURL param:param resultClass:[XYRecommendCategoryResult class] success:success failure:failure];
}

@end
