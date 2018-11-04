//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBAlbumPlugin.h"

@implementation JSBAlbumPlugin


- (nonnull NSString *)handleName {
    return @"openAlbum";
}

- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    NSLog(@"%s", __func__);
}
@end