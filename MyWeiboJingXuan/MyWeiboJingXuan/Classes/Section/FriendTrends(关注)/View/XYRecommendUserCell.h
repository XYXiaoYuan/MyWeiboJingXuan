//
//  XYRecommendUserCell.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYRecommendUserItem;

@interface XYRecommendUserCell : UITableViewCell

/** 用户模型 */
@property (nonatomic, strong) XYRecommendUserItem *user;

@end
