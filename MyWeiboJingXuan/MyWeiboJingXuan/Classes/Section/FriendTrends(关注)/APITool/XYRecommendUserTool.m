//
//  XYRecommendTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/8.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYRecommendUserTool.h"

@implementation XYRecommendUserTool

+ (void)recommendUserWithParam:(XYRecommendUserParam *)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:XYRequestURL param:param resultClass:[NSDictionary class] success:success failure:failure];
}

@end
