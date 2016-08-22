//
//  XYBaseTool.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//  最基本的业务工具类

#import <Foundation/Foundation.h>
#import "XYHttpTool.h"

@interface XYBaseTool : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;;

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/** 控制器死的时候让请求失效 */
+ (void)invalidateSessionCancelingTasks;
/** 取消任务 */
+ (void)cancel;

@end
