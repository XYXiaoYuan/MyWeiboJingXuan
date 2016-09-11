//
//  XYRecommendUserResult.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYRecommendUserItem;

@interface XYRecommendUserResult : NSObject
/** count */
@property(nonatomic,assign) NSInteger count;
/** next_page */
@property(nonatomic,assign) NSInteger next_page;
/** total */
@property(nonatomic,assign) NSInteger total;
/** list */
@property(nonatomic,assign) NSArray<XYRecommendUserItem *> *list;
/** total_page */
@property(nonatomic,assign) NSInteger total_page;
@end
