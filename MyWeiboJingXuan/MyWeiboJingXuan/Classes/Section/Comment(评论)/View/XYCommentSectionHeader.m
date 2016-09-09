//
//  XYCommentSectionHeader.m
//  bai
//
//  Created by yuan on 15/11/24.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYCommentSectionHeader.h"

@implementation XYCommentSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]){
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = XYCommonBgColor;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.font = XYFont(14);
    
    self.textLabel.xy_x = XYCommonSmallMargin;
}

@end
