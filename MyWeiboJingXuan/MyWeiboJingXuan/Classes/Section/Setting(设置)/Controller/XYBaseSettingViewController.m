//
//  HSBaseSettingViewController.m
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//

#import "XYBaseSettingViewController.h"

@interface XYBaseSettingViewController ()

@end

@implementation XYBaseSettingViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
}

#pragma mark - tableView数据源
// 返回有多少组
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView{
    return self.groups.count;
}

// 返回每一组有多少行,取出对应的小数组
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XYSettingGroupItem *group = self.groups[section];
    
    return group.items.count;
}

// 返回每一个cell长什么样子
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 创建cell
    XYSettingCell *cell = [XYSettingCell cellWithTableView:tableView tableViewCellStyle:UITableViewCellStyleValue1];
    
    // 获取对应的组模型
    XYSettingGroupItem *group = self.groups[indexPath.section];
    
    // 获取模型
    XYSettingItem *item = group.items[indexPath.row];
    
    // 给cell传递一个模型
    cell.item = item;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


// 返回每一组的头部标题
- (NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 获取当前组模型
    XYSettingGroupItem *group = self.groups[section];
    return group.headTitle;
    
}
//  返回每一组的尾部标题
- (NSString *)tableView:(nonnull UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    // 获取当前组模型
    XYSettingGroupItem *group = self.groups[section];
    return group.footTitle;
    
}

// 只要点击cell就会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取对应的组模型
    XYSettingGroupItem *group = self.groups[indexPath.section];
    
    // 获取模型
    XYSettingItem *item = group.items[indexPath.row];
    
    // 判断block中是否保存了代码
    if (item.operation) {
        // 如果保存,就执行block中保存的代码
        item.operation();
        return;
    }
    
    // 判断是否是箭头模型
    if ([item isKindOfClass:[XYSettingArrowItem class]]) {
        // 标示箭头类型,可以跳转
        XYSettingArrowItem *arrowItem = (XYSettingArrowItem *)item;
        
        // 获取需要跳转控制器的类名
        if (arrowItem.destVC) {
            
            // 创建需要跳转的控制器对象
            UIViewController *vc = [[arrowItem.destVC alloc] init];
            
            vc.title = arrowItem.title;
            
            // 跳转界面
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end