//
//  XYCommentCell.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/24.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYCommentItem;

@interface XYCommentCell : UITableViewCell

/** 评论数据模型 */
@property(nonatomic,strong) XYCommentItem *commentItem;

@end
