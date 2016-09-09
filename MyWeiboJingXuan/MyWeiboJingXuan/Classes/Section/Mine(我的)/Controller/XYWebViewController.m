//
//  XMGWebViewController.m
//  bai
//
//  Created by yuan on 15/11/10.
//  Copyright © 2015年 袁小荣. All rights reserved.
//

#import "XYWebViewController.h"
#import <WebKit/WebKit.h>

@interface XYWebViewController ()
/** 展示网页的内容view */
@property (weak, nonatomic) IBOutlet UIView *contentView;
/** 向后一步 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
/** 向前一步 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
/** 进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** WKWebView webView */
@property(nonatomic,weak) WKWebView *webView;
@end

@implementation XYWebViewController

#pragma mark - 生命周期方法
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _webView.frame = self.contentView.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    // 添加webView
    WKWebView *webView = ({
        WKWebView *webView = [[WKWebView alloc] init];
        [self.contentView addSubview:webView];
        
        // 展示网页
        [webView loadRequest:request];
        
        _webView = webView;
        webView;
    });
    
    // KVO监听属性改变
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;
    // 向后一步
    [webView addObserver:self forKeyPath:@"canGoBack" options:options context:nil];
    // 向前一步
    [webView addObserver:self forKeyPath:@"canGoForward" options:options context:nil];
    // 进度条
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    // 导航栏标题
    [webView addObserver:self forKeyPath:@"title" options:options context:nil];
}

#pragma mark - 向后一步
- (IBAction)goBack:(id)sender
{
    [self.webView goBack];
}

#pragma mark - 向前一步
- (IBAction)goForward:(id)sender
{
    [self.webView goForward];
}

#pragma mark - 重新加载
- (IBAction)reload:(id)sender
{
    [self.webView reload];
}

#pragma mark - 只要观察对象属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
    self.title = self.webView.title;
}

#pragma mark - 对象被销毁
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
