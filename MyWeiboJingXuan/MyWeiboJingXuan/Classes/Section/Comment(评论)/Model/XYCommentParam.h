//
//  XYCommentParam.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYCommentParam : NSObject
/** a */
@property(nonatomic,strong) NSString *a;
/** c */
@property(nonatomic,strong) NSString *c;
/** data_id */
@property(nonatomic,strong) NSString *data_id;
/** lastcid */
@property(nonatomic,strong) NSString *lastcid;
/** hot */
@property(nonatomic,assign) NSUInteger hot;
@end
