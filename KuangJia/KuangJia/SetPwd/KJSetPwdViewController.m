//
//  KJSetPwdViewController.m
//  KuangJia
//
//  Created by 黄艳红 on 2018/11/17.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJSetPwdViewController.h"
#import "XBMacroDefinition.h"
#import "Masonry.h"
#import "KJTextField.h"
#import "HttpRequestServices.h"

@interface KJSetPwdViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UILabel *greetings;
@property (strong, nonatomic) UIView *subView;
@property (strong, nonatomic) KJTextField *pwdTextField;

@end

@implementation KJSetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat edgesLeft = 30.0;
    CGFloat edgesRight = -30.0;
    
    
    self.subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.subView.backgroundColor =  [UIColor whiteColor];
    [self.view addSubview:self.subView];
    
    
    self.greetings = [[UILabel alloc] init];
    self.greetings.font = [UIFont systemFontOfSize:24];
    self.greetings.textColor = [UIColor blackColor];
    self.greetings.text = @"请设置密码";
    [self.subView addSubview:self.greetings];
    [self.greetings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.top.mas_equalTo(STATUSBAR_And_NAVIGATIONBAR_HEIGHT + 30);
    }];
    
    UILabel *pwd = [[UILabel alloc] init];
    pwd.font = [UIFont systemFontOfSize:13];
    pwd.textColor = [UIColor blackColor];
    pwd.text = @"密码";
    
    [self.subView addSubview:pwd];
    [pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.top.equalTo(self.greetings.mas_bottom).offset(60);
    }];
    
    
    self.pwdTextField = [[KJTextField alloc] init];
    self.pwdTextField.delegate = self;
    self.pwdTextField.placeholder = @"请输入密码";
    self.pwdTextField.inputAccessoryView = [[UIView alloc] init];
    [self.subView addSubview:self.pwdTextField];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.right.equalTo(self.subView).offset((edgesRight-5));
        make.top.equalTo(pwd.mas_bottom);
        make.height.mas_equalTo(49);
        
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    
    [self.subView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.right.equalTo(self.subView).offset(edgesRight);
        make.top.equalTo(self.pwdTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
        
    }];
    
    
    self.nextButton = [[UIButton alloc]init];
    self.nextButton.titleLabel.font = UIFontBoldMake(17);
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextButton.backgroundColor = [UIColor blueColor];
    [self.nextButton addTarget:self action:@selector(nextButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.layer.cornerRadius = 6;
    [self.subView addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(40);
        make.right.equalTo(self.subView).offset(-30);
        make.left.equalTo(self.subView).offset(30);
        make.height.mas_equalTo(44);
        
    }];
}

- (void)nextButtonDidClicked{
    
    NSDictionary *params = @{@"cmd":@"org.user.create",
                             @"departmentId":@"43127819-0cbb-472b-a095-0d4c253d3722",
                             @"uid":self.userName,
                             @"userName":self.userName,
                             @"roleId":@"b5e2b9fb-bb86-4bb1-a549-5e75a575ebf3",
                             @"password":self.pwdTextField.text};
    [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
        // 注册成功
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"注册成功"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    } faile:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"注册失败"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }];
}
@end
