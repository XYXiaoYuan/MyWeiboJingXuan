//
//  XYMeViewController.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYMineViewController.h"
#import <MJExtension.h>
#import "XYMineTool.h"
#import "XYSquareItem.h"
#import "XYSquareCell.h"
#import "XYWebViewController.h"
#import "XYSettingViewController.h"
#import <UIImageView+WebCache.h>

static NSString * const XYSquareCellID = @"XYSquareCell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (XYSCREEN_W - (cols - 1) * margin) / cols
@interface XYMineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray<XYSquareItem *> *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation XYMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupNavBar];
    
    // 设置tableView底部视图
    [self setupFootView];
    
    // 展示方块内容 -> 请求数据
    [self loadData];
    
    // 处理cell间距,默认tableView分组样式,有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(10 - 35, 0, 0, 0);
}

#pragma mark - 请求数据
- (void)loadData
{
    // 1.参数
    XYMineParam *params = [[XYMineParam alloc] init];
    
    // 2.发送请求
    [XYMineTool mineDataWithParam:params success:^(XYMineResult *result) {
        
        // 字典数组转换成模型数组
        _squareItems = [XYSquareItem mj_objectArrayWithKeyValuesArray:result.square_list];
        
        // 处理数据
        [self resloveData];
        
        // 设置collectionView 计算collectionView高度 = rows * itemWH
        // Rows = (count - 1) / cols + 1  3 cols4
        NSInteger count = _squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        // 设置collectioView高度
        self.collectionView.xy_height = rows * itemWH + 10;
        
        // 设置tableView滚动范围:自己计算
        self.tableView.tableFooterView = self.collectionView;
        
        // 刷新表格
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 处理请求完成数据
- (void)resloveData
{
    // 判断下缺几个
    // 3 % 4 = 3 cols - 3 = 1
    // 5 % 4 = 1 cols - 1 = 3
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            XYSquareItem *item = [[XYSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
    
}

#pragma mark - 设置tableView底部视图
- (void)setupFootView{
    /*
        1.初始化要设置流水布局
        2.cell必须自定义
        3.cell必须要注册
     */
    // 1.初始化要设置流水布局
    UICollectionViewFlowLayout *layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置cell尺寸
        layout.itemSize = CGSizeMake(itemWH, itemWH);
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = margin;
        layout;
    });
    
    // 2.创建UICollectionView
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
        collectionView.backgroundColor = self.tableView.backgroundColor;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.scrollEnabled = NO;
        self.tableView.tableFooterView = collectionView;
        _collectionView = collectionView;
        collectionView;
    });
    
    // 3.注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(XYSquareCell.class) bundle:nil] forCellWithReuseIdentifier:XYSquareCellID];
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYSquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    
    XYWebViewController *webVc = [[XYWebViewController alloc] init];
    webVc.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVc animated:YES];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    XYSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XYSquareCellID forIndexPath:indexPath];
    // 2.设置模型数据
    cell.squareItem = self.squareItems[indexPath.item];
    
    // 3.返回cell
    return cell;
}

- (void)setupNavBar
{
    // titleView
    self.navigationItem.title = @"我的";
    
    // 设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模型
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];

    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    
}

- (void)night:(UIButton *)button
{
    button.selected = !button.selected;
}

#pragma mark - 设置就会调用
- (void)setting
{
    // 跳转到设置界面
    XYSettingViewController *settingVc = [[XYSettingViewController alloc] init];
    
    settingVc.title = @"设置";
    
    [self.navigationController pushViewController:settingVc animated:YES];
}

@end
