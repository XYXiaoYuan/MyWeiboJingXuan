//
//  XYSquareCell.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYSquareCell.h"
#import <UIImageView+WebCache.h>
#import "XYSquareItem.h"

@interface XYSquareCell ()
/** 图标的imageView */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 名字的label */
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@end

@implementation XYSquareCell

- (void)setSquareItem:(XYSquareItem *)squareItem {
    _squareItem = squareItem;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:squareItem.icon]];
    self.nameView.text = squareItem.name;
}

@end
