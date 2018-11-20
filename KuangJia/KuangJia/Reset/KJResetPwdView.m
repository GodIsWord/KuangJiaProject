//
//  KJResetPwdView.m
//  KuangJia
//
//  Created by 黄艳红 on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJResetPwdView.h"
#import "XBMacroDefinition.h"
#import "Masonry.h"

@interface KJResetPwdView () <UITextFieldDelegate>

@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UIView *subView;


@end
@implementation KJResetPwdView

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
        make.left.equalTo(self.subView).offset(10);     make.width.mas_equalTo(44);
        make.top.mas_equalTo(STATUSBAR_HEIGHT);
        make.height.mas_equalTo(44);
        
    }];

    
    self.oldPwdTextField = [[KJTextField alloc] init];
    self.oldPwdTextField.delegate = self;
    self.oldPwdTextField.placeholder = @"请输入原密码";
    self.oldPwdTextField.inputAccessoryView = [[UIView alloc] init];
    [self.subView addSubview:self.oldPwdTextField];
    [self.oldPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView.mas_left).offset(20);
        make.right.equalTo(self.subView).offset((edgesRight-5));
        make.top.mas_equalTo(STATUSBAR_And_NAVIGATIONBAR_HEIGHT + 30);
        make.height.mas_equalTo(49);
        
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    
    [self.subView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.right.equalTo(self.subView).offset(edgesRight);
        make.top.equalTo(self.oldPwdTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
        
    }];
    
    
    
    self.nowPwdTextField = [[KJTextField alloc] init];
    self.nowPwdTextField.delegate = self;
    self.nowPwdTextField.placeholder = @"请输入新密码";
    self.nowPwdTextField.inputAccessoryView = [[UIView alloc] init];
    [self.subView addSubview:self.nowPwdTextField];
    [self.nowPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView.mas_left).offset(20);
        make.right.equalTo(self.subView).offset((edgesRight-5));
        make.top.equalTo(line1.mas_bottom).offset(10);
        make.height.mas_equalTo(49);
        
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    
    [self.subView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.right.equalTo(self.subView).offset(edgesRight);
        make.top.equalTo(self.nowPwdTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
        
    }];
    
    
    
    self.makesurePwdTextField = [[KJTextField alloc] init];
    self.makesurePwdTextField.delegate = self;
    self.makesurePwdTextField.placeholder = @"请确认新密码";
    self.makesurePwdTextField.inputAccessoryView = [[UIView alloc] init];
    [self.subView addSubview:self.makesurePwdTextField];
    [self.makesurePwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView.mas_left).offset(20);
        make.right.equalTo(self.subView).offset((edgesRight-5));
        make.top.equalTo(line2.mas_bottom).offset(10);
        make.height.mas_equalTo(49);
        
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:216 / 255.f green:217 / 255.f blue:226 / 255.f alpha:1];
    
    [self.subView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subView).offset(edgesLeft);
        make.right.equalTo(self.subView).offset(edgesRight);
        make.top.equalTo(self.makesurePwdTextField.mas_bottom);
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
        make.top.equalTo(line3.mas_bottom).offset(40);
        make.right.equalTo(self.subView).offset(-30);
        make.left.equalTo(self.subView).offset(30);
        make.height.mas_equalTo(44);
        
    }];
    
}
-(void)backBtnDidClicked{

    if ([self.delegate respondsToSelector:@selector(dissmiss)]) {
        [self.delegate dissmiss];
        
    }
}

-(void)nextButtonDidClicked{
    if ([self.delegate respondsToSelector:@selector(next)]) {
        [self.delegate next];
        
    }
    
}

@end
