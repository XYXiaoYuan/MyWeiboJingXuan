//
//  XYTagItem.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYTagItem : NSObject
/** 图片 */
@property(nonatomic,copy) NSString *image_list;
/** 订阅数 */
@property(nonatomic,assign) NSInteger sub_number;
/** 名字 */
@property(nonatomic,copy) NSString *theme_name;
@end
