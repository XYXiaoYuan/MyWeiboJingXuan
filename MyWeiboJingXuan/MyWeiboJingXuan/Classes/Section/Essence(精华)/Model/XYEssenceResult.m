//
//  XYEssenceResult.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYEssenceResult.h"
#import <MJExtension.h>
#import "XYTopic.h"
#import "XYEssenceInfoItem.h"

@implementation XYEssenceResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list" : [XYTopic class],
             @"info" : [XYEssenceInfoItem class]
             };
}

@end
