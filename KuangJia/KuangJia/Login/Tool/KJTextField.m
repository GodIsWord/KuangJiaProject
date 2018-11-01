//
//  KJTextField.m

//  Created by xiaoBai on 18/10/26.
//  Copyright © 2018年 KuangJia. All rights reserved.
//

#import "KJTextField.h"

@interface KJTextField ()

@end
@implementation KJTextField
- (void)didMoveToWindow{
    [super didMoveToWindow];
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:0.9],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
   
}

// 密码输入框不可以粘贴复制
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    return NO ;
    
}

@end
