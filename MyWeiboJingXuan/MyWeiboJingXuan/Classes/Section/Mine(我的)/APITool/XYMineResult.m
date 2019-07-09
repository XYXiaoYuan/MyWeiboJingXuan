//
//  XYMineResult.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYMineResult.h"
#import "XYSquareItem.h"
#import <MJExtension.h>

@implementation XYMineResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"square_list" : XYSquareItem.class
             };
}

@end
