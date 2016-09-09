//
//  XYRecommendCategory.h
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//  推荐关注 左边的数据模型

#import <Foundation/Foundation.h>

@interface XYRecommendCategory : NSObject
/** id */
@property (nonatomic, assign) NSInteger ID;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end
