//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBAlbumPlugin.h"

@interface JSBAlbumPlugin()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, copy) ResponseCallback callback;
@end

@implementation JSBAlbumPlugin


- (nonnull NSString *)handleName {
    return @"openAlbum";
}

- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback {
    NSLog(@"%s", __func__);
    // 保存回调
    self.callback = callback;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.presentingViewController presentViewController:pickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //image 是 iOS 特有的类
    // 如果要传给H5使用，请转换成NSData
    NSData *data = UIImageJPEGRepresentation(image, 0.7);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    self.callback(@{@"image":encodedImageStr});
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
