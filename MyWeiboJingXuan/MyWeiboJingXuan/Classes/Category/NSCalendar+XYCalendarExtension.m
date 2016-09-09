//
//  NSCalendar+XYCalendarExtension.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/20.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "NSCalendar+XYCalendarExtension.h"

@implementation NSCalendar (XYCalendarExtension)

+ (instancetype)calendar
{
    // 解决 IOS8.0 之后直接调用[NSCalendar currentCalendar] 崩溃的问题
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}

@end
