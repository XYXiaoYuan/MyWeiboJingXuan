//
//  HSSettingArrowItem.h
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//  设置界面箭头模型类

#import "XYSettingItem.h"

@interface XYSettingArrowItem : XYSettingItem

/** 目标控制器 */
@property (nonatomic, assign) Class destVC;

+ (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc;

@end
