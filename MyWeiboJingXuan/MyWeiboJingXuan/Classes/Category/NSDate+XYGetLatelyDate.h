//
//  NSDate+XYGetLatelyDate.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/14.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XYGetLatelyDate)

/** 获得一个时间的Interval */
- (NSDateComponents *)dateToInterval:(NSDate *)date;

/** 获得现在时间 和 发表时间的间隔 */
- (NSDateComponents *)intervalToNow;

/** 今天 */
- (BOOL)isToday;

/** 昨天 */
- (BOOL)isYesterday;

/** 明天 */
- (BOOL)isTomorrow;

/** 今年 */
- (BOOL)isThisYear;


@end
