//
//  XYTagItem.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYTagResultItem : NSObject

/** 图片 */
@property(nonatomic,copy) NSString *image_list;
/** theme_id */
@property(nonatomic,strong) NSString *theme_id;
/** 名字 */
@property(nonatomic,copy) NSString *theme_name;
/** is_sub */
@property(nonatomic,assign) BOOL is_sub;
/** is_default */
@property(nonatomic,assign) BOOL is_default;
/** 订阅数 */
@property(nonatomic,assign) NSInteger sub_number;

@end
