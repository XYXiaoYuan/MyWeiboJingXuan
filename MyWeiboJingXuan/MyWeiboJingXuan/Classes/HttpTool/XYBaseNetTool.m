//
//  XYBaseTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYBaseNetTool.h"
#import "MJExtension.h"

@implementation XYBaseNetTool

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
{
    NSDictionary *params = [param mj_keyValues];
    
    [XYHttpTool get:url params:params success:^(id responseObj) {
        if (success) {
            if ([responseObj isKindOfClass:[NSDictionary class]]) {
                id result = [resultClass mj_objectWithKeyValues:responseObj];
                success(result);
            }if ([responseObj isKindOfClass:[NSArray class]]) {
                id result = [resultClass mj_objectArrayWithKeyValuesArray:responseObj];
                success(result);
            }
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
        if ([responseObj isKindOfClass:[NSDictionary class]]) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }if ([responseObj isKindOfClass:[NSArray class]]) {
            id result = [resultClass mj_objectArrayWithKeyValuesArray:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
