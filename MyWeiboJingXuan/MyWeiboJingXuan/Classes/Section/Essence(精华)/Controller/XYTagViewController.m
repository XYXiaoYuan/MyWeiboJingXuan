//
//  XYTagViewController.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYTagViewController.h"
#import "XYTagTool.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "XYTagItem.h"
#import "XYTagCell.h"

@interface XYTagViewController ()
/** tag模型数组 */
@property(nonatomic,strong) NSMutableArray<XYTagItem *> *tags;
@end

@implementation XYTagViewController
// 重用标识
static NSString * const XYTagCellId = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self seupTable];
    
    // 加载tags
    [self loadTags];
}

// 设置table
- (void)seupTable
{
    // 设置tableView的背景颜色为统一的灰色
    self.view.backgroundColor = XYCommonBgColor;
    
    // 设置行高
    self.tableView.rowHeight = 70;
    
    // 去掉系统自带的分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYTagCell class]) bundle:nil] forCellReuseIdentifier:XYTagCellId];
}

- (void)loadTags
{
    // 显示加载的圈圈
    [SVProgressHUD show];
    
    // 加载标签数据
    XYTagParam *param = [[XYTagParam alloc] init];
    param.a = @"tag_recommend";
    param.action = @"sub";
    param.c = @"topic";
    
    XYWeakSelf;
    [XYTagTool tagWithParam:param success:^(XYTagItem *result) {
        // 成功
        // 字典数据 -> 模型数据
        weakSelf.tags = [XYTagItem mj_objectArrayWithKeyValuesArray:result];

        // 刷新数据
        [weakSelf.tableView reloadData];
        
        // 移除弹框
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        // 失败
        if (error.code == NSURLErrorCancelled) {
            return ;
        } else if (error.code == NSURLErrorTimedOut){
            [SVProgressHUD showErrorWithStatus:@"超时"];
        } else{
            [SVProgressHUD showErrorWithStatus:@"正在加载中,请稍候"];
        }

    }];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XYTagCellId];
    
    cell.tagModel = self.tags[indexPath.row];
    
    return cell;
}


@end
