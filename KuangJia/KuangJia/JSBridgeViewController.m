//
//  JSBridgeViewController.m
//  KuangJia
//
//  Created by pillar on 2018/10/28.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "JSBridgeViewController.h"
#import "JSBWebView.h"
#import "JSBridgeAlertPlugin.h"
#import "JSBridgeOpenCameraPlugin.h"
@interface JSBridgeViewController ()
@property (nonatomic, strong) JSBWebView *webView;
@end

@implementation JSBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 打开Debug日志
    [JSBWebView enableLogging];
    
    CGFloat webMaxY = self.view.bounds.size.height - 120;
    JSBWebView *view = [[JSBWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,webMaxY )];
    view.navigationDelegate = self;
    [self.view addSubview:view];
    self.webView = view;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"京东" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, webMaxY, 60, 40);
    [button addTarget:self action:@selector(callJSHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"调用JS方法" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button3.frame = CGRectMake(60 * 1, webMaxY, 100, 40);
    [button3 addTarget:self action:@selector(getUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"前进" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, webMaxY+40, 60, 40);
    [button1 addTarget:self action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"后退" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.frame = CGRectMake(0, webMaxY+2*40, 60, 40);
    [button2 addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:indexPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseUrl = [NSURL fileURLWithPath:indexPath];
    [self.webView loadHTMLString:appHtml baseURL:baseUrl];
    
    // 加载插件Alert
    JSBridgeAlertPlugin *alert = [JSBridgeAlertPlugin new];
    alert.presentingViewController = self;
    [self.webView registerJSHandle:alert];
    
    JSBridgeOpenCameraPlugin *openCameraPlugin = [JSBridgeOpenCameraPlugin new];
    openCameraPlugin.presentingViewController = self;
    [self.webView registerJSHandle:openCameraPlugin];
    
}


- (void)callJSHandle {
    //pushToNewWebSite
    [self.webView callHandler:@"pushToNewWebSite" data:@{@"url":@"https://www.jd.com/"}];
}
- (void)goForward {
    [self.webView goForward];
}
- (void)goBack {
    [self.webView goBack];
}
- (void)getUserInfo {
    [self.webView callHandler:@"getUserInfo" data:@{@"xx":@"666"} responseCallback:^(id responseData) {
        NSLog(@"------ %@",responseData);
    }];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s",__func__);
}@end
