//
//  HSBaseSettingViewController.h
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//

#import "XYBaseTableViewController.h"
#import "XYSettingItem.h"
#import "XYSettingGroupItem.h"
#import "XYSettingArrowItem.h"
#import "XYSettingSwitchItem.h"
#import "XYSettingCell.h"

@interface XYBaseSettingViewController : XYBaseTableViewController

// 保存当前tableView有多少组,元素是一个groupItem
@property (nonatomic, strong) NSMutableArray *groups;

@end
