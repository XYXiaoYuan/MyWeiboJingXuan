//
//  XYAddTagViewController.h
//  MyWeiboJingXuan
//
//  Created by yuan on 16/7/29.
//  Copyright (c) 2016年 袁小荣. All rights reserved.
//

#import "XYBaseViewController.h"

@interface XYAddTagViewController : XYBaseViewController
/** 获取tags的block */
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);

/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;
@end
