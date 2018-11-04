//
//  JSBridgeViewController.m
//  KuangJia
//
//  Created by pillar on 2018/10/28.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "JSBridgeViewController.h"
#import "JSBWebView.h"
#import "JSBPlugins.h"
@interface JSBridgeViewController () <WKNavigationDelegate>
@property (nonatomic, strong) JSBWebView *webView;
@end

@implementation JSBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 打开Debug日志
    [JSBWebView enableLogging];
    
    JSBWebView *view = [[JSBWebView alloc] initWithFrame:self.view.bounds];
    view.navigationDelegate = self;
    [self.view addSubview:view];
    self.webView = view;

    // 加载插件


    JSBOpenCameraPlugin *openCameraPlugin = [[JSBOpenCameraPlugin alloc] init];
    openCameraPlugin.presentingViewController = self;

    JSBAlbumPlugin *albumPlugin = [[JSBAlbumPlugin alloc] init];
    albumPlugin.presentingViewController = self;

    JSBContactPlugin *contactPlugin = [[JSBContactPlugin alloc] init];
    contactPlugin.presentingViewController = self;

    JSBLoginPlugin *loginPlugin = [[JSBLoginPlugin alloc] init];
    loginPlugin.presentingViewController = self;

    JSBQrCodeScannerPlugin *qrCodeScannerPlugin = [[JSBQrCodeScannerPlugin alloc] init];
    qrCodeScannerPlugin.presentingViewController = self;

    [self.webView registerJSHandles:@[openCameraPlugin,
                                      albumPlugin,
                                      contactPlugin,
                                      loginPlugin,
                                      qrCodeScannerPlugin]];


    if (self.url) {
        NSURL *url = [NSURL URLWithString:self.url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    } else if (self.filePath) {
        NSString *appHtml = [NSString stringWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
        NSURL *baseUrl = [NSURL fileURLWithPath:self.filePath];
        [self.webView loadHTMLString:appHtml baseURL:baseUrl];
    }

}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s",__func__);
}@end
