//
//  XYRecommendCategoryCell.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYRecommendCategoryItem;

@interface XYRecommendCategoryCell : UITableViewCell

/** 类别模型 */
@property (nonatomic, strong) XYRecommendCategoryItem *category;

@end
