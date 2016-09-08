//
//  XYRecommendParam.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/8.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYRecommendUserParam : NSObject

/** a */
@property(nonatomic,strong) NSString *a;
/** c */
@property(nonatomic,strong) NSString *c;
/** category_id */
@property(nonatomic,assign) NSInteger category_id;
/** page */
@property(nonatomic,assign) NSInteger page;

@end
