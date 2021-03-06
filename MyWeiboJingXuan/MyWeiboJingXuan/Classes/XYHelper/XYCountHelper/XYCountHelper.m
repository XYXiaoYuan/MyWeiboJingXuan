//
//  XMLYCountHelper.m
//  XMLYFM
//
//  Created by East_wu on 16/9/14.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "XYCountHelper.h"

static  NSString *XMLYGetPlyCount(NSInteger num) {
    if(num < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)num];
    }else {
        CGFloat fot = num / 10000.0f;
        return [NSString stringWithFormat:@"%.1f万",fot];
    }
}

@implementation XYCountHelper

+ (NSString *)countStringFromNSInter:(NSInteger)count {
    return XMLYGetPlyCount(count);
}

@end
