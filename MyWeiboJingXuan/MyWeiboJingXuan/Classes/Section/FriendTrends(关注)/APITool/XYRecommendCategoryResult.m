//
//  XYRecommendCategoryResult.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYRecommendCategoryResult.h"
#import "XYRecommendCategoryItem.h"
#import <MJExtension.h>

@implementation XYRecommendCategoryResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list" : [XYRecommendCategoryItem class]};
}

@end
