//
//  ProfileViewController.m
//  KuangJia
//
//  Created by pillar on 2018/11/4.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "ProfileViewController.h"
#import "WrapperViewController/WrapperViewController.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parentViewController.navigationItem.title = @"页面切换";

    
    // Do any additional setup after loading the view.
}
- (IBAction)swichWebView:(id)sender {
    // 切换到下一个兄弟视图
    WrapperViewController *parentViewController = (WrapperViewController *)self.parentViewController;
    NSUInteger count = parentViewController.subViewControllers.count;
    NSInteger nextIndex = (parentViewController.selectedIndex + 1) % count;
    parentViewController.selectedIndex = nextIndex;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
