//
//  HSSettingItem.m
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//

#import "XYSettingItem.h"

@implementation XYSettingItem

+ (instancetype)initWithTitle:(NSString *)title
{
    XYSettingItem *item = [[self alloc] init];
    item.title = title;
    
    return item;
}


@end
