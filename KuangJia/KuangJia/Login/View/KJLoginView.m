//
//  JFLoginView.m
//
//  Created by xiaoBai on 18/10/26.
//  Copyright © 2018年 KuangJia. All rights reserved.
//

#import "KJLoginView.h"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#import "XBMacroDefinition.h"
#import "Masonry.h"
#import "KJForgetViewController.h"
#import "KJRegisterViewController.h"
#import "KJCountryTableViewController.h"

@interface KJLoginView () <UITextFieldDelegate,KJCountryTableViewControllerDelegate>

@property(strong, nonatomic) UIImageView *iconImageView;
@property(strong, nonatomic) UIButton *registerButton;
@property(strong, nonatomic) UIView *navigationBarView;

@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *forgetButton;
@property (strong, nonatomic) UIView *line1;
@property (strong, nonatomic) UIView *line2;
@property (strong, nonatomic) UILabel *greetings;
@property (strong, nonatomic) UIView *subView;

@property (strong, nonatomic) UILabel *countryLabel;
@end

@implementation KJLoginView

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.subView.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"back"];
        self.layer.contents = (id) image.CGImage;
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.35];
        [self addSubview:self.subView];
        
        [self createSubViews];
        [self addNotification];
    }
    return self;
}

- (void)createSubViews {
    
    CGFloat edgesLeft = 30.0;
    CGFloat edgesRight = -30.0;
    self.navigationBarView = [[UIView alloc]init];
    self.navigationBarView.backgroundColor  = [UIColor clearColor];
    [self.subView addSubview:self.navigationBarView];
    [self.navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.subView);
        make.top.equalTo(self.subView).offset(STATUSBAR_HEIGHT+25);
        make.height.mas_equalTo(44);
    }];
    
    
    self.iconImageView = [UIImageView new];
    self.iconImageView.layer.cornerRadius = 20;
    self.iconImageView.layer.masksToBounds = YES;
    [self.iconImageView setImage:[UIImage imageNamed:@"back"]];
    [self.navigationBarView addSubview:self.iconImageView];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.navigationBarView);
    }];
    
    
    self.registerButton = [[UIButton alloc]init];
    [self.registerButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [self.navigationBarView addSubview:self.registerButton];
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.registerButton addTarget:self action:@selector(registButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationBarView.mas_right).offset(-30);
        make.centerY.equalTo(self.navigationBarView);
    }];
    
    
    self.greetings = [[UILabel alloc] init];
    self.greetings.font = [UIFont systemFontOfSize:26];
    self.greetings.textColor = [UIColor whiteColor];
    self.greetings.text = @"Hello!黄小白\n欢迎登录";
    self.greetings.numberOfLines = 2;
    [self.subView addSubview:self.greetings];
    [self.greetings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.top.mas_equalTo(STATUSBAR_And_NAVIGATIONBAR_HEIGHT + 30);
        make.width.mas_equalTo(200);
    }];
    
    UILabel *mobile = [[UILabel alloc] init];
    mobile.font = [UIFont systemFontOfSize:13];
    mobile.textColor = [UIColor whiteColor];
    mobile.text = @"手机号码";
    
    [self.subView addSubview:mobile];
    [mobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.top.equalTo(self.greetings.mas_bottom).offset(60);
    }];
    
    
    UILabel *countryLabel = [[UILabel alloc]init];
    countryLabel.text = @"+86";
    countryLabel.textColor = [UIColor whiteColor];
    [self.subView addSubview:countryLabel];
    self.countryLabel = countryLabel;
    [countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.top.equalTo(mobile.mas_bottom);
        make.height.mas_equalTo(49);
        
    }];
    
    
    UIButton *countryBtn = [[UIButton alloc]init];
    [countryBtn addTarget:self action:@selector(countryBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [countryBtn setImage:[UIImage imageNamed:@"country"] forState:UIControlStateNormal];
    [self.subView addSubview:countryBtn];
    [countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countryLabel.mas_right).offset(3);
        make.width.mas_equalTo(20);
        make.centerY.equalTo(countryLabel);
        make.height.mas_equalTo(18);
        
    }];
    
    UIView *Vline = [[UIView alloc] init];
    Vline.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    
    [self.subView addSubview:Vline];
    [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countryBtn.mas_right).offset(5);
        make.centerY.equalTo(countryLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(0.5);
        
    }];
    
    self.mobileTextField = [self creatTextField:@" 请输入手机号码"];
    self.mobileTextField.delegate = self;
    self.mobileTextField.textColor = [UIColor whiteColor];
    self.mobileTextField.tintColor = [UIColor whiteColor];
    [self.subView addSubview:self.mobileTextField];
    [self.mobileTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView.mas_left).offset(110);
        make.right.equalTo(self.subView).offset((edgesRight-5));
        make.top.equalTo(mobile.mas_bottom);
        make.height.mas_equalTo(49);
        
    }];
    
    
    self.line1 = [[UIView alloc] init];
    self.line1.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    
    [self.subView addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.right.equalTo(self.subView).offset(edgesRight);
        make.top.equalTo(self.mobileTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
        
    }];
    
    
    
    UILabel *password = [[UILabel alloc] init];
    password.font = [UIFont systemFontOfSize:13];
    password.textColor = [UIColor whiteColor];
    password.text = @"密码";
    [self.subView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.top.equalTo(self.line1.mas_bottom).offset(12);
    }];
    
    self.passwordTextField = [self creatTextField:@"请输入密码"];
    self.passwordTextField.delegate = self;
    self.passwordTextField.textColor = [UIColor whiteColor];
    self.passwordTextField.tintColor = [UIColor whiteColor];
    [self.subView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft+5);
        make.right.equalTo(self.subView).offset((edgesRight-5));
        make.top.equalTo(password.mas_bottom);
        make.height.mas_equalTo(49);
        
    }];
    
    self.line2 = [[UIView alloc] init];
    self.line2.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    
    [self.subView addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.right.equalTo(self.subView).offset(edgesRight);
        make.top.equalTo(self.passwordTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
        
    }];
    
    
    self.loginButton = [[UIButton alloc]init];
    self.loginButton.titleLabel.font = UIFontBoldMake(17);
    [self.loginButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.55] forState:UIControlStateNormal];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    [self.loginButton addTarget:self action:@selector(loginButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 6;
    [self.subView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(40);
        make.right.equalTo(self.subView).offset(-30);
        make.left.equalTo(self.subView).offset(30);
        make.height.mas_equalTo(44);
        
    }];
    
    
    self.forgetButton = [[UIButton alloc]init];
    self.forgetButton.titleLabel.font = UIFontBoldMake(14);
    [self.forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetButton addTarget:self action:@selector(forgetButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.subView addSubview:self.forgetButton];
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.loginButton.mas_bottom).offset(10);
        make.left.equalTo(self.loginButton.mas_left);
        
    }];
    
    
    UIButton *moreBtn = [[UIButton alloc]init];
    moreBtn.titleLabel.font = UIFontBoldMake(14);
    [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.subView addSubview:moreBtn];
    [moreBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.subView.mas_bottom).offset(-20-BOTTOM_MARGIN);
        make.left.equalTo(self.subView).offset(20);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        
    }];
    
    
}

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(onKeyboardWillShow:)
                   name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self
               selector:@selector(onKeyboardWillHide:)
                   name:UIKeyboardWillHideNotification object:nil];
}

- (void)onKeyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    CGRect keyboardRect   = [userInfoDic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight   = MIN(CGRectGetWidth(keyboardRect), CGRectGetHeight(keyboardRect));
    // 这个地方判断 屏幕的高度 当手机屏幕尺寸高度为1334px以及以下设备时输入焦点在第二个输入框时， 页面上移，保证第二个输入框不会被挡
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        if([UIScreen mainScreen].bounds.size.height<667){
            
            self.subView.transform = CGAffineTransformMakeTranslation(0, -120);
            
        }else{
            
        }
    } completion:nil];
}

- (void)onKeyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    
    UIViewAnimationOptions options =  [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.subView.transform = CGAffineTransformIdentity;
        
    } completion:nil];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.line1.backgroundColor = [UIColor colorWithRed:129 / 255.f green:132 / 255.f blue:159 / 255.f alpha:1];
    self.line2.backgroundColor = [UIColor colorWithRed:129 / 255.f green:132 / 255.f blue:159 / 255.f alpha:1];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.mobileTextField) {
        
        self.line1.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
        self.line2.backgroundColor = [UIColor colorWithRed:129 / 255.f green:132 / 255.f blue:159 / 255.f alpha:1];
    } else {
        self.line1.backgroundColor = [UIColor colorWithRed:129 / 255.f green:132 / 255.f blue:159 / 255.f alpha:1];
        self.line2.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    }
    
}

#pragma mark - UITextFieldDelegate

// 限制输入框输入几位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location >= 20) {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
    
}

#pragma mark - Methods

- (KJTextField *)creatTextField:(NSString *)title {
    
    KJTextField *textField = [[KJTextField alloc] init];
    textField.placeholder = title;
    textField.inputAccessoryView = [[UIView alloc] init];
    return textField;
}

-(void)loginButtonDidClicked{
    NSLog(@"登陆");
}
-(void)forgetButtonDidClicked{
    KJForgetViewController *forget = [[KJForgetViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:forget];
    [self.viewController presentViewController:na animated:YES completion:nil];
    
}
-(void)registButtonDidClicked{
    
    KJRegisterViewController *regist = [[KJRegisterViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:regist];
    [self.viewController presentViewController:na animated:YES completion:nil];
    
}
-(void)countryBtnDidClicked{
    
    KJCountryTableViewController *country = [[KJCountryTableViewController alloc]init];
#warning 小白想想这里，view层处理了业务逻辑。。 这种设计模式对不对？
    country.delegate = self;

    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:country];
    [self.viewController presentViewController:na animated:YES completion:nil];
}


-(void)moreButtonDidClicked{
    //创建AlertController对象 preferredStyle可以设置是AlertView样式或者ActionSheet样式
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"其他账号登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"账号挂失" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    }];
    //添加按钮
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    //显示
    [self.na presentViewController:alertC animated:YES completion:nil];
    
}

- (UIViewController *)viewController {
    id responder = self.nextResponder;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
    }
    return (UIViewController *)responder;
}

#pragma mark -- KJCountryTableViewControllerDelegate
-(void)searchCountry:(NSString *)country{
    self.countryLabel.text = country;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
