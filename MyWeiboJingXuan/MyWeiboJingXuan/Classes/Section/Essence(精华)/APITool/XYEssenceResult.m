//
//  XYEssenceResult.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYEssenceResult.h"
#import "XYTopicItem.h"
#import <MJExtension.h>

@implementation XYEssenceResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list" : [XYTopicItem class]};
}

@end
