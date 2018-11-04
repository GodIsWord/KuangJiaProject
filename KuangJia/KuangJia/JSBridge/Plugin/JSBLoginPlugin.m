//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBLoginPlugin.h"
#import "KJLoginViewController.h"
@implementation JSBLoginPlugin

- (nonnull NSString *)handleName {
    return @"openLogin";
}

- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    KJLoginViewController *loginViewController = [[KJLoginViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    [self.presentingViewController presentViewController:na animated:YES completion:^{
        callback(@{@"result":@"ok...."});
    }];
    
}
@end
