//
//  XYModelConfig.m
//  bai
//
//  Created by yuan on 15/11/20.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYModelConfig.h"
#import <MJExtension.h>
#import "XYTopic.h"
#import "XYComment.h"

@implementation XYModelConfig

// 加载到内存的时候会自动调用,不用我们去调用它
+ (void)load
{
    [XYTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"big_image" : @"image1"
                 };
    }];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
}


@end
