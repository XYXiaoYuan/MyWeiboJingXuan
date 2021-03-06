//
//  XYTagTool.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYBaseNetTool.h"
#import "XYTagResultItem.h"
#import "XYTagParam.h"

@interface XYTagTool : XYBaseNetTool

/**
 *  加载标签数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)tagWithParam:(XYTagParam *)param success:(void (^)(XYTagResultItem *result))success failure:(void (^)(NSError *error))failure;


@end
