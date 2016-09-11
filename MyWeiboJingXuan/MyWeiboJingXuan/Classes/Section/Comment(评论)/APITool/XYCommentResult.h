//
//  XYCommentResult.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYCommentItem;

@interface XYCommentResult : NSObject

/** data */
@property(nonatomic,strong) NSArray<XYCommentItem *> *data;
/** author */
@property(nonatomic,strong) NSString *author;
/** total */
@property(nonatomic,strong) NSString *total;
/** hot */
@property(nonatomic,strong) NSArray<XYCommentItem *> *hot;

@end
