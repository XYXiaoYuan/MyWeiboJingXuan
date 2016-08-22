//
//  XYTagCell.h
//  bai
//
//  Created by yuan on 15/11/19.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTagItem;
@interface XYTagCell : UITableViewCell

/** tag模型 */
@property(nonatomic,strong) XYTagItem *tagModel;

@end
