//
//  LFNavigationController.m
//  LeFly
//
//  Created by 袁小荣 on 16/7/21.
//  Copyright © 2016年 YouXingChangYou. All rights reserved.
//

#import "LFNavigationController.h"
#import "UIViewController+LFNavigationExtension.h"

#define kDefaultBackImageName @"navigationButtonReturn"

#pragma mark - LFWrapNavigationController

@interface LFWrapNavigationController : UINavigationController

@end

@implementation LFWrapNavigationController

/** 压入栈 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 如果现在push的不是栈底控制器(最先push进来的那个控制器),就隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.lf_navigationController = (LFNavigationController *)self.navigationController;
        viewController.lf_fullScreenPopGestureEnabled = viewController.lf_navigationController.fullScreenPopGestureEnabled;
        
        UIImage *backButtonImage = viewController.lf_navigationController.backButtonImage;
        
        if (!backButtonImage) {
            backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
        }
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:backButtonImage highlightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(didTapBackButton)];
    }
    
    // 注意, 这里压入的是一个包装过后的控制器LFWarpViewController
    [self.navigationController pushViewController:[[LFWrapViewController new]wrapViewController:viewController] animated:animated];
}

/** 点击返回按钮 */
- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

/** 出栈 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 弹出应该找到包裹viewController的那个LFWarpViewController,pop该控制器
    LFNavigationController *lf_navigationController = viewController.lf_navigationController;
    NSInteger index = [lf_navigationController.lf_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:lf_navigationController.viewControllers[index] animated:animated];
}


-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.lf_navigationController = nil;
}

@end

#pragma mark - LFWrapViewController
@interface LFWrapViewController ()

/** 用户的传进来的控制器包装一层以后的nav ----> 解决懒加载问题 */
@property(nonatomic, strong)LFWrapNavigationController *WrapNav;

@end

static NSValue *lf_tabBarRectValue;

@implementation LFWrapViewController

-(LFWrapViewController *)wrapViewController:(UIViewController *)viewController{
    // 创建导航控制器
    LFWrapNavigationController *WrapNav = [[LFWrapNavigationController alloc]init];
    // 把传进来的控制器用导航控制器包装
    WrapNav.viewControllers = @[viewController];
    
    [self addChildViewController:WrapNav];
    
    self.WrapNav = WrapNav;
    
    // 返回
    return self;
}

/* 解决懒加载问题 */
-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 把导航控制器的view添加到到新建的viewController上面, 把导航控制器作为新建view的子控制器
    [self.view addSubview:self.WrapNav.view];
}

/** 传进来的被包装的控制器 */
-(UIViewController *)rootViewController{
    LFWrapNavigationController *WrapNav = self.childViewControllers.firstObject;
    return WrapNav.viewControllers.firstObject;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !lf_tabBarRectValue) {
        lf_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && lf_tabBarRectValue) {
        self.tabBarController.tabBar.frame = lf_tabBarRectValue.CGRectValue;
    }
}

- (BOOL)lf_fullScreenPopGestureEnabled {
    return [self rootViewController].lf_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

@end

#pragma mark - LFNavigationController 导航控制器
@interface LFNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation LFNavigationController

/**  当第一次使用这个类的时候调用1次 */
+ (void)initialize
{
    if (self == [LFNavigationController class]) {
        // 设置UINavigationBarTheme的主
        [self setupNavigationBarTheme];
        
        // 设置UIBarButtonItem的主题
        [self setupBarButtonItemTheme];
    }
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
//    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor : [UIColor colorWithWhite:0.0f alpha:1.0f]];
    [shadow setShadowOffset : CGSizeZero];
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor : [UIColor colorWithWhite:0.0f alpha:1.0f]];
    [shadow setShadowOffset : CGSizeZero];
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
//    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}



- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        rootViewController.lf_navigationController = self;
        self.viewControllers = @[[[LFWrapViewController new] wrapViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.lf_navigationController = self;
        self.viewControllers = @[[[LFWrapViewController new] wrapViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.lf_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 该方法是询问代理, 当有一个手势对应多个操作的时候,是否同步执行多个操作
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter
- (NSArray *)lf_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (LFWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}

@end
