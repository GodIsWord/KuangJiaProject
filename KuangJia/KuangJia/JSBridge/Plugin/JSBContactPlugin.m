//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBContactPlugin.h"
#import "YDSecritManger.h"
@implementation JSBContactPlugin

- (nonnull NSString *)handleName {
    return @"openContact";
}

- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    NSLog(@"%s", __func__);
    [YDSecritManger selectPhoneNumViewController:self.presentingViewController complection:^(NSString *name, NSString *phone) {
        callback(@{@"name":name,@"phone":phone});
    }];

}
@end
