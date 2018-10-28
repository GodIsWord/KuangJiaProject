//
//  JSBWebView.h
//  JSBridge
//
//  Created by pillar on 2018/10/27.
//  Copyright © 2018 pillar. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JSBWebView;
@protocol JSBWebViewHandleProtocol;

@interface JSBWebView : UIView

@property (nonatomic, strong, readonly) WKWebView *realView;
@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, strong, readonly) NSURLRequest *originRequest;
@property (nonatomic, strong, readonly) NSURLRequest *currentRequest;
@property (nonatomic, strong, readonly) NSURL *URL;

@property (nonatomic, weak) id <WKNavigationDelegate> navigationDelegate;
@property (nonatomic, weak) id <WKUIDelegate> UIDelegate;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;

// 进度条
@property (nonatomic, readonly) double estimatedProgress;

// 加载方法
- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

// 打开调试日志
+ (void)enableLogging;


// 前进后退
- (id)goBack;
- (id)goForward;
- (NSInteger)countOfHistory;
- (void)gobackWithStep:(NSInteger)step;

// 刷新
- (id)reload;
- (id)reloadFromOrigin;
- (void)stopLoading;

// 注册插件

- (void)registerJSHandle:(id<JSBWebViewHandleProtocol>)handle;
- (void)registerJSHandles:(NSArray <id<JSBWebViewHandleProtocol>>*)handles;


// 调用js代码
- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(nullable id)data;
- (void)callHandler:(NSString*)handlerName data:(nullable id)data responseCallback:(nullable void (^)(id responseData))responseCallback;

// 清理缓存
- (void)clearCache;


// 原生的不建议使用的
- (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name;
- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler;


@end

NS_ASSUME_NONNULL_END
