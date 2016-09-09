//
//  HSSettingCell.m
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//

#import "XYSettingCell.h"
#import "XYSettingItem.h"
#import "XYSettingArrowItem.h"
#import "XYSettingSwitchItem.h"

@interface XYSettingCell ()
@property (nonatomic, strong) UISwitch *switchBtn;
@end

@implementation XYSettingCell

#pragma mark - lazy
- (UISwitch *)switchBtn
{
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
        // 监听开关的改变
        [_switchBtn addTarget:self action:@selector(switchBtnChagne) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (void)switchBtnChagne
{
    XYSettingSwitchItem *switchItem = (XYSettingSwitchItem *)_item;
    if (switchItem.switchBlock) {
        switchItem.switchBlock(self.switchBtn.isOn);
        
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:self.switchBtn.isOn forKey:self.item.title];
    
    [defaults synchronize];
}


#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView tableViewCellStyle:(UITableViewCellStyle)tableViewCellStyle
{
    static NSString *ID = @"XYSettingCell";
    XYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:tableViewCellStyle reuseIdentifier:ID];
    }
    
    // cell的选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)setItem:(XYSettingItem *)item
{
    _item = item;
    
    // 设置cell的数据
    [self setUpData];
    
    // 设置辅助视图
    [self setUpAccessoryView];
    
}

// 设置数据
- (void)setUpData
{
    // 设置数据
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
}

// 设置辅助视图
- (void)setUpAccessoryView
{
    if ([_item isKindOfClass:[XYSettingArrowItem class]]) {
        // 显示箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if ([_item isKindOfClass:[XYSettingSwitchItem class]]){
        // 开关
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchBtn.on = [defaults boolForKey:self.item.title];
        
        // 设置没有选中样式,因为开关是没有选中样式的
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = self.switchBtn;

    }else{
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}



@end
