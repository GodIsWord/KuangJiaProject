//
//  HttpRequestServices.h
//  OLinPiKe
//
//  Created by zhangyide on 16/6/1.
//  Copyright © 2016年 alta. All rights reserved.
//

#import <Foundation/Foundation.h>

//访问凭证
static NSString * const sz_access_key = @"32e07a6c-cec4-41ac-8c3c-3e2b0255ade0";

//密钥
static NSString * const sz_secret = @"123456";

static NSString * const sz_RequestHeader = @"http://www.wfis.com.cn:8088/portal/openapi";

typedef NS_ENUM (NSUInteger, SZRequestMethodType){
    SZRequestMethodTypeGet,
    SZRequestMethodTypePost
};


@interface HttpRequestServices : NSObject

@property (nonatomic , copy) NSString *userSid;

+ (instancetype)sharedInstance;
+ (void)deleteSharedInstance;

+ (BOOL)isExistenceNetwork;

+(void)requestHeaderUrl:(NSString*)header appending:(NSString*)appending httpMethod:(SZRequestMethodType)methodType withParameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *respons))success faile:(void(^)(NSError *error))faile;

+(void)requestAppending:(NSString*)appending httpMethod:(SZRequestMethodType)methodType withParameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *respons))success faile:(void(^)(NSError *error))faile;

@end


