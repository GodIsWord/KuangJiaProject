//
//  JSBWebViewHandleProtocol.h
//  JSBridge
//
//  Created by pillar on 2018/10/28.
//  Copyright © 2018 pillar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ResponseCallback)(id responseData);
@protocol JSBWebViewHandleProtocol <NSObject>
@required
- (NSString *)handleName;
- (void)handleWithData:(id)data responseCallback:(ResponseCallback)callback;
@end

NS_ASSUME_NONNULL_END
