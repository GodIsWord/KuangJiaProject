//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBOpenCameraPlugin.h"
#import "YDCamoraViewController.h"

@interface JSBOpenCameraPlugin () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, copy) ResponseCallback callback;
@end

@implementation JSBOpenCameraPlugin

- (nonnull NSString *)handleName {
    return @"openCamera";
}

- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    // 保存回调
    NSLog(@"H5传过来的参数： %@",data);
    self.callback = callback;
    YDCamoraViewController *camora = [[YDCamoraViewController alloc] init];
    [self.presentingViewController presentViewController:camora animated:YES completion:nil];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSData *data = UIImageJPEGRepresentation(image, 0.7);
//    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    self.callback(@{@"image": encodedImageStr});
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
@end
