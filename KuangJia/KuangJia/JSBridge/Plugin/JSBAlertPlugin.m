//
//  JSBridgeAlertPlugin.m
//  JSBridge
//
//  Created by pillar on 2018/10/28.
//  Copyright © 2018 pillar. All rights reserved.
//

#import "JSBAlertPlugin.h"

@implementation JSBAlertPlugin

- (nonnull NSString *)handleName {
    return @"showSheet";
}

- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"你猜我谈不谈?" message:@"不谈不谈,就不谈!!" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [vc addAction:cancelAction];
    [vc addAction:okAction];
    [self.presentingViewController presentViewController:vc animated:YES completion:nil];
}
@end
