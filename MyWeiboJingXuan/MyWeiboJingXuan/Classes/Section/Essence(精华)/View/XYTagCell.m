//
//  XYTagCell.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTagCell.h"
#import "XYTagResultItem.h"

// 万人阅读
#define TenThousandReadCount 10000.0

@interface XYTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image_listImageView;
@property (weak, nonatomic) IBOutlet UILabel *theme_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sub_numberLabel;

@end

@implementation XYTagCell

- (void)setTagModel:(XYTagResultItem *)tagModel
{
    _tagModel = tagModel;
    
    // 设置头像
    [self.image_listImageView setHeader:tagModel.image_list];
    // 设置名字
    self.theme_nameLabel.text = tagModel.theme_name;
    
    // 订阅数
    if (tagModel.sub_number >= TenThousandReadCount) {// 大于万人阅读就显示有多少万人阅读
        
        self.sub_numberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",tagModel.sub_number / TenThousandReadCount];
    }else{ // 有多少人阅读就显示多少人阅读
        self.sub_numberLabel.text = [NSString stringWithFormat:@"%zd人订阅",tagModel.sub_number];
    }
}


/**
 *  重写这个方法的目的:拦截cell的frame设置
 */

- (void)setFrame:(CGRect)frame
{
    // 高度减1产生分隔线
    frame.size.height -= 1;
    
    // 调用父类的方法重绘
    [super setFrame:frame];
}

@end
