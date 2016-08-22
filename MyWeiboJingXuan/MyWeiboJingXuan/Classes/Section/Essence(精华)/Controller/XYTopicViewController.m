
//
//  XYTopicViewController.m
//  bai
//
//  Created by yuan on 15/11/17.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTopicViewController.h"
#import "XYRefreshAutoFooter.h"
#import "XYRefreshNormalHeader.h"
#import "XYEssenceTool.h"
#import <MJExtension.h>
#import "XYEssenceResult.h"
#import "XYEssenceInfoItem.h"
#import "XYTopic.h"
#import "XYTopicCell.h"
#import "XYNewViewController.h"
#import "XYCommentViewController.h"

@interface XYTopicViewController ()<UITableViewDataSource,UITableViewDelegate>

/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;

/** topics模型数据 */
@property(nonatomic,strong) NSMutableArray<XYTopic *> *topics;


/** 声明这个方法的目的 : 为了能够使用点语法的智能提示 */
- (NSString *)aParam;
@end

@implementation XYTopicViewController
// 可重用标识
static NSString * const XYTopicCellId = @"topic";

#pragma mark - 仅仅是为了消除编译器发出的警告 : type方法没有实现
- (NSString *)aParam
{
    // 如果是当前控制的父控制 == XYNewViewController
    if (self.parentViewController.class == [XYNewViewController class]) {
        return @"newlist";
    }
    return @"list";
}

- (XYTopicType)type {
    return 0;
}

#pragma mark - 初始化操作
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTable];
    
    // 数据刷新
    [self setupRefresh];
    
    
}

// 初始化tableView
- (void)setupTable
{
    self.tableView.backgroundColor = XYCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYTopicCell class]) bundle:nil] forCellReuseIdentifier:XYTopicCellId];
    //    self.tableView.rowHeight = 300;
}


#pragma mark - 数据刷新
- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [XYRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载更多
    self.tableView.mj_footer = [XYRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 加载数据
// 下拉刷新,加载最新数据
- (void)loadNewTopics
{
    //取消任务
    [XYEssenceTool cancel];
    
    // 参数
    XYEssenceParam *param = [[XYEssenceParam alloc] init];
    param.a = self.aParam;
    param.type = self.type;
    param.c = @"data";
   
    
    XYWeakSelf
    [XYEssenceTool essenceWithParam:param success:^(NSDictionary *result) {
        // 发送成功
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = result[@"info"][@"maxtime"];
        
        // 字典数据 -> 模型数组
        weakSelf.topics = [XYTopic mj_objectArrayWithKeyValuesArray:result[@"list"]];
        
        // 刷新数据
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        // 发送失败
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

// 上拉刷新,加载更多数据
- (void)loadMoreTopics
{
    //取消任务
    [XYEssenceTool cancel];
    
    // 参数
    XYEssenceParam *param = [[XYEssenceParam alloc] init];
    param.a = self.aParam;
    param.c = @"data";
    param.type = self.type;
    param.maxtime = self.maxtime;
    
    XYWeakSelf
    [XYEssenceTool essenceWithParam:param success:^(NSDictionary *result) {
        // 发送成功
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = result[@"info"][@"maxtime"];
        
        // 字典数据 -> 模型数组
        NSArray<XYTopic *> *moreTopics = [XYTopic mj_objectArrayWithKeyValuesArray:result[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新数据
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        // 发送失败
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XYTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCommentViewController *comment = [[XYCommentViewController alloc] init];
    
    // 这里必须传一个模型过来,不然获取不了数据
    comment.topic = self.topics[indexPath.row];
    
    [self.navigationController pushViewController:comment animated:YES];
}

@end
