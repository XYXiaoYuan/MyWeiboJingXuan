//
//  XYEssenceResult.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYEssenceInfoItem;
@interface XYEssenceResult : NSObject
/** info */
@property(nonatomic,strong) XYEssenceInfoItem *info;
/** list */
@property(nonatomic,strong) NSArray *list;
@end
