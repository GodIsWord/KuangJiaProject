//
//  JFLoginView.h
//
//  Created by xiaoBai on 18/10/26.
//  Copyright © 2018年 KuangJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJTextField.h"
@protocol KJLoginViewDelegate <NSObject>
- (void)country;
- (void)forget;
- (void)login;
- (void)regist;
- (void)more;
@end

@interface KJLoginView : UIView
@property (strong, nonatomic) KJTextField *mobileTextField;
@property (strong, nonatomic) KJTextField *passwordTextField;
@property (nonatomic, weak) id<KJLoginViewDelegate> delegate;

@end
