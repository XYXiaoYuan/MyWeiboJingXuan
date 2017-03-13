//
//  XYCommentViewController.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/23.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYCommentViewController.h"
#import <MJExtension.h>
#import "XYCommentTool.h"
#import "XYRefreshGifHeader.h"
#import "XYRefreshAutoFooter.h"
#import "XYCommentSectionHeader.h"
#import "XYCommentCell.h"
#import "XYTopicCell.h"
#import "XYCommentItem.h"
#import "XYTopicItem.h"

@interface XYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 热门评论 */
@property(nonatomic,strong) NSArray<XYCommentItem *> *hotestComments;
/** 最新评论 */
@property(nonatomic,strong) NSMutableArray<XYCommentItem *> *latestComments;
/** 最热评论 */
@property (nonatomic, strong) XYCommentItem *savedTopCmt;
/** 存储请求结果的总评论数 */
@property(nonatomic,assign) NSInteger total;
@end

@implementation XYCommentViewController
// 重用标识
static NSString * const XYCommentCellId = @"comment";
static NSString * const XYCommentCellHeaderId = @"header";

#pragma mark - 初始化操作
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] selectedImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(popToRootViewController)];
    
    // 1.设置基本的数据
    [self setupBase];
    
    // 2.设置tableView
    [self setupTable];
    
    // 3.设置头部的view
    [self setupHeaderView];
    
    // 4.刷新数据
    [self setupRefresh];
}

/** 测试回到根控制器后,再选中tabBar中的第3个的子控制器 */
- (void)popToRootViewController
{
    self.tabBarController.selectedIndex = 3;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

#pragma mark - 1.设置基本的数据
- (void)setupBase
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 2.设置tableView
- (void)setupTable
{
    self.navigationItem.title = @"评论";
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

#pragma mark - 3.设置头部的view
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

#pragma mark - 4.刷新数据
- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [XYRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载更多
    self.tableView.mj_footer = [XYRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

#pragma mark - 4.1.加载最新评论
- (void)loadNewComments
{
    //取消任务,防止下拉加载和上拉刷新同时进行
    [XYCommentTool cancel];
    
    // 参数
    XYCommentParam *param = [[XYCommentParam alloc] init];
    param.data_id = self.topic.ID;
    param.hot = 1; // @"1"
    
    XYWeakSelf
    // 发送请求
    [XYCommentTool commentWithParam:param success:^(XYCommentResult *result) {
        // 发送成功
        // 没有任何评论数据
        if (![result isKindOfClass:[XYCommentResult class]]) {
            // 让刷新控件结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        
        // 字典数据 -> 模型数组
        weakSelf.latestComments = [XYCommentItem mj_objectArrayWithKeyValuesArray:result.data];
        weakSelf.hotestComments = [XYCommentItem mj_objectArrayWithKeyValuesArray:result.hot];
        
        // 记录下就算没有下拉,也有多少条总评论数
        self.total = [result.total integerValue];
        
        // 刷新数据
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 4.2.加载更多评论
- (void)loadMoreComments
{
    //取消任务
    [XYCommentTool cancel];

    // 参数
    XYCommentParam *param = [[XYCommentParam alloc] init];
    param.data_id = self.topic.ID;
    param.lastcid = self.latestComments.lastObject.ID;
    
    XYWeakSelf
    // 发送请求
    [XYCommentTool commentWithParam:param success:^(XYCommentResult *result) {
        // 不再有评论数据了
        if (![result isKindOfClass:[XYCommentResult class]]) {
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        
        // 字典数据 -> 模型数组
        NSArray<XYCommentItem *> *moreComments = [XYCommentItem mj_objectArrayWithKeyValuesArray:result.data];
        [self.latestComments addObjectsFromArray:moreComments];
        
        // 记录下拉到最后加载到的总最新评论条数
        self.total = [result.total intValue];
        
        // 刷新数据
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
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
    // 隐藏footer
    self.tableView.mj_footer.hidden = (self.latestComments.count == self.total);
    
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    
    // 第1组 || 没有最热评论数据
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    XYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XYCommentCellId];
    
    // 2.根据不同的组设置模型数据
    if (indexPath.section == 0 && self.hotestComments.count) {
        // 热门评论
        cell.commentItem = self.hotestComments[indexPath.row];
    } else {
        // 最新评论
        cell.commentItem = self.latestComments[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 3.返回cell
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

#pragma mark - 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHeight = 0;
}

@end
