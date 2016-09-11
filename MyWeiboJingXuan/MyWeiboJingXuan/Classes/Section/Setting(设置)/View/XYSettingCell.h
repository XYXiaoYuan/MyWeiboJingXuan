//
//  HSSettingCell.h
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//  设置的界面的cell,我在这里设置好了根据你配置的模型显示右侧不同的视图

#import <UIKit/UIKit.h>

@class XYSettingItem;

@interface XYSettingCell : UITableViewCell

/** 快速的创建cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView tableViewCellStyle:(UITableViewCellStyle)tableViewCellStyle;
/** 设置模型 */
@property (nonatomic, strong) XYSettingItem *item;

@end
