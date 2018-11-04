//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBQrCodeScannerPlugin.h"
#import "YDScanerNaviViewController.h"

@implementation JSBQrCodeScannerPlugin

- (nonnull NSString *)handleName {
    return @"openQrCodeScanner";
}
- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    YDScanerNaviViewController *navi = [[YDScanerNaviViewController alloc] init];
    [self.presentingViewController presentViewController:navi animated:YES completion:nil];
}
@end
