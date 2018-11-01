//
//  LZResultDisplayController.h
//  LZSearchController
//
//  Created by xb on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KJResultDisplayControllerDelegate <NSObject>
- (void)searchResult:(NSString *)country;
@end
@interface KJResultDisplayController : UITableViewController<UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, weak) id<KJResultDisplayControllerDelegate> delegate;

@end
