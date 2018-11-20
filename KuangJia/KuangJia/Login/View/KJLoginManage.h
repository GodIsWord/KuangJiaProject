//
//  KJLoginManage.h
//  KuangJia
//
//  Created by 黄艳红 on 2018/11/18.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJLoginModel.h"
@interface KJLoginManage : NSObject

+(void)SetNSUserDefaults:(KJLoginModel *)userInfo;

+(KJLoginModel *)GetNSUserDefaults;
// 登录
+(void)loginWithUserName:(NSString *)userName
                password:(NSString *)password
                 success:(void((^)(NSDictionary *result)))success
                    fail:(void((^)(NSError *error)))fail;

// 注册
+(void)registWithUserName:(NSString *)userName
                password:(NSString *)password
                 success:(void((^)(NSDictionary *result)))success
                    fail:(void((^)(NSError *error)))fail;
// 修改密码
+(void)resetWithOldpwd:(NSString *)oldpwd
                 newpwd:(NSString *)newpwd
                  success:(void((^)(NSDictionary *result)))success
                     fail:(void((^)(NSError *error)))fail;

// 注销
+(void)exitsuccess:(void((^)(NSDictionary *result)))success
                    fail:(void((^)(NSError *error)))fail;


+(void)checkWithUser;
@end
