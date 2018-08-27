//
//  CommonWebViewController.h
//  IMDemo
//
//  Created by iOS on 16/10/11.
//  Copyright © 2016年 ET. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WKWebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>

@interface CommonWebViewController : UIViewController
@property (nonatomic, strong) WKWebView *webView;
//@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, copy) NSString *urlString;
@end
