//
//  XYRecommendViewController.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYRecommendViewController.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "XYRefreshGifHeader.h"
#import "XYRefreshAutoFooter.h"
#import "XYRecommendCategoryTool.h"
#import "XYRecommendUserTool.h"
#import "XYRecommendCategoryCell.h"
#import "XYRecommendUserCell.h"
#import "XYRecommendCategory.h"
#import "XYRecommendUser.h"

#define XYSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface XYRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray<XYRecommendCategory *> *categories;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 请求参数 */
@property (nonatomic, strong) XYRecommendUserParam *params;
@end

@implementation XYRecommendViewController

static NSString * const XYCategoryId = @"category";
static NSString * const XYUserId = @"user";

#pragma mark - 0.view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.控件的初始化
    [self setupTableView];
    
    // 2.加载左侧的类别数据
    [self loadCategories];
    
    // 3.添加刷新控件
    [self setupRefresh];
}

#pragma mark - 1.控件的初始化
- (void)setupTableView
{
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(XYNavBarMaxY, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
   
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:XYCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XYUserId];
}

#pragma mark - 2.加载左侧的类别数据
- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    // 发送请求
    XYRecommendCategoryParam *params = [[XYRecommendCategoryParam alloc] init];
    [XYRecommendCategoryTool recommendCategoryWithParam:params success:^(XYRecommendCategoryResult *result) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.categories = [XYRecommendCategory mj_objectArrayWithKeyValuesArray:result.list];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

#pragma mark - 3.添加刷新控件
- (void)setupRefresh
{
    self.userTableView.mj_header = [XYRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [XYRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark - 3.1.加载最新用户数据
- (void)loadNewUsers
{
    XYRecommendCategory *rc = XYSelectedCategory;

    // 设置当前页码为1
    rc.currentPage = 1;
    
    // 请求参数
    XYRecommendUserParam *params = [[XYRecommendUserParam alloc] init];
    params.category_id = rc.ID;
    params.page = rc.currentPage;
    self.params = params;
    
    // 发送请求给服务器, 加载右侧的数据
    [XYRecommendUserTool recommendUserWithParam:params success:^(XYRecommendUserResult *result) {
        // 字典数组 -> 模型数组
        NSArray *users = [XYRecommendUser mj_objectArrayWithKeyValuesArray:result.list];
        
        // 清除所有旧数据
        [rc.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = result.total;
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

#pragma mark - 3.2.加载更多用户数据
- (void)loadMoreUsers
{
    XYRecommendCategory *category = XYSelectedCategory;

    XYRecommendUserParam *params = [[XYRecommendUserParam alloc] init];
    params.category_id = category.ID;
    params.page = ++category.currentPage;
    self.params = params;
    
    // 发送请求给服务器, 加载右侧的数据
    [XYRecommendUserTool recommendUserWithParam:params success:^(XYRecommendUserResult *result) {
        // 字典数组 -> 模型数组
        NSArray *users = [XYRecommendUser mj_objectArrayWithKeyValuesArray:result.list];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_footer endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSError *error) {
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 3.3.时刻监测footer的状态
- (void)checkFooterState
{
    XYRecommendCategory *rc = XYSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 左边的类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    // 监测footer的状态
    [self checkFooterState];
    
    // 右边的用户表格
    return [XYSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        XYRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XYCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        XYRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XYUserId];
        cell.user = [XYSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    XYRecommendCategory *c = self.categories[indexPath.row];
    if (c.users.count) {
        // 显示推荐分类列表的数据
        [self.userTableView reloadData];
    } else {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
    
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [XYRecommendUserTool invalidateSessionCancelingTasks];
}
@end
