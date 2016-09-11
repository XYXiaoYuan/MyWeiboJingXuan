//
//  XYLoginTool.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/8/6.
//  Copyright (c) 2015年 袁小荣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYLoginTool : NSObject

/** 设置udid */
+ (void)setUid:(NSString *)uid;

/** 
 获得当前登录用户的uid，检测是否登录
 NSString *：已经登录, nil：没有登录 
 */
+ (NSString *)getUid;
+ (NSString *)getUid:(BOOL)showLoginController;

@end
