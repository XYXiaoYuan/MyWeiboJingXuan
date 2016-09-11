//
//  XYMineTool.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/9.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYBaseTool.h"
#import "XYMineParam.h"
#import "XYMineResult.h"

@interface XYMineTool : XYBaseTool

/**
 *  加载推荐右侧的用户数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)mineDataWithParam:(XYMineParam *)param success:(void (^)(XYMineResult *result))success failure:(void (^)(NSError *error))failure;

@end
