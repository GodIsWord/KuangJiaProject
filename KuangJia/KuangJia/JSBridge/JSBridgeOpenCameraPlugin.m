//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBridgeOpenCameraPlugin.h"

@implementation JSBridgeOpenCameraPlugin {

}


- (nonnull NSString *)handleName {
    return @"openCamera";
}
- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    NSLog(@"需要%@图片", data[@"count"]);
    UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
    imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.presentingViewController presentViewController:imageVC animated:YES completion:nil];
}
@end