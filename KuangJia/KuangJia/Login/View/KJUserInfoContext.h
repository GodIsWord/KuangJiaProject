//
//  KJUserInfoContext.h
//  KuangJia
//
//  Created by 黄艳红 on 2018/11/21.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJLoginModel.h"
@interface KJUserInfoContext : NSObject

@property(nonatomic,strong) KJLoginModel *userInfo;

+(KJUserInfoContext*)sharedUserInfoContext;
@end
