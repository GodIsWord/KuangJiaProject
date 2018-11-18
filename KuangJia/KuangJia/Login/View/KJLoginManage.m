//
//  KJLoginManage.m
//  KuangJia
//
//  Created by 黄艳红 on 2018/11/18.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJLoginManage.h"
#import "HttpRequestServices.h"

@implementation KJLoginManage

+(void)loginWithUserName:(NSString *)userName password:(NSString *)password  success:(void((^)(NSDictionary *result)))success fail:(void((^)(NSError *error)))fail{
//
//NSDictionary *params = @{@"cmd":@"portal.session.create",
//                         @"uid":userName?:@"",
//                         @"pwd":password?:@""};
    
    NSDictionary *params = @{@"cmd":@"portal.session.create",
                             @"uid":@"admin",
                             @"pwd":@"123"};
    [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
        
        NSDictionary *responseObject = respons;
        if ([responseObject.allKeys containsObject:@"data"]) {
            if ([responseObject[@"data"] isKindOfClass:NSString.class]) {
                NSString *str = [responseObject objectForKey:@"data"];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                if ([dict.allKeys containsObject:@"data"]) {
                    if ([dict[@"data"] isKindOfClass:NSDictionary.class]) {
                        if ([[dict[@"data"] allKeys] containsObject:@"sid"]) {
                            [HttpRequestServices sharedInstance].userSid = [dict[@"data"] objectForKey:@"sid"];
                            NSDictionary *data = dict[@"data"];
                            [[NSUserDefaults standardUserDefaults] setValue:data[@"sid"] forKey:@"sid"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                        }
                    }
                }
            }
        }
        if (success) {
            success(respons);
        }
        
    } faile:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

// 注册
+(void)registWithUserName:(NSString *)userName
                 password:(NSString *)password
                  success:(void((^)(NSDictionary *result)))success
                     fail:(void((^)(NSError *error)))fail{
    
    NSDictionary *params = @{@"cmd":@"org.user.create",
                             @"departmentId":@"43127819-0cbb-472b-a095-0d4c253d3722",
                             @"uid":userName?:@"",
                             @"userName":userName?:@"",
                             @"roleId":@"b5e2b9fb-bb86-4bb1-a549-5e75a575ebf3",
                             @"password":password?:@""};
    [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
        // 注册成功
        if (success) {
            success(respons);
        }
    } faile:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}


// 退出登录
+(void)exitsuccess:(void ((^)(NSDictionary *)))success fail:(void ((^)(NSError *)))fail{

    
    NSUserDefaults *sidDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *sid = [sidDefaults valueForKey:@"sid"];
    
    //注销 sid是登录之后返回的ID
    NSDictionary *params = @{@"cmd":@"portal.session.close",
                             @"sid":sid?:@""};
    [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
        
        if (success) {
            success(respons);
        }
    } faile:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
    
}
@end
