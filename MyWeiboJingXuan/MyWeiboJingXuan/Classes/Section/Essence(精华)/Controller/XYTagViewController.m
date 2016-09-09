//
//  XYTagViewController.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYTagViewController.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "XYTagTool.h"
#import "XYTagItem.h"
#import "XYTagCell.h"

@interface XYTagViewController ()
/** tag模型数组 */
@property(nonatomic,strong) NSMutableArray<XYTagItem *> *tags;
@end

@implementation XYTagViewController
// 重用标识
static NSString * const XYTagCellID = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self seupTable];
    
    // 加载tags
    [self loadTags];
}

#pragma mark - 设置tableView
- (void)seupTable
{
    // 设置行高
    self.tableView.rowHeight = 70;
    
    // 去掉系统自带的分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYTagCell class]) bundle:nil] forCellReuseIdentifier:XYTagCellID];
}

#pragma mark - 加载标签数据
- (void)loadTags
{
    // 显示加载的圈圈
    [SVProgressHUD show];
    
    // 加载标签数据
    XYTagParam *param = [[XYTagParam alloc] init];
    param.action = @"sub";
    
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
    // 1.创建cell
    XYTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XYTagCellID];
    
    // 2.设置模型数据
    cell.tagModel = self.tags[indexPath.row];
    
    // 3.返回cell
    return cell;
}

/** 控制的view即将消失的时候调用 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 停止请求
    [XYTagTool invalidateSessionCancelingTasks];
    
    // 移除弹框
    [SVProgressHUD dismiss];
}

@end
