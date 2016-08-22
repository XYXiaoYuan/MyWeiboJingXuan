//
//  XYBaseTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYBaseTool.h"
#import "MJExtension.h"


@implementation XYBaseTool

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
{
    NSDictionary *params = [param mj_keyValues];
    
    [XYHttpTool get:url params:params success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
{
    NSDictionary *params = [param mj_keyValues];
    
    [XYHttpTool post:url params:params success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
