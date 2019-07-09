//
//  XYHttpTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYHttpTool.h"

@interface XYHttpManager : AFHTTPSessionManager

/** LFHttpManager单例 */
+ (instancetype)sharedManager;

@end

@implementation XYHttpManager

+ (instancetype)sharedManager {
    static XYHttpManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[XYHttpManager alloc] init];
        // 设置请求超时设定
        _sharedManager.requestSerializer.timeoutInterval = 5.0f;
        // 设置json序列化
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        // 设置可接受类型
        _sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _sharedManager;
}

@end

@implementation XYHttpTool

implementationSingle(XYHttpTool);

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(responseSuccessBlock)success failure:(requestFailureBlock)failure;
{
    // 1.获得请求管理者
    // 2.发送GET请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    XYWeakSelf;
    [[XYHttpManager sharedManager] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [weakSelf prettyPrintAboutHttpWithOperation:task withResponseObj:responseObject withManager:[XYHttpManager sharedManager]];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(responseSuccessBlock)success failure:(requestFailureBlock)failure
{
    // 1.获得请求管理者
    // 2.发送POST请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    XYWeakSelf;
    [[XYHttpManager sharedManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [weakSelf prettyPrintAboutHttpWithOperation:task withResponseObj:responseObject withManager:[XYHttpManager sharedManager]];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark- 打印url 和 json数据 httpHeader用于调试
+(void)prettyPrintAboutHttpWithOperation:(NSURLSessionDataTask *)operation withResponseObj:(id)responseObj withManager:(AFHTTPSessionManager *)mgr
{
#if DEBUG
    // 请求的url
    NSLog(@"最终请求路径: %@", operation.currentRequest.URL.absoluteString);
    
    // 请求的json数据打印
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:responseObj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:dataJson encoding:NSUTF8StringEncoding];
    NSLog(@"json字符串: %@", jsonStr);
    
    // 请求的header信息
    NSDictionary *dict = mgr.requestSerializer.HTTPRequestHeaders;
    NSLog(@"请求头httpHeader: %@", dict);
#endif
}


@end
