//
//  XYRecommendCategoryCell.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYRecommendCategoryCell.h"
#import "XYRecommendCategory.h"

@interface XYRecommendCategoryCell()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end

@implementation XYRecommendCategoryCell

- (void)awakeFromNib
{
    self.backgroundColor = XYRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = XYRGBColor(219, 21, 26);
}

- (void)setCategory:(XYRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.xy_y = 2;
    self.textLabel.xy_height = self.contentView.xy_height - 2 * self.textLabel.xy_y;
}

/**
 * 可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : XYRGBColor(78, 78, 78);
}
@end
