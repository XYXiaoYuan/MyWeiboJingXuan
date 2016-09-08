//
//  XYSquareCell.m
//  bai
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
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
