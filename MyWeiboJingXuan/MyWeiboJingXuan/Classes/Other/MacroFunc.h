#ifndef MacroFunc_h
#define MacroFunc_h

// 1.自定义NSLog
#ifdef DEBUG // 开发阶段-DEBUG阶段:使用Log
#define XYLog(...) NSLog(__VA_ARGS__)
#else // 发布阶段-上线阶段:移除Log
#define XYLog(...)
#endif

#define XYFuncLog XYLog(@"方法名是%s 第%d行",__func__,__LINE__)

// 2.适配
// 适配屏幕宽高
#define XYSCREEN_W [UIScreen mainScreen].bounds.size.width
#define XYSCREEN_H [UIScreen mainScreen].bounds.size.height
// 首页的选择器的宽度
#define Home_Seleted_Item_W 60
#define DefaultMargin       10
/** 适配问题 以iPhone5s的图适配所有尺寸的比率 */
#define XYWidthRatio  (XYSCREEN_W/320)
#define XYHeightRatio (XYSCREEN_H/568)
/** 系统适配*/
#define XYCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define XYiOS_7_OR_LATER       (XYCurrentSystemVersion >= 7.0)
#define XYiOS_8_OR_LATER       (XYCurrentSystemVersion >= 8.0)
#define XYiOS_9_OR_LATER       (XYCurrentSystemVersion >= 9.0)
/** 屏幕适配 */
#define XYiPhone4_OR_4s           (XYSCREEN_H == 320)
#define XYiPhone5_OR_5c_OR_5s     (XYSCREEN_H == 568)
#define XYiPhone6_OR_6s           (XYSCREEN_H == 667)
#define XYiPhone6Plus_OR_6sPlus   (XYSCREEN_H == 736)
/* 根据比例来设置frame,size,point */
#define XYCGRectMake(x, y, width, height) CGRectMake((x)*XYWidthRatio, (y)*XYHeightRatio, (width)*XYWidthRatio, (height)*XYHeightRatio)

#define XYCGSizeMake(width, height) CGSizeMake((width)*XYWidthRatio, (height)*XYHeightRatio)

#define XYCGPointMake(x, y) CGPointMake((x)*XYWidthRatio, (y)*XYHeightRatio)

#define XYUIEdgeInsetsMake(top, left, bottom, right) UIEdgeInsetsMake((top)*XYHeightRatio, (left)*XYWidthRatio, (bottom)*XYHeightRatio, (right)*XYWidthRatio)

// 3.字体
#define XYFont(x) [UIFont systemFontOfSize:(x)*XYWidthRatio]
#define XYBoldFont(x) [UIFont boldSystemFontOfSize:(x)*XYWidthRatio]
// 导航栏标题的字体
#define XYNavigationTitleFont XYBoldFont(18)

// 4.颜色
// 随机色
#define XYRandomColor [UIColor colorWithRed:arc4random_uniform(255) / 255.0f green:arc4random_uniform(255) / 255.0f blue:arc4random_uniform(255) / 255.0f alpha:1.0f]
// ARGB
#define XYARGBColor(a, r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)/255.0f]
// RGB
#define XYRGBColor(r, g, b) XYARGBColor(255.0,(r), (g), (b))

// 灰色
#define XYGrayColor(v) XYRGBColor((v), (v), (v))
#define XYCommonBgColor XYGrayColor(239)

// APP全局绿
#define XYGlobalGreen  XYRGBColor(9,187,7)

// 5.弱引用
#define XYWeakSelf __weak __typeof(self)weakSelf = self;
#define XYStrongSelf __strong __typeof(weakSelf)strongSelf = weakSelf;

// 6.通知
#define XYNotificationCenter [NSNotificationCenter defaultCenter]
#define XYAddObsver(methodName, noteName) [XYNotificationCenter addObserver:self selector:@selector(methodName) name:noteName object:nil];
#define XYRemoveObsver [XYNotificationCenter removeObserver:self];

/** 7.多线程GCD*/
#define XYGlobalGCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define XYMainGCD(block) dispatch_async(dispatch_get_main_queue(),block)

/** 8.数据存储*/
#define XYUserDefaults [NSUserDefaults standardUserDefaults]
#define XYCacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define XYDocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define XYTempDir NSTemporaryDirectory()

/** 9.其它 */
#define XYKeyWindow [UIApplication sharedApplication].keyWindow

#endif /* MacroFunc_h */
