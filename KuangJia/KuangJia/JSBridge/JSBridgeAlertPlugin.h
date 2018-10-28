//
//  JSBridgeAlertPlugin.h
//  JSBridge
//
//  Created by pillar on 2018/10/28.
//  Copyright © 2018 pillar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBWebViewHandleProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface JSBridgeAlertPlugin : NSObject <JSBWebViewHandleProtocol>
@property (nonatomic, weak) UIViewController *presentingViewController;
@end

NS_ASSUME_NONNULL_END
