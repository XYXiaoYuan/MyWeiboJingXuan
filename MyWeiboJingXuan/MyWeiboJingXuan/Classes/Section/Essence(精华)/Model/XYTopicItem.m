//
//  XYTopic.m
//  MyWeiboJingXuan
//
//  Created by yuan on 15/11/12.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYTopicItem.h"
#import "XYUserItem.h"
#import "XYCommentItem.h"

@implementation XYTopicItem

static NSDateFormatter *fmt_;


// 在这里手动计算cell的高度
- (CGFloat)cellHeight
{
    // 如果cell的高度已经计算过,就直接返回
    if (_cellHeight) return _cellHeight;
    
    // cell的高度
    // 1.头像
    _cellHeight = 55;
    
    // 2.文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * XYCommonMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    
    // 累加
    _cellHeight += textSize.height + XYCommonMargin;
    
    // 3.图片
    if (self.type != XYTopicTypeWord) { // 非段子才需要计算高度
        // 交叉相乘, textMaxW * cententH = self.width * self.height
        CGFloat cententH = textMaxW * self.height / self.width;
        
        // 如果计算出的图片高度大于屏幕高度,就判定为图片为长图
        if (cententH >= [UIScreen mainScreen].bounds.size.height) {
            // 设置中间内容的高度为200
            cententH = 200;
            // 为长图
            self.bigPicture = YES;
        }
        _contentF = CGRectMake(XYCommonMargin, _cellHeight, textMaxW, cententH);
        
        // 累加
        _cellHeight += cententH + XYCommonMargin;
    }
    
    // 4.最热评论
    if (self.top_cmt) { // 有评论
        // 最热评论标题
        _cellHeight += 20;
        
        // 最热评论内容
        
        // 语音消息处理
        if (self.top_cmt.voiceuri.length) {
            self.top_cmt.content = @"[语音评论]";
        }
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
        
        // 根据评论数据的字体大小等等来计算最热评论的整体的高度
        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
        
        // 累加
        _cellHeight += topCmtContentSize.height + XYCommonMargin;
    }
    
    
    // 5.底部工具条
    _cellHeight += 35 + XYCommonMargin;
    
    return _cellHeight;
}

+ (void)initialize
{
    fmt_ =[[NSDateFormatter alloc] init];
}

// 重写 setCreated_at 的get方法
- (NSString *)created_at
{
    // 在这里判断时间,利用分类
    
    // 日期格式化类
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // NSString ->NSDate
    NSDate *createAtDate = [fmt_ dateFromString:_created_at];
    
    // 比较 手机当前时间 和 发帖时间的差值
    NSDateComponents *comps = [createAtDate intervalToNow];
    
    // 判断
    if (createAtDate.isThisYear)
    { // 今年
            if (createAtDate.isToday)
            {  // 今天
                if (comps.hour >= 1)
                { // 几小时前
                    return [NSString stringWithFormat:@"%zd小时前",comps.hour];
                }
                else if (comps.minute >= 1)
                {  // 几分钟前
                    return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
                    
                }
                else
                {
                     return [NSString stringWithFormat:@"%zd秒前",comps.second];
                }
            }
            else if (createAtDate.isYesterday)
            {
                // 昨天,返回昨天HH-mm-ss
                fmt_.dateFormat = @"昨天 HH-mm-ss";
                return [fmt_ stringFromDate:createAtDate];
            } else
            {
                // 今年的其它时间
                fmt_.dateFormat = @"MM-dd HH-mm-ss";
                return [fmt_ stringFromDate:createAtDate];
            }
    }
    else
    { // 非今年的
        
        return _created_at;
    }
}

@end
