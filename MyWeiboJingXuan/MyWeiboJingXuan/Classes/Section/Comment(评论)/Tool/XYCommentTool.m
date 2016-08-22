//
//  XYCommentTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYCommentTool.h"

@implementation XYCommentTool

+ (void)commentWithParam:(XYCommentParam *)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:XYRequestURL param:param resultClass:[NSDictionary class] success:success failure:failure];
}

@end
