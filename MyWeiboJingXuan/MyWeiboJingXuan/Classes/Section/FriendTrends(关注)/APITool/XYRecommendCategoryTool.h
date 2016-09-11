//
//  XYCategoryTool.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/8.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYBaseNetTool.h"
#import "XYRecommendCategoryParam.h"
#import "XYRecommendCategoryResult.h"

@interface XYRecommendCategoryTool : XYBaseNetTool

/**
 *  加载推荐左侧的分类数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)recommendCategoryWithParam:(XYRecommendCategoryParam *)param success:(void (^)(XYRecommendCategoryResult *result))success failure:(void (^)(NSError *error))failure;

@end
