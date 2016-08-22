// XYConst.m ：定义所有的全局常量

#import <UIKit/UIKit.h>

/** 请求路径 */
NSString * const XYRequestURL = @"http://api.budejie.com/api/api_open.php";

/** 统一的间距 */
CGFloat const XYCommonMargin = 10;

/** 统一较小的间距 */
CGFloat const XYCommonSmallMargin = 5;

/** 导航栏最大的Y值 */
CGFloat const XYNavBarMaxY = 64;

/** UITabBar的高度 */
CGFloat const XYTabBarH = 49;

/** XMGTitlesView的高度 */
CGFloat const XYTitlesViewH = 35;

/** 标签的高度 */
CGFloat const XYTagH = 25;

/** XYUser - sex - male */
NSString *const XYUserSexMale = @"m";

/** XYUser - sex - female */
NSString *const XYUserSexFemale = @"f";

/*** 通知 ***/
/** TabBar按钮被重复点击的通知 */
NSString * const XYTabBarButtonDidRepeatClickNotification = @"XYTabBarButtonDidRepeatClickNotification";
/** 标题按钮被重复点击的通知 */
NSString * const XYTitleButtonDidRepeatClickNotification = @"XYTitleButtonDidRepeatClickNotification";


