//
//  KJLoginModel.h
//  KuangJia
//
//  Created by 黄艳红 on 2018/11/18.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJLoginModel : NSObject<NSCoding>{
    NSString *uid;
    NSString *sid;

}

@property (copy, nonatomic) NSString *uid;//一个合法的AWS登录账户名
@property (copy, nonatomic) NSString *sid;//sid是登录之后返回的ID

@end
