//
//  XYAdTool.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/9.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYBaseNetTool.h"

@interface XYAdTool : XYBaseNetTool

/**
 *  加载评论数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)adDataWithSuccess:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

@end
