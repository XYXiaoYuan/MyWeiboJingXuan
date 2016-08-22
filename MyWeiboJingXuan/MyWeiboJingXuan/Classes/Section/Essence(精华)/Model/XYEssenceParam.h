//
//  XYEssenceParam.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYEssenceParam : NSObject
/** a */
@property(nonatomic,strong) NSString *a;
/** c */
@property(nonatomic,strong) NSString *c;
/** type */
@property(nonatomic,assign) NSUInteger type;
/** maxtime */
@property(nonatomic,copy) NSString *maxtime;
@end
