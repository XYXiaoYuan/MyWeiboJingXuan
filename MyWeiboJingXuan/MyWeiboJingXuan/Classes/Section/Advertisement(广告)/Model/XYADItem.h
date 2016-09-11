//
//  XYADItem.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAdItem : NSObject
/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat w;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat h;
@end
