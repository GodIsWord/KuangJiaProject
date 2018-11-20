//
//  KJResetPwdViewController.m
//  KuangJia
//
//  Created by xb on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJResetPwdViewController.h"
#import "KJResetPwdView.h"
#import "KJCountryTableViewController.h"
#import "KJLoginManage.h"
@interface KJResetPwdViewController ()<KJResetPwdViewDelegate>

@property (strong, nonatomic) KJResetPwdView *headView;
@end

@implementation KJResetPwdViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubbView];
}

- (void)initSubbView{
    
    self.headView = [[KJResetPwdView alloc] init];
    [self.view addSubview:self.headView];
    self.title = @"修改登录密码";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeEdit)];
    [self.headView addGestureRecognizer:tap];
    self.headView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.headView endEditing:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

-(void)dissmiss{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)next{
    
    if(self.headView.nowPwdTextField.text == self.headView.makesurePwdTextField.text){
        
        
        [KJLoginManage resetWithOldpwd:self.headView.oldPwdTextField.text newpwd:self.headView.nowPwdTextField.text success:^(NSDictionary *result) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录成功"
                                                                                     message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                   [self.navigationController popViewControllerAnimated:YES];
                                                                   
                                                                   
                                                               }];
            
            
            
            [alertController addAction:okAction];
            
            [self.navigationController presentViewController:alertController animated:YES completion:nil];
            
            
        } fail:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                            message:@"修改密码失败"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"请确认修改密码"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)dealloc{
    
}
@end
