//
//  XYRecommendUserResult.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYRecommendUserResult.h"
#import "XYRecommendUserItem.h"
#import <MJExtension.h>

@implementation XYRecommendUserResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list" : [XYRecommendUserItem class]};
}


@end
