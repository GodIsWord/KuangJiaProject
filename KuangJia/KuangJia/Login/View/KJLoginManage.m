//
//  KJLoginManage.m
//  KuangJia
//
//  Created by 黄艳红 on 2018/11/18.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJLoginManage.h"
#import "HttpRequestServices.h"


@interface KJLoginManage()
@property (nonatomic, strong)dispatch_source_t time;

@end
@implementation KJLoginManage

//+ (instancetype)sharedInstance
//{
//    static id shared_instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        shared_instance = [[self alloc] init];
//    
//    });
//    return shared_instance;
//}

+(void)loginWithUserName:(NSString *)userName password:(NSString *)password  success:(void((^)(NSDictionary *result)))success fail:(void((^)(NSError *error)))fail{
    
    NSDictionary *params = @{@"cmd":@"portal.session.create",
                             @"uid":userName,
                             @"pwd":password};
    [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {

        NSDictionary *responseObject = respons;
        if ([responseObject.allKeys containsObject:@"data"]) {
            if ([responseObject[@"data"] isKindOfClass:NSString.class]) {
                NSString *str = [responseObject objectForKey:@"data"];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                if ([dict.allKeys containsObject:@"data"]) {
                    if ([dict[@"data"] isKindOfClass:NSDictionary.class] && [[dict[@"data"] allKeys] containsObject:@"sid"] && [dict[@"result"]  isEqualToString:@"ok"]) {
                        // 记录本地
                        [HttpRequestServices sharedInstance].userSid = [dict[@"data"] objectForKey:@"sid"];
                        if (success) {
                            success(respons);
                        }
                        
                    }else{
                        NSLog(@"erroe:%@",[dict objectForKey:@"msg"]);
                        
                        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1022 userInfo:@{NSLocalizedDescriptionKey:dict[@"msg"]}];
                        if (fail) {
                            fail(error);
                        }
                    }
                }
            }
        }else{
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1022 userInfo:@{NSLocalizedDescriptionKey:@"登录失败"}];
            if (fail) {
                fail(error);
            }
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
                             @"roleId":@"893a7f46-3930-43bf-a9e5-18a5a7a3703e",
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
+(void)checkWithUser {
    //check测试 每隔5分钟
    NSLog(@"打印");
    NSUserDefaults *sidDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *sid = [sidDefaults valueForKey:@"sid"];
    NSDictionary *params = @{@"cmd":@"portal.session.check",
                             @"sid":sid?:@""};
    [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
        
    } faile:^(NSError *error) {
        
    }];
    
}
@end
