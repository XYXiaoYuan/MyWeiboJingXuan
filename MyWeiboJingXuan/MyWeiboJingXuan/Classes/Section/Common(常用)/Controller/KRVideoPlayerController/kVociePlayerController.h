//
//  XFVociePlayerController.h
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface kVociePlayerController : UIViewController
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) NSInteger totalTime;
-(void)dismiss;
@end
