//
//  YDSecritManger.m
//  KuangJia
//
//  Created by yide zhang on 2018/11/4.
//  Copyright © 2018年 yidezhang. All rights reserved.
//

#import "YDSecritManger.h"

#import <MessageUI/MessageUI.h>


@interface YDSecritManger()<MFMessageComposeViewControllerDelegate>

@property (nonatomic, copy) void (^massageResultHandle) (YDSecritMangerMessageResult result);

@end

@implementation YDSecritManger

static YDSecritManger *manager;

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [YDSecritManger new];
    });
    return manager;
}

+(void)selectPhoneNumViewController:(UIViewController *)viewController isCanSelect:(BOOL)isCanSelect complection:(void (^)(NSString *, NSString *))completcion
{
    if (!viewController) {
        return;
    }
    [[LJContactManager sharedInstance] selectContactAtController:viewController isCanSelect:isCanSelect complection:completcion];
}


+(void)addNewUserPhoneNum:(NSString *)newNumber viewController:(UIViewController *)viewController userType:(YDSecritMangerContactAddType)type
{
    if (!viewController) {
        return;
    }
    switch (type) {
        case YDSecritMangerContactAddTypeNewContact:
        {
            [[LJContactManager sharedInstance] createNewContactWithPhoneNum:newNumber controller:viewController];
        }
            break;
        case YDSecritMangerContactAddTypeCurrentUser:
        {
            [[LJContactManager sharedInstance] addToExistingContactsWithPhoneNum:newNumber controller:viewController];
        }
            break;
            
        default:
            break;
    }
    
}

+(void)contactsListComplaction:(void (^)(BOOL, NSArray<LJPerson *> *))completcion
{
    [[LJContactManager sharedInstance] accessContactsComplection:completcion];
}

+(void)contactsSectionListComplaction:(void (^)(BOOL, NSArray<LJSectionPerson *> *, NSArray<NSString *> *))completcion
{
    [[LJContactManager sharedInstance] accessSectionContactsComplection:completcion];
}

+(void)sendMessageWithNum:(NSArray<NSString*> *)numbers message:(NSString *)message viewController:(UIViewController *)viewController complation:(void (^)(YDSecritMangerMessageResult))complation
{
    //发送短信
    if( [MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = numbers;//发送短信的号码，数组形式入参
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = message; //此处的body就是短信将要发生的内容
        controller.messageComposeDelegate = [YDSecritManger shareInstance];
        [viewController presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"title"];//修改短信界面标题
        [[YDSecritManger shareInstance] setMassageResultHandle:complation];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

//mesage代理
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
    YDSecritMangerMessageResult resultYD ;
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            resultYD = YDSecritMangerMessageResultSent;
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            resultYD = YDSecritMangerMessageResultFailed;
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            resultYD = YDSecritMangerMessageResultCancelled;
            break;
        default:
            break;
    }
    if (manager.massageResultHandle) {
        manager.massageResultHandle(resultYD);
    }
    manager.massageResultHandle = nil;
}

+(void)callPhoneWithNum:(NSString *)number
{
    NSString * string = [NSString stringWithFormat:@"telprompt:%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

@end
