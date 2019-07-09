//
//  XYMineResult.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYSquareItem;

@interface XYMineResult : NSObject

/** square_list */
@property(nonatomic, strong) NSArray<XYSquareItem *> *square_list;

@end
