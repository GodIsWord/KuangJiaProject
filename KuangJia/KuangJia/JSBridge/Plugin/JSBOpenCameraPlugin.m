//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBOpenCameraPlugin.h"

@implementation JSBOpenCameraPlugin

- (nonnull NSString *)handleName {
    return @"openCamera";
}
- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    NSLog(@"%s",__func__);
}
@end
