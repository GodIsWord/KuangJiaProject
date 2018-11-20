//
//  KJUserInfoContext.m
//  KuangJia
//
//  Created by 黄艳红 on 2018/11/21.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJUserInfoContext.h"

@implementation KJUserInfoContext
@synthesize userInfo;
static KJUserInfoContext *sharedUserInfoContext = nil;

+(KJUserInfoContext*)sharedUserInfoContext{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(sharedUserInfoContext == nil){
            sharedUserInfoContext = [[self alloc] init];
        }
    });
    return sharedUserInfoContext;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(sharedUserInfoContext == nil){
            sharedUserInfoContext = [super allocWithZone:zone];
        }
    });
    return sharedUserInfoContext;
}
- (instancetype)init{
    self = [super init];
    if(self){
        //实例化这个Models
        sharedUserInfoContext.userInfo = [[KJLoginModel alloc] init];
    }
    return self;
}
- (id)copy{
    return self;
}
- (id)mutableCopy{
    return self;
}
@end
