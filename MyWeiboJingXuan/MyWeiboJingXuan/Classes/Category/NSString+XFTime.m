//
//  NSString+XFTime.m
//  MyWeiboJingXuan
//
//  Created by yuan on 16/3/15.
//  Copyright © 2016年 袁小荣. All rights reserved.
//

#import "NSString+XFTime.h"

@implementation NSString (XFTime)

+ (NSString *)stringWithTime:(NSTimeInterval)time {
    
    NSInteger min = (NSInteger)time / 60;
    NSInteger second = (NSInteger)time % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)min, (long)second];
}

@end
