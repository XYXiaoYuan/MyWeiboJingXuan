//
//  XMGSquareCell.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/16.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XYSquareCell.h"
#import <UIImageView+WebCache.h>
#import "XYSquareItem.h"
@interface XYSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation XYSquareCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(XYSquareItem *)item
{
    _item = item;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
    
    
}

@end
