//
//  HSSettingArrowItem.m
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//

#import "XYSettingArrowItem.h"

@implementation XYSettingArrowItem

+ (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc
{
    
    XYSettingArrowItem *arrowItem = [[self alloc] init];
    arrowItem.title = title;
    arrowItem.destVC = destVc;
    
    return arrowItem;
}

@end
