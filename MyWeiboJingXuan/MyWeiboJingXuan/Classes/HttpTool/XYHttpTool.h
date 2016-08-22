//
//  XYHttpTool.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//  网络请求工具类：负责整个项目的所有HTTP请求

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "AFNetworking.h"

/* 当request成功后的 responseSuccessBlock */
typedef void (^responseSuccessBlock)(id responseObj);
/* 当request失败后的 requestFailureBlock */
typedef void (^requestFailureBlock)(NSError *error);

@interface XYHttpTool : NSObject
interfaceSingle(XYHttpTool);

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(responseSuccessBlock)successHandler failure:(requestFailureBlock)failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(responseSuccessBlock)success failure:(requestFailureBlock)failure;

/** manager */
@property(nonatomic,weak,readonly) AFHTTPSessionManager *manager;
@end
