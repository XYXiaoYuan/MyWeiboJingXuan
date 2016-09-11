//
//  XYEssenceInfoItem.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/11.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYEssenceInfoItem : NSObject

/** maxid */
@property(nonatomic,strong) NSString *maxid;
/** vendor */
@property(nonatomic,strong) NSString *vendor;
/** count */
@property(nonatomic,assign) NSInteger count;
/** maxtime */
@property(nonatomic,strong) NSString *maxtime;
/** page */
@property(nonatomic,assign) NSInteger page;

@end
