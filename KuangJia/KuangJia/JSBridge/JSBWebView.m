//
//  JSBWebView.m
//  JSBridge
//
//  Created by pillar on 2018/10/27.
//  Copyright © 2018 pillar. All rights reserved.
//

#import "JSBWebView.h"
#import "JSBWebViewHandleProtocol.h"
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

@interface JSBWebView ()
@property (nonatomic, strong, readwrite) WKWebView *realView;
@property (nonatomic, readwrite) double estimatedProgress;
@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, strong, readwrite) NSURLRequest *currentRequest;
@property (nonatomic, strong, readwrite) NSURLRequest *originRequest;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@end

@implementation JSBWebView

#pragma mark  - init

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize {

    /**
     * 初始化 WKWebView
     */
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]
            init];
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];

    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;

    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];

    [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:webView];

    self.realView = webView;
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];

}

- (void)setUIDelegate:(id <WKUIDelegate>)UIDelegate {
    self.realView.UIDelegate = UIDelegate;
}

- (void)setNavigationDelegate:(id <WKNavigationDelegate>)navigationDelegate {
    [self.bridge setWebViewDelegate:navigationDelegate];
}

+ (void)enableLogging {
    [WKWebViewJavascriptBridge enableLogging];
}

#pragma mark - Publich Methods

- (id)loadRequest:(NSURLRequest *)request {
    self.originRequest = request;
    self.currentRequest = request;
    return [self.realView loadRequest:request];
}

- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
    return [self.realView loadHTMLString:string baseURL:baseURL];
}

- (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name {
    if (scriptMessageHandler && name.length) {
        [self.realView.configuration.userContentController addScriptMessageHandler:scriptMessageHandler name:name];
    }
}

- (NSInteger)countOfHistory {
    return self.realView.backForwardList.backList.count;
}

- (void)gobackWithStep:(NSInteger)step {
    if (!self.canGoBack) {
        return;
    }
    if (step > 0) {
        NSInteger historyCount = self.countOfHistory;
        if (step >= historyCount) {
            step = historyCount - 1;
        }
        WKWebView *webView = self.realView;
        WKBackForwardListItem *backItem = webView.backForwardList.backList[(NSUInteger) step];
        [webView goToBackForwardListItem:backItem];
    } else {
        [self goBack];
    }
}

- (id)goBack {
    if ([self canGoBack]) {
        return [self.realView goBack];
    }
    return nil;
}

- (id)goForward {
    if ([self canGoForward]) {
        return [self.realView goForward];
    }
    return nil;
}

- (id)reload {
    return [self.realView reload];
}

- (id)reloadFromOrigin {
    return [self.realView reloadFromOrigin];
}

- (void)stopLoading {
    [self.realView stopLoading];
}


- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler {
    return [self.realView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}

- (BOOL)canGoBack {
    return self.realView.canGoBack;
}

- (BOOL)canGoForward {
    return self.realView.canGoForward;
}

- (BOOL)isLoading {
    return self.realView.isLoading;
}

- (NSURL *)URL {
    return self.realView.URL;
}

- (void)registerJSHandle:(id <JSBWebViewHandleProtocol>)handle {
    [self.bridge registerHandler:handle.handleName handler:^(id data, WVJBResponseCallback responseCallback) {
        [handle handleWithData:data responseCallback:responseCallback];
    }];
}

- (void)registerJSHandles:(NSArray <id <JSBWebViewHandleProtocol>> *)handles {
    for (id <JSBWebViewHandleProtocol> obj in handles) {
        [self registerJSHandle:obj];
    }
}

// 调用js代码
- (void)callHandler:(NSString *)handlerName {
    [self callHandler:handlerName data:nil];
}

- (void)callHandler:(NSString *)handlerName data:(nullable id)data {
    [self callHandler:handlerName data:data responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(nullable id)data responseCallback:(nullable void (^)(id responseData))responseCallback {
    [self.bridge callHandler:handlerName data:data responseCallback:responseCallback];
}

- (void)clearCache {
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
            NSUserDomainMask, YES)[0];
    NSString *bundleId = [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit", libraryDir];
    NSString *webKitFolderInCaches = [NSString
            stringWithFormat:@"%@/Caches/%@/WebKit", libraryDir, bundleId];
    NSString *webKitFolderInCachesfs = [NSString
            stringWithFormat:@"%@/Caches/%@/fsCachedData", libraryDir, bundleId];

    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];

    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
}

#pragma mark - Private Methods
// TODO:
#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
        NSLog(@"loading:%f", self.estimatedProgress);
    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = change[NSKeyValueChangeNewKey];
        NSLog(@"title:%@", self.title);
    } else if ([keyPath isEqualToString:@"loading"]) {
        id isLoading = change[NSKeyValueChangeNewKey];
        NSLog(@"isLoading:%@", isLoading);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Dealloc

- (void)dealloc {

    [self.realView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.realView removeObserver:self forKeyPath:@"title"];
    [self.realView removeObserver:self forKeyPath:@"loading"];
    [self.realView stopLoading];
    [self.realView loadHTMLString:@"" baseURL:nil];
    [self.realView stopLoading];
    [self.realView removeFromSuperview];
    self.realView = nil;
    NSLog(@"%@ dealloc ", self);
}

@end
