//
//  UIImageView+XYDownload.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/27.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (XYDownload)
/** 根据网络状态来下载不同图片大小 */
- (void)xy_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;

@end
