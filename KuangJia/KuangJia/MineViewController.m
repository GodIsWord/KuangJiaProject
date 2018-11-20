//
//  MineViewController.m
//  KuangJia
//
//  Created by yidezhang on 2018/11/20.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "MineViewController.h"

#import "HomeSecriteViewController.h"

#import "KJLoginManage.h"

#import "KJResetPwdViewController.h"
#import "KJUserInfoContext.h"

#import "KJLoginViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *dataSource;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    
    
    [self createTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadView];
}
-(void) reloadView{
    KJLoginModel *userModel = [KJUserInfoContext sharedUserInfoContext].userInfo;
    if (!userModel.isLogIn) {
        self.dataSource = @[@"功能演示",@"登陆"];
    }else{
        self.dataSource = @[@"功能演示",@"修改密码"];
    }
    [self.tableView reloadData];
}
-(void)createTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    KJLoginModel *userModel = [KJUserInfoContext sharedUserInfoContext].userInfo;
    if (userModel.isLogIn) {
        return 60;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    KJLoginModel *userModel = [KJUserInfoContext sharedUserInfoContext].userInfo;
    if (userModel.isLogIn) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.userInteractionEnabled = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 40, backView.bounds.size.width, 20);
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        
        return backView;
    }
    return nil;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ddd"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 43.5, self.view.bounds.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:line];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            HomeSecriteViewController *secrit = [[HomeSecriteViewController alloc] init];
            [self.navigationController pushViewController:secrit animated:YES];
        }
            break;
        case 1:
        {
            KJLoginModel *userModel = [KJUserInfoContext sharedUserInfoContext].userInfo;
            if (userModel.isLogIn) {
                KJResetPwdViewController *reset = [[KJResetPwdViewController alloc] init];
                [self.navigationController pushViewController:reset animated:YES];
            }else{
                KJLoginViewController *logIN = [[KJLoginViewController alloc] init];
                [self.navigationController presentViewController:logIN animated:YES completion:nil];
            }
            
        }
            break;
            
        default:
            break;
    }
}
-(void)logOut{
    [KJLoginManage exitsuccess:^(NSDictionary *result) {
        if ([result[@"result"] isEqualToString:@"ok"]) {
            
        }else{
            
        }
    } fail:^(NSError *error) {
        
    }];
    
    [KJUserInfoContext sharedUserInfoContext].userInfo.sid = nil;
    [self reloadView];
}
@end
