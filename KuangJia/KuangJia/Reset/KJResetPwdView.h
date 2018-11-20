//
//  KJResetPwdView.h
//  KuangJia
//
//  Created by 黄艳红 on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJTextField.h"
@protocol KJResetPwdViewDelegate <NSObject>
- (void)dissmiss;
- (void)next;

@end

@interface KJResetPwdView : UIView
@property (nonatomic, weak) id<KJResetPwdViewDelegate> delegate;
@property (strong, nonatomic) KJTextField *oldPwdTextField;
@property (strong, nonatomic) KJTextField *nowPwdTextField;
@property (strong, nonatomic) KJTextField *makesurePwdTextField;
@end
