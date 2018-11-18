//
//  HomeSecriteViewController.m
//  KuangJia
//
//  Created by yide zhang on 2018/11/4.
//  Copyright © 2018年 yidezhang. All rights reserved.
//

#import "HomeSecriteViewController.h"

#import "YDSecritManger.h"
#import "YDCamoraViewController.h"
#import "YDPhotoAlbumNaviViewController.h"
#import "YDScanerNaviViewController.h"

#import "HttpRequestServices.h"

#import <CommonCrypto/CommonDigest.h>

@interface HomeSecriteViewController ()<UITableViewDelegate,UITableViewDataSource,YDPhotoAlbumViewControllerDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *dataSource;
@end

@implementation HomeSecriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"个人信息";
    self.dataSource = @[@"通讯录",@"短信发送",@"拨打电话",@"调用相机",@"打开相册",@"二维码 条形码扫描",@"登陆测试",@"check会话信息",@"close会话",@"注册"];
    [self createTableView];
}

-(void)createTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ddd"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [YDSecritManger selectPhoneNumViewController:self isCanSelect:NO complection:^(NSString *name, NSString *phone) {
                NSLog(@"name:%@,phone:%@",name,phone);
            }];
        }
            break;
        case 1:
        {
            //发送短信
            [YDSecritManger sendMessageWithNum:@[@"100086"] message:@"test" viewController:self complation:^(YDSecritMangerMessageResult result) {

            }];

        }
            break;
        case 2:
        {
            //拨打电话
            [YDSecritManger callPhoneWithNum:@"10010"];
        }
            break;
        case 3:
        {
            //打开相机
            YDCamoraViewController *camora = [[YDCamoraViewController alloc] init];
            [self presentViewController:camora animated:YES completion:nil];
        }
            break;
        case 4:
        {
            //打开相册
            YDPhotoAlbumNaviViewController *controller = [[YDPhotoAlbumNaviViewController alloc] init];
//            [self.navigationController pushViewController:controller animated:YES];
            controller.finishDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case 5:
        {
            //二维码扫描 条形码也可以
            YDScanerNaviViewController *navi = [[YDScanerNaviViewController alloc] init];
            [self presentViewController:navi animated:YES completion:nil];
        }
            break;
        case 6:
        {
            //登陆测试
            NSDictionary *params = @{@"cmd":@"portal.session.create",
                                     @"uid":@"admin123",
                                     @"pwd":@"123"};
            [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
                
                NSDictionary *responseObject = respons;
                if ([responseObject.allKeys containsObject:@"data"]) {
                    if ([responseObject[@"data"] isKindOfClass:NSString.class]) {
                        NSString *str = [responseObject objectForKey:@"data"];
                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                        if ([dict.allKeys containsObject:@"data"]) {
                            if ([dict[@"data"] isKindOfClass:NSDictionary.class]) {
                                if ([[dict[@"data"] allKeys] containsObject:@"sid"] && [dict[@"result"]  isEqualToString:@"ok"]) {
                                    [HttpRequestServices sharedInstance].userSid = [dict[@"data"] objectForKey:@"sid"];
                                }else{
                                    NSLog(@"erroe:%@",[dict objectForKey:@"msg"]);
                                }
                            }
                        }
                    }
                }
                
            } faile:^(NSError *error) {
                
            }];
        }
            break;
        case 7:
        {
            //check测试
            NSDictionary *params = @{@"cmd":@"portal.session.check",
                                     @"sid":@"dee"};
            [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
                
            } faile:^(NSError *error) {
                
            }];
        }
            break;
        case 8:
        {
            //注销
            NSDictionary *params = @{@"cmd":@"portal.session.close",
                                     @"sid":[HttpRequestServices sharedInstance].userSid};
            [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
                
            } faile:^(NSError *error) {
                
            }];
            
        }
            break;
        case 9:
        {
            //注册
            NSDictionary *params = @{@"cmd":@"org.user.create",
                                     @"departmentId":@"43127819-0cbb-472b-a095-0d4c253d3722",
                                     @"uid":@"1889287",
                                     @"userName":@"恍惚呃呃",
                                     @"roleId":@"b5e2b9fb-bb86-4bb1-a549-5e75a575ebf3",
                                     @"password":@"test1"};
            [HttpRequestServices requestAppending:nil httpMethod:SZRequestMethodTypeGet withParameters:params success:^(NSDictionary *respons) {
                
            } faile:^(NSError *error) {
                
            }];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - MD5加密 16位 大写
+ (NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
#pragma mark - MD5加密 32位 大写
+ (NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

-(void)YDPhotoAlbumViewControllerSelectFinishResult:(NSArray *)resultes
{
    NSLog(@"select photo finish");
    
}

@end
