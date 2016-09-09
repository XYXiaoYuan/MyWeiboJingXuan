//
//  HSSettingGroupItem.h
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//  设置界面的组模型,这里可以设置头部标题,尾部标题

#import <Foundation/Foundation.h>

@interface XYSettingGroupItem : NSObject

// 头部标题
@property (nonatomic, strong) NSString *headTitle;

// 尾部标题
@property (nonatomic, strong) NSString *footTitle;

// 行模型数组
// 描述当前组有多少行,items:cell对应的模型(HSSettingItem)
@property (nonatomic, strong) NSArray *items;

@end
