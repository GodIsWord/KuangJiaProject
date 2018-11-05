//
//  KJRegisterViewController.m
//  KuangJia
//
//  Created by xb on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJRegisterViewController.h"
#import "KJRegisterView.h"
#import "KJCountryTableViewController.h"
@interface KJRegisterViewController ()<KJRegisterViewDelegate>

@property (strong, nonatomic) KJRegisterView *headView;
@end

@implementation KJRegisterViewController

@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubbView];
}

- (void)initSubbView{
    
    self.headView = [[KJRegisterView alloc] init];
    [self.view addSubview:self.headView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeEdit)];
    [self.headView addGestureRecognizer:tap];
    self.headView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.headView.mobileTextField becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.headView endEditing:YES];
}

- (BOOL)becomeFirstResponder{
    return YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.headView endEditing:YES];
}

- (void)closeEdit {
    [self.view endEditing:YES];
}

-(void)country{
    
    KJCountryTableViewController *country = [[KJCountryTableViewController alloc]init];
    country.delegate = self.headView;
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:country];
    [self.navigationController presentViewController:na animated:YES completion:nil];
    
}

-(void)next{
    NSLog(@"next");
}
@end
