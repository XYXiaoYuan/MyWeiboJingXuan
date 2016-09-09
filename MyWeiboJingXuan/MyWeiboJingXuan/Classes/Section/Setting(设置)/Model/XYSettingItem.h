//
//  HSSettingItem.h
//  BreakfastHeart
//
//  Created by 袁小荣 on 16/8/2.
//  Copyright © 2016年 zaocanxin. All rights reserved.
//  所有设置模型的基类,所有其它类型的模型,如箭头模型,开头模型都是继承自这个设置模型的基类,然后再在这个基类的基础上添加额外的右侧视图

#import <Foundation/Foundation.h>

/** 点击cell时执行操作的block */
typedef  void (^operationBlock)();

@interface XYSettingItem : NSObject

/** 图片 */
//@property (nonatomic, strong) NSString *icon;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 子标题 */
@property (nonatomic, strong) NSString *subTitle;

/** 点击cell调用的block 定义block保存将来要执行的代码*/
@property (nonatomic, copy) operationBlock operation;

/** 定制图片和标题的类方法 */
+ (instancetype)initWithTitle:(NSString *)title;

@end
