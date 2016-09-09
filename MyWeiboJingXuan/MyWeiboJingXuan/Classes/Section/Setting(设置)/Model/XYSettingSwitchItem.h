//
//  HSSettingSwitchItem.h
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//  设置界面的右侧开头模型

#import "XYSettingItem.h"

@interface XYSettingSwitchItem : XYSettingItem

/** 开关的block,监听开关的打开和关闭 */
@property (nonatomic, strong) void(^switchBlock)(BOOL isOn);

@end
