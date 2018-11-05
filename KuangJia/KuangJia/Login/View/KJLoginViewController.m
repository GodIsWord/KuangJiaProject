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
#import "KJCountryTableViewController.h"
#import "KJForgetViewController.h"
#import "KJRegisterViewController.h"
@interface KJLoginViewController () <UIViewControllerTransitioningDelegate,UITableViewDelegate,KJLoginViewDelegate>{
    
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
    self.headView.delegate = self;
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //掉透明导航栏边黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
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

-(void)login{
    NSLog(@"登录");
}
-(void)regist{
    KJRegisterViewController *regist = [[KJRegisterViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:regist];
    [self.navigationController presentViewController:na animated:YES completion:nil];
}
-(void)forget{
    KJForgetViewController *forget = [[KJForgetViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:forget];
    [self.navigationController presentViewController:na animated:YES completion:nil];
}
-(void)country{
    KJCountryTableViewController *country = [[KJCountryTableViewController alloc]init];
    country.delegate = self.headView;
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:country];
    [self.navigationController presentViewController:na animated:YES completion:nil];
}

-(void)more{
    //创建AlertController对象 preferredStyle可以设置是AlertView样式或者ActionSheet样式
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"其他账号登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"账号挂失" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    //添加按钮
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    //显示
    [self.navigationController presentViewController:alertC animated:YES completion:nil];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent; //白色
    
}
@end

