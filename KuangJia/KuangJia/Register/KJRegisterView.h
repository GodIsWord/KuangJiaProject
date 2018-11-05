//
//  KJRegisterView.h
//  KuangJia
//
//  Created by xb on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJTextField.h"
@protocol KJRegisterViewDelegate <NSObject>
- (void)country;
- (void)next;

@end
@interface KJRegisterView : UIView
@property (strong, nonatomic) KJTextField *mobileTextField;
@property (nonatomic, weak) id<KJRegisterViewDelegate> delegate;

@end
