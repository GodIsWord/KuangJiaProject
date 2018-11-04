//
//  WrapperViewController.h
//  KuangJia
//
//  Created by pillar on 2018/11/4.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WrapperViewController : UIViewController
@property (nonatomic, strong) NSArray *subViewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSInteger selectedIndex; // default value is 0

@end

NS_ASSUME_NONNULL_END
