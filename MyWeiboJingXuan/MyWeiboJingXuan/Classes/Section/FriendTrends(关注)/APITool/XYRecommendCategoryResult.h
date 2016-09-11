//
//  XYRecommendCategoryResult.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYRecommendInfoItem,XYRecommendCategory;

@interface XYRecommendCategoryResult : NSObject
/** info */
@property(nonatomic,strong) XYRecommendInfoItem *info;
/** total */
@property(nonatomic,assign) NSInteger total;
/** list */
@property(nonatomic,strong) NSArray<XYRecommendCategory *> *list;
/** size */
@property(nonatomic,assign) NSInteger size;
@end
