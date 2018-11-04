//
//  JSBSendMessagePlugin.h
//  KuangJia
//
//  Created by pillar on 2018/11/4.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBWebViewHandleProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface JSBSendMessagePlugin : NSObject <JSBWebViewHandleProtocol>
@property (nonatomic, weak) UIViewController *presentingViewController;
@end

NS_ASSUME_NONNULL_END
