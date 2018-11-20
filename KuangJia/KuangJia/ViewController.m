//
//  ViewController.m
//  KuangJia
//
//  Created by yidezhang on 2018/10/23.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "ViewController.h"
#import "JSBridgeViewController.h"
#import "KJLoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"webViewControlerDemo"]) {
        JSBridgeViewController *viewControlelr = segue.destinationViewController;
        viewControlelr.filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    } else if ([segue.identifier containsString:@"baidu"]) {
        JSBridgeViewController *viewControlelr = segue.destinationViewController;
        viewControlelr.url = @"https://www.baidu.com";
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
