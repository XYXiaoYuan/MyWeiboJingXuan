//
//  XYCommentViewController.m
//  bai
//
//  Created by yuan on 15/11/23.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYCommentViewController.h"
#import "XYRefreshNormalHeader.h"
#import "XYRefreshAutoFooter.h"
#import <MJExtension.h>
#import "XYCommentSectionHeader.h"
#import "XYCommentCell.h"
#import "XYCommentItem.h"
#import "XYTopicItem.h"
#import "XYTopicCell.h"

@interface XYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 热门评论 */
@property(nonatomic,strong) NSArray<XYCommentItem *> *hotestComments;

/** 最新评论 */
@property(nonatomic,strong) NSMutableArray<XYCommentItem *> *latestComments;

/** 最热评论 */
@property (nonatomic, strong) XYCommentItem *savedTopCmt;

@end

@implementation XYCommentViewController
// 重用标识
static NSString * const XYCommentCellId = @"comment";
static NSString * const XYCommentCellHeaderId = @"header";


#pragma mark - 初始化操作
- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置基本的数据
    [self setupBase];
    
    // 设置tableView
    [self setupTable];
    
    // 刷新数据
    [self setupRefresh];
    
    // 设置头部的view
    [self setupHeaderView];
}

- (void)setupHeaderView
{
    // 处理模型数据
    self.savedTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    
    // 创建cell
    XYTopicCell *cell = [XYTopicCell viewFromXib];
    cell.topic = self.topic;
    
    // 创建headerView
    UIView *headerView = [[UIView alloc] init];
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    self.tableView.tableHeaderView = headerView;
    
    // 设置header的高度
    headerView.xy_height = cell.xy_height + XYCommonMargin * 2;
    
    // 添加cell到headerView中
    [headerView addSubview:cell];
    
}

- (void)setupTable
{
    self.tableView.backgroundColor = XYCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 设置cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    // 设置headerView的高度
    self.tableView.sectionHeaderHeight = XYFont(14).lineHeight + 2;
    
    // 注册
    // XYCommentCellId,通过xib来注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYCommentCell class]) bundle:nil] forCellReuseIdentifier:XYCommentCellId];
    
    // XYCommentCellHeaderId,通过类来注册
    [self.tableView registerClass:[XYCommentSectionHeader class]forHeaderFooterViewReuseIdentifier:XYCommentCellHeaderId];
}


- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [XYRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载更多
    self.tableView.mj_footer = [XYRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

#pragma mark - 加载数据
- (void)loadNewComments
{
    //取消任务,防止下拉加载和上拉刷新同时进行
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    
//    // 参数
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"a"] = @"dataList";
//    param[@"c"] = @"comment";
//    param[@"data_id"] = self.topic.ID;
//    param[@"hot"] = @1; // @"1"
//    
//    XYWeakSelf
//    // 发送请求
//    [self.manager GET:XYRequestURL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        // 发送成功
//        // 没有任何评论数据
//        if (![responseObject isKindOfClass:[NSDictionary class]]) {
//            // 让刷新控件结束刷新
//            [weakSelf.tableView.mj_header endRefreshing];
//            return;
//        }
//        
//        // 字典数据 -> 模型数组
//        weakSelf.latestComments = [XYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        weakSelf.hotestComments = [XYComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
//        
//        // 刷新数据
//        [weakSelf.tableView reloadData];
//        
//        // 结束刷新
//        [weakSelf.tableView.mj_header endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 结束刷新
//        [weakSelf.tableView.mj_header endRefreshing];
//    }];
}

- (void)loadMoreComments
{
//    //取消任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    
//    // 参数
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"a"] = @"dataList";
//    param[@"c"] = @"comment";
//    param[@"data_id"] = self.topic.ID;
//    param[@"lastcid"] = self.latestComments.lastObject.ID;
//    
//    
//    XYWeakSelf
//    // 发送请求
//    [self.manager GET:XYRequestURL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        // 不再有评论数据了
//        if (![responseObject isKindOfClass:[NSDictionary class]]) {
//            [weakSelf.tableView.mj_footer endRefreshing];
//            return;
//        }
//        
//        // 字典数据 -> 模型数组
//        NSArray<XYComment *> *moreComments = [XYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.latestComments addObjectsFromArray:moreComments];
//        
//        // 刷新数据
//        [weakSelf.tableView reloadData];
//        
//        
//        int total = [responseObject[@"total"] intValue];;
//        if (weakSelf.latestComments.count == total) { // 提示用户:没有更多数据了
//            weakSelf.tableView.mj_footer.hidden = YES;
//        } else { // 还没有加载完全
//            // 结束刷新
//            [weakSelf.tableView.mj_footer endRefreshing];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 结束刷新
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];

}


- (void)setupBase
{
    self.navigationItem.title = @"评论";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


/** 当键盘将要改变frame时调用 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 修改约束
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomSpace.constant = screenH - keyboardY;
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];

}

/** 移除通知 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHeight = 0;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 有热门评论 + 最新评论
    if (self.hotestComments.count) return 2;
    // 没有最热评论,有最新评论数据
    if (self.latestComments.count)  return 1;
    
    // 没有最热评论,也没有最新评论
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    
    // 第1组 || 没有最热评论数据
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XYCommentCellId];
    if (indexPath.section == 0 && self.hotestComments.count) {
        // 热门评论
        cell.comment = self.hotestComments[indexPath.row];
    } else {
        // 最新评论
        cell.comment = self.latestComments[indexPath.row];
    }
    return cell;
}


#pragma mark - <UIScrollViewDelegate>

/** 设置头部标题 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XYCommentSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XYCommentCellHeaderId];
    if (section == 0 && self.hotestComments.count) {
        header.textLabel.text = @"最热评论";
    } else {
        header.textLabel.text = @"最新评论";
    }
    return header;
}

/** 当用户开始拖拽的时候会调用*/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    [self.view endEditing:YES];
}



@end
