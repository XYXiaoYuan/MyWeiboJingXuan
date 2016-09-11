//
//  XYRecommendCategory.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYRecommendCategoryItem.h"
#import <MJExtension.h>

@implementation XYRecommendCategoryItem

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
