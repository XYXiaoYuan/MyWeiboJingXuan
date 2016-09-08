//
//  XMGADItem.h
//  BuDeJie
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
// w_picurl,ori_curl:跳转到广告界面,w,h
@interface XYADItem : NSObject

/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@end
