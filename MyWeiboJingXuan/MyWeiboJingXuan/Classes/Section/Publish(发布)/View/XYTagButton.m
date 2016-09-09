//
//  XYTagButton.m
//  MyWeiboJingXuan
//
//  Created by yuan on 16/7/29.
//  Copyright (c) 2016年 袁小荣. All rights reserved.
//

#import "XYTagButton.h"

@implementation XYTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = XYTagBg;
        self.titleLabel.font = XYTagFont;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.xy_width += 3 * XYCommonSmallMargin;
    self.xy_height = XYTagH;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.xy_x = XYCommonSmallMargin;
    self.imageView.xy_x = CGRectGetMaxX(self.titleLabel.frame) + XYCommonSmallMargin;
}

@end
