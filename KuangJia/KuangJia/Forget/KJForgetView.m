//
//  KJForgetView.m
//  KuangJia
//
//  Created by 黄艳红 on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJForgetView.h"
#import "XBMacroDefinition.h"
#import "Masonry.h"
#import "KJCountryTableViewController.h"

@interface KJForgetView () <UITextFieldDelegate>

@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UILabel *greetings;
@property (strong, nonatomic) UIView *subView;

@end
@implementation KJForgetView

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
        
    }
    return self;
}
- (void)createSubViews {
    
    CGFloat edgesLeft = 30.0;
    CGFloat edgesRight = -30.0;
    
    
    self.subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.subView.backgroundColor =  [UIColor whiteColor];
    [self addSubview:self.subView];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"close"] forState:(UIControlState)UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.subView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(20);        make.width.mas_equalTo(44);
        make.top.mas_equalTo(STATUSBAR_HEIGHT);
        make.height.mas_equalTo(44);
        
    }];
    
    self.greetings = [[UILabel alloc] init];
    self.greetings.font = [UIFont systemFontOfSize:24];
    self.greetings.textColor = [UIColor blackColor];
    self.greetings.text = @"请输入手机号";
    [self.subView addSubview:self.greetings];
    [self.greetings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.top.mas_equalTo(STATUSBAR_And_NAVIGATIONBAR_HEIGHT + 30);
    }];
    
    UILabel *countryLabel = [[UILabel alloc]init];
    countryLabel.text = @"+86";
    countryLabel.textColor = [UIColor blackColor];
    [self.subView addSubview:countryLabel];
    [countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft+5);
        make.top.equalTo(self.greetings.mas_bottom).offset(60);
        make.height.mas_equalTo(49);
        
    }];
    
    
    UIButton *countryBtn = [[UIButton alloc]init];
    [countryBtn setBackgroundImage:[UIImage imageNamed:@"country"] forState:UIControlStateNormal];
    [countryBtn addTarget:self action:@selector(countryBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.subView addSubview:countryBtn];
    [countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countryLabel.mas_right).offset(1);
        make.width.mas_equalTo(30);
        make.centerY.equalTo(countryLabel.mas_centerY).offset(2);
        make.height.mas_equalTo(30);
        
    }];
    
    
    self.mobileTextField = [[UITextField alloc] init];
    self.mobileTextField.delegate = self;
    self.mobileTextField.placeholder = @"请输入手机号码";
    self.mobileTextField.inputAccessoryView = [[UIView alloc] init];
    [self.subView addSubview:self.mobileTextField];
    [self.mobileTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countryBtn.mas_right).offset(3);
        make.right.lessThanOrEqualTo(self.subView).offset((edgesRight-5));
        make.centerY.equalTo(countryBtn);
        make.height.mas_equalTo(44);
        
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    
    [self.subView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.right.equalTo(self.subView).offset(edgesRight);
        make.top.equalTo(self.mobileTextField.mas_bottom);
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
        make.top.equalTo(self.mobileTextField.mas_bottom).offset(40);
        make.right.equalTo(self.subView).offset(-30);
        make.left.equalTo(self.subView).offset(30);
        make.height.mas_equalTo(44);
        
    }];
    
}
-(void)countryBtnDidClicked{
    
    KJCountryTableViewController *country = [[KJCountryTableViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:country];
    
    [self.na presentViewController:na animated:YES completion:nil];
}
-(void)nextButtonDidClicked{
    NSLog(@"下一步");
    // 跳验证码
    //    KJCountryTableViewController *country = [[KJCountryTableViewController alloc]init];
    
    //    [self.na pushViewController:country animated:YES];
    
}

-(void)backBtnDidClicked{
    [self.na dismissViewControllerAnimated:YES completion:nil];
}
@end
