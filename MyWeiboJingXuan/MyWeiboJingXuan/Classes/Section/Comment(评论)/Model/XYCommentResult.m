//
//  XYCommentResult.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYCommentResult.h"
#import "XYCommentItem.h"
#import <MJExtension.h>

@implementation XYCommentResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [XYCommentItem class],
             @"hot"  : [XYCommentItem class]
             };
}

@end
