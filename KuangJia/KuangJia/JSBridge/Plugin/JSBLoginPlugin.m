//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBLoginPlugin.h"

@implementation JSBLoginPlugin

- (nonnull NSString *)handleName {
    return @"openLogin";
}

- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    NSLog(@"%s", __func__);
}
@end
