//
//  XYLoginTool.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/8/6.
//  Copyright (c) 2015年 袁小荣. All rights reserved.
//

#import "XYLoginTool.h"
#import "XYLoginRegisterViewController.h"

@implementation XYLoginTool

+ (void)setUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUid
{
    return [self getUid:NO];
}

+ (NSString *)getUid:(BOOL)showLoginController
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
    
    if (showLoginController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            XYLoginRegisterViewController *login = [[XYLoginRegisterViewController alloc] init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        });
    }
    
    return uid;
}

@end
