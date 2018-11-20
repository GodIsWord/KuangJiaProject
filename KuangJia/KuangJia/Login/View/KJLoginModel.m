//
//  KJLoginModel.m
//  KuangJia
//
//  Created by 黄艳红 on 2018/11/18.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJLoginModel.h"

@implementation KJLoginModel
@synthesize uid;
@synthesize sid;

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.sid forKey:@"sid"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
 
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self =[super init]) {
        self.sid = [aDecoder decodeObjectForKey:@"sid"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];

    }
    return self;
}

@end
