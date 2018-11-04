//
//  JSBSendMessagePlugin.m
//  KuangJia
//
//  Created by pillar on 2018/11/4.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "JSBSendMessagePlugin.h"
#import "YDSecritManger.h"
@implementation JSBSendMessagePlugin
- (nonnull NSString *)handleName {
    return @"sendMessage";
}
- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    // num 必须为String类型
    NSString *num = data[@"contact"];
    NSString *message = data[@"message"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [YDSecritManger sendMessageWithNum:@[num] message:message viewController:self.presentingViewController complation:^(YDSecritMangerMessageResult result) {
            callback(@{@"result":@(result)});
        }];
    });
}

@end
