//
//  XYAddTagToolbar.m
//  bai
//
//  Created by yuan on 16/7/29.
//  Copyright (c) 2016年 袁小荣. All rights reserved.
//

#import "XYAddTagToolbar.h"
#import "XYAddTagViewController.h"

@interface XYAddTagToolbar()
/** 顶部控件 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 添加按钮 */
@property (weak, nonatomic) UIButton *addButton;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;
@end

@implementation XYAddTagToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib
{
    // 添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.xy_size = addButton.currentImage.size;
    addButton.xy_x = XYCommonSmallMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    
    // 默认就拥有2个标签
    [self createTagLabels:@[@"吐槽", @"糗事"]];
}

- (void)addButtonClick
{
    XYAddTagViewController *vc = [[XYAddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [vc setTagsBlock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    vc.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:vc animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.xy_x = 0;
            tagLabel.xy_y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + XYCommonSmallMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.xy_width - leftWidth;
            if (rightWidth >= tagLabel.xy_width) { // 按钮显示在当前行
                tagLabel.xy_y = lastTagLabel.xy_y;
                tagLabel.xy_x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.xy_x = 0;
                tagLabel.xy_y = CGRectGetMaxY(lastTagLabel.frame) + XYCommonSmallMargin;
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + XYCommonSmallMargin;
    
    // 更新textField的frame
    if (self.topView.xy_width - leftWidth >= self.addButton.xy_width) {
        self.addButton.xy_y = lastTagLabel.xy_y;
        self.addButton.xy_x = leftWidth;
    } else {
        self.addButton.xy_x = 0;
        self.addButton.xy_y = CGRectGetMaxY(lastTagLabel.frame) + XYCommonSmallMargin;
    }
    
    // 整体的高度
    CGFloat oldH = self.xy_height;
    self.xy_height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.xy_y -= self.xy_height - oldH;
}

/**
 * 创建标签
 */
- (void)createTagLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = XYTagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = XYTagFont;
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.xy_width += 2 * XYCommonSmallMargin;
        tagLabel.xy_height = XYTagH;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
}

@end
