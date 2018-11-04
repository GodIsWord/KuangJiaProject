//
//  JSBCallContactPlugin.m
//  KuangJia
//
//  Created by pillar on 2018/11/4.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "JSBCallContactPlugin.h"
#import "YDSecritManger.h"

@implementation JSBCallContactPlugin
- (nonnull NSString *)handleName {
    return @"callContact";
}
- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    NSString *num = data[@"contact"];
    [YDSecritManger callPhoneWithNum:num];
}

@end
