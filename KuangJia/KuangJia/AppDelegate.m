//
//  AppDelegate.m
//  KuangJia
//
//  Created by yidezhang on 2018/10/23.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "WrapperViewController.h"
#import "ProfileViewController.h"
#import "JSBridgeViewController.h"

#import "HomeSecriteViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    TabBarController *tabBarController = [[TabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    
    // first
    UINavigationController *first = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    first.tabBarItem.title = @"首页";
    first.tabBarItem.image = [UIImage imageNamed:@"tab_home_normal.png"];
    first.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_home_select.png"];
    first.tabBarItem.imageInsets = UIEdgeInsetsMake(fabs((first.tabBarItem.image.size.height-20)/2), fabs((first.tabBarItem.image.size.height-20)/2), fabs((first.tabBarItem.image.size.height-20)/2), fabs((first.tabBarItem.image.size.height-20)/2));
    
    // second
    JSBridgeViewController *webVc = [[JSBridgeViewController alloc] init];
    webVc.url = @"http://www.wfis.com.cn:8015";
    UINavigationController *second = [[UINavigationController alloc] initWithRootViewController:webVc];
    second.tabBarItem.title = @"网页";
    second.tabBarItem.image = [UIImage imageNamed:@"tab_profit_normal.png"];
    second.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_profit_select.png"];
    second.tabBarItem.imageInsets = UIEdgeInsetsMake(fabs((second.tabBarItem.image.size.height-20)/2), fabs((second.tabBarItem.image.size.height-20)/2), fabs((second.tabBarItem.image.size.height-20)/2), fabs((second.tabBarItem.image.size.height-20)/2));
    
    // third
    WrapperViewController *wrapperVc = [[WrapperViewController alloc] init];
    
    ProfileViewController *profileVc = [[ProfileViewController alloc] init];
    JSBridgeViewController *webViewVc = [[JSBridgeViewController alloc] init];

    webViewVc.filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    wrapperVc.subViewControllers = @[profileVc,webViewVc];
    UINavigationController *third = [[UINavigationController alloc] initWithRootViewController:wrapperVc];
    third.tabBarItem.title = @"页面切换";
    UIImage *thirdImage = [UIImage imageNamed:@"tab_life_normal.png"];
    third.tabBarItem.image = [UIImage imageNamed:@"tab_life_normal.png"];
    third.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_life_select.png"];
    third.tabBarItem.imageInsets = UIEdgeInsetsMake(fabs((thirdImage.size.height-20)/2), fabs((thirdImage.size.height-20)/2), fabs((thirdImage.size.height-20)/2), fabs((thirdImage.size.height-20)/2));
    
    
    HomeSecriteViewController *forth = [[HomeSecriteViewController alloc] init];
    UINavigationController *naviForth = [[UINavigationController alloc] initWithRootViewController:forth];
    forth.tabBarItem.title = @"我的";
    forth.tabBarItem.image = [UIImage imageNamed:@"tab_person_normal.png"];
    forth.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_person_select.png"];
    forth.tabBarItem.imageInsets = UIEdgeInsetsMake(fabs((forth.tabBarItem.image.size.height-20)/2), fabs((forth.tabBarItem.image.size.height-20)/2), fabs((forth.tabBarItem.image.size.height-20)/2), fabs((forth.tabBarItem.image.size.height-20)/2));
    
    
    
    
    tabBarController.viewControllers = @[first,second,third,naviForth];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
