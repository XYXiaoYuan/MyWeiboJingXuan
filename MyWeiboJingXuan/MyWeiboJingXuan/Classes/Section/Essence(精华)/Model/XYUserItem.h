//
//  XYUser.h
//  bai
//
//  Created by yuan on 15/11/20.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYUserItem : NSObject
/** 用户名 */
@property(nonatomic,copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;
@end
