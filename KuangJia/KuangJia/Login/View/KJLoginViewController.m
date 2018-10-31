//
//  JFLoginViewController.m
//
//  Created by xiaoBai on 18/10/26.
//  Copyright © 2018年 KuangJia. All rights reserved.
//

#import "KJLoginViewController.h"
#import "KJLoginView.h"
#import "XBMacroDefinition.h"
#import "Masonry.h"
#import "KJRegisterViewController.h"
@interface KJLoginViewController () <UIViewControllerTransitioningDelegate,UITableViewDelegate>{
    
}

@property (strong, nonatomic) KJLoginView *headView;

@end

@implementation KJLoginViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubbView];
}


- (void)initSubbView{
    
    self.headView = [[KJLoginView alloc] init];
    [self.view addSubview:self.headView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeEdit)];
    [self.headView addGestureRecognizer:tap];
    self.headView.na = self.navigationController;
    
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //掉透明导航栏边黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    [self.headView endEditing:YES];
}

- (BOOL)becomeFirstResponder{
    return YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.headView endEditing:YES];
}

- (void)closeEdit {
    [self.view endEditing:YES];
}
-(void)dealloc{
    
}

@end

