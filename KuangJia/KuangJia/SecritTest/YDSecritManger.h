//
//  YDSecritManger.h
//  KuangJia
//
//  Created by yide zhang on 2018/11/4.
//  Copyright © 2018年 yidezhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LJContactManager.h"

typedef NS_ENUM(NSUInteger, YDSecritMangerContactAddType) {
    YDSecritMangerContactAddTypeNewContact,//创建新的联系人
    YDSecritMangerContactAddTypeCurrentUser,//添加到现有联系人
};

typedef NS_ENUM(NSUInteger, YDSecritMangerMessageResult) {
    YDSecritMangerMessageResultCancelled,//用户取消
    YDSecritMangerMessageResultSent,//发送成功
    YDSecritMangerMessageResultFailed//发送失败
};

@interface YDSecritManger : NSObject


/**
 获取系统的联系人信息界面

 @param viewController 弹出系统通讯录界面的viewcontroller
 @param completcion 调用结束后的回调
 */
+(void)selectPhoneNumViewController:(UIViewController*)viewController isCanSelect:(BOOL)isCanSelect complection:(void (^)(NSString *name, NSString *phone))completcion;


/**
 添加电话号码到通讯录

 @param newNumber 需要添加的手机号
 @param viewController 弹出添加界面的viewcontroller
 @param type 手机号需要添加的地方 现有联系人 还是新创建联系人
 */
+(void)addNewUserPhoneNum:(NSString*)newNumber viewController:(UIViewController*)viewController userType:(YDSecritMangerContactAddType)type;


/**
 获取通讯录所有联系人信息

 @param completcion 获取后的回调
 */
+(void)contactsListComplaction:(void (^)(BOOL, NSArray<LJPerson *> *))completcion;


/**
 获取通讯录所有联系人分组后的信息

 @param completcion 获取后的回调
 */
+(void)contactsSectionListComplaction:(void (^)(BOOL succeed, NSArray <LJSectionPerson *> *contacts, NSArray <NSString *> *keys))completcion;



/**
 发送短信

 @param numbers 发送信息的手机号
 @param message 发送的消息
 @param viewController 弹出发送界面的controller
 */
+(void)sendMessageWithNum:(NSArray<NSString*> *)numbers message:(NSString*)message viewController:(UIViewController *)viewController complation:(void (^) (YDSecritMangerMessageResult result)) complation;


/**
 拨打电话

 @param number 电话号码
 */
+(void)callPhoneWithNum:(NSString *)number;

@end
