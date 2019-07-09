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
            if (resultClass) { // 有传resultClass,内部用MJExtension做好字典转模型操作
                if ([responseObj isKindOfClass:NSDictionary.class]) {
                    id result = [resultClass mj_objectWithKeyValues:responseObj];
                    success(result);
                }
                if ([responseObj isKindOfClass:NSArray.class]) {
                    id result = [resultClass mj_objectArrayWithKeyValuesArray:responseObj];
                    success(result);
                }
            } else { // 没有传resultClass,外部自行处理字典转模型操作
                success(responseObj);
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
        if (success) {
            if (resultClass) { // 有传resultClass,内部用MJExtension做好字典转模型操作
                if ([responseObj isKindOfClass:NSDictionary.class]) {
                    id result = [resultClass mj_objectWithKeyValues:responseObj];
                    success(result);
                }
                if ([responseObj isKindOfClass:NSArray.class]) {
                    id result = [resultClass mj_objectArrayWithKeyValuesArray:responseObj];
                    success(result);
                }
            } else { // 没有传resultClass,外部自行处理字典转模型操作
                success(responseObj);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (NSDictionary *)dealParam:(id)param {
    // 参数处理
    NSDictionary *params = [NSDictionary dictionary];
    if ([param isKindOfClass:NSDictionary.class]) { // 字典,直接赋值
        params = param;
    } else { // 模型,模型转为字典后赋值
        params = [param mj_keyValues];
    }
    return params;
}

@end
