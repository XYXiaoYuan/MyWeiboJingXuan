//
//  NSDate+XYGetLatelyDate.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/14.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "NSDate+XYGetLatelyDate.h"

@implementation NSDate (XYGetLatelyDate)

/** 获得一个时间的Interval */
- (NSDateComponents *)dateToInterval:(NSDate *)date
{
    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 想比较哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |   NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    
    // 比较
   return [calendar components:unit fromDate:self toDate:date options:0];
}

/** 获得现在时间 和 发表时间的间隔 */
- (NSDateComponents *)intervalToNow
{
    return [self dateToInterval:[NSDate date]];
}

/** 今年 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger thisYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return thisYear == selfYear;
}


/** 今天 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 想比较哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |   NSCalendarUnitDay;
    NSDateComponents *thisDayComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfDayComponents = [calendar components:unit fromDate:self];
    
    // 返回YES or NO
    return thisDayComponents.year == selfDayComponents.year &&
    thisDayComponents.month == selfDayComponents.month &&
    thisDayComponents.day == selfDayComponents.day;
    
}

/** 昨天 */
- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:[NSDate date]];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 想比较哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |   NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 &&
           comps.month == 0 &&
           comps.day == 1;
}

/** 明天 */
- (BOOL)isTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:[NSDate date]];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 想比较哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |   NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 &&
    comps.month == 0 &&
    comps.day == -1;
}

@end
