//
// Created by pillar on 2018/10/28.
// Copyright (c) 2018 pillar. All rights reserved.
//

#import "JSBAlbumPlugin.h"
#import "YDPhotoAlbumNaviViewController.h"
@interface JSBAlbumPlugin() <YDPhotoAlbumViewControllerDelegate>
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
    YDPhotoAlbumNaviViewController *controller = [[YDPhotoAlbumNaviViewController alloc] init];
    controller.finishDelegate = self;
    [self.presentingViewController presentViewController:controller animated:YES completion:nil];

}

-(void)YDPhotoAlbumViewControllerSelectFinishResult:(NSArray *)resultes
{
   self.callback(@{@"images":resultes.description});
}
@end
