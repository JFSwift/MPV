

//
//  CommonWebViewController.m
//  IMDemo
//
//  Created by iOS on 16/10/11.
//  Copyright © 2016年 ET. All rights reserved.
//

#import "CommonWebViewController.h"
#import <WebKit/WebKit.h>
#import "UIViewController+BackButtonHandler.h"

@interface CommonWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,BackButtonHandlerProtocol>
@property (strong, nonatomic)   UIProgressView * progressView;
@end

@implementation CommonWebViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        [self initProgressView];
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initWKWebView];
}
// 创建WKWebview
- (void)initWKWebView
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 14.0;
    configuration.preferences = preferences;
    self.webView = ({
        WKWebView * webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [self.view addSubview:webView];
        webView;
    });
    
}
// 加载提示进度条
- (void)initProgressView
{
    self.progressView = ({
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kTopHeight, SCREEN_WIDTH, 1)];
        progressView.tintColor = Main_Select_TextColor;
        progressView.trackTintColor = Main_Disabled_TextColor;
        [self.view addSubview:progressView];
        progressView;
    });
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}
- (BOOL)navigationShouldPopOnBackButton {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return NO;
    }
    return YES;
}
#pragma mark ==================set方法加载网页内容===================
- (void) setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    if (!urlString && urlString.length==0) {
        [[[UIAlertView alloc]initWithTitle:@"无效网址" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
        return;
    }
    
    NSURL *url = [self smartURLForString:urlString];
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else{
        [[[UIAlertView alloc]initWithTitle:@"无效网址" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
}

/**
 验证网址是否有效
 
 @param str 网址字符
 @return 返回验证的网址地址
 */
- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                return nil;
            }
        }
    }
    
    return result;
}
#pragma mark - KVO
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - WKUIDelegate

//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.getElementById('mobile').value"completionHandler:^(id result,NSError *_Nullable error) {
        //获取页面高度，并重置webview的frame
        
    }];
    self.navigationItem.title = self.webView.title;
}
// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [[[UIAlertView alloc]initWithTitle:@"页面加载失败，请检查网址" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}
//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [[[UIAlertView alloc]initWithTitle:@"无效网址" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark ==================移除监听网页加载进度条===================
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
