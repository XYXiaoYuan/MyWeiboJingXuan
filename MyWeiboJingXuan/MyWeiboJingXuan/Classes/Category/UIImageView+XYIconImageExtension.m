//
//  UIImageView+XYIconImageExtension.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "UIImageView+XYIconImageExtension.h"
#import <UIImageView+WebCache.h>


@implementation UIImageView (XYIconImageExtension)
- (void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
}


- (void)setRectHeader:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];}

- (void)setCircleHeader:(NSString *)url
{
    XYWeakSelf;
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:
     ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         // 如果图片下载失败，就不做任何处理，按照默认的做法：会显示占位图片
         if (image == nil) return;
         
         weakSelf.image = [image circleImage];
     }];
    
}

@end
