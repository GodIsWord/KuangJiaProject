//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBWebViewHandleProtocol.h"

@interface JSBQrCodeScannerPlugin : NSObject <JSBWebViewHandleProtocol>
@property (nonatomic, weak) UIViewController *presentingViewController;
@end