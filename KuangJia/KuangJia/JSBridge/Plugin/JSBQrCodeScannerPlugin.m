//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBQrCodeScannerPlugin.h"

@implementation JSBQrCodeScannerPlugin

- (nonnull NSString *)handleName {
    return @"openCamera";
}
- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    NSLog(@"%s",__func__);
}
@end
