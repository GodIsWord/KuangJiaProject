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
#import "KJRegisterViewController.h"
#import "KJLoginManage.h"
#import "KJLoginModel.h"

@interface KJLoginViewController () <UIViewControllerTransitioningDelegate,UITableViewDelegate,KJLoginViewDelegate>{
    
}

@property (strong, nonatomic) KJLoginView *headView;

@end

@implementation KJLoginViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubbView];
    //    [NSTimer scheduledTimerWithTimeInterval:60*5.0 target:self selector:@selector(checkWithUser) userInfo:nil repeats:YES];
    //    [[NSRunLoop currentRunLoop] run];
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
    [KJLoginManage loginWithUserName:self.headView.mobileTextField.text?:@"" password:self.headView.passwordTextField.text?:@"" success:^(NSDictionary *result) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录成功"
                                                                                 message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                               if (self.navigationController) {
                                                                   [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                                   
                                                               }else{
                                                                   [self dismissViewControllerAnimated:YES completion:nil];
                                                               }
                                                               
                                                           }];
        
        
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } fail:^(NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}
-(void)regist{
    KJRegisterViewController *regist = [[KJRegisterViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:regist];
    [self.navigationController presentViewController:na animated:YES completion:nil];
}
//-(void)forget{
//    KJForgetViewController *forget = [[KJForgetViewController alloc]init];
//    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:forget];
//    [self.navigationController presentViewController:na animated:YES completion:nil];
//}
-(void)country{
    KJCountryTableViewController *country = [[KJCountryTableViewController alloc]init];
    country.delegate = self.headView;
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:country];
    [self.navigationController presentViewController:na animated:YES completion:nil];
}
//
//-(void)more{
//    //创建AlertController对象 preferredStyle可以设置是AlertView样式或者ActionSheet样式
//    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"其他账号登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        [KJLoginManage exitsuccess:^(NSDictionary *result) {
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
//                                                            message:@"注销成功"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//        } fail:^(NSError *error) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
//                                                            message:@"注销失败"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//
//        }];
//
//    }];
//    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    }];
//    //添加按钮
//    [alertC addAction:action1];
//    [alertC addAction:action2];
//    [alertC addAction:action3];
//    //显示
//    [self.navigationController presentViewController:alertC animated:YES completion:nil];
//}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent; //白色
    
}
@end

