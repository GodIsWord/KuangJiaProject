//
//  KJForgetView.h
//  KuangJia
//
//  Created by 黄艳红 on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJTextField.h"
@protocol KJForgetViewDelegate <NSObject>
- (void)country;
- (void)next;

@end

@interface KJForgetView : UIView
@property (strong, nonatomic) KJTextField *mobileTextField;
@property (nonatomic, weak) id<KJForgetViewDelegate> delegate;

@end
