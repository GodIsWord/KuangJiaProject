//
//  KJCountryTableViewController.h
//  KuangJia
//
//  Created by xb on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KJCountryTableViewControllerDelegate <NSObject>
- (void)searchCountry:(NSString *)country;
@end
@interface KJCountryTableViewController : UITableViewController
@property (nonatomic, weak) id<KJCountryTableViewControllerDelegate> delegate;

@end
