//
//  AppDelegate.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/14.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "AppDelegate.h"

#import "ZYCTabBarController.h"
#import "ZYCPushGuideView.h"
#import "ZYCTopWindow.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //设置窗口的根控制器
    
    self.window.rootViewController = [[ZYCTabBarController alloc]init];
    
    //显示窗口
    [self.window makeKeyAndVisible];
    

    //显示推送引导
    [ZYCPushGuideView show];
    
    //添加一个window，点击这个window可以让屏幕上的scrollview滚到最顶部
    [ZYCTopWindow show];
    
    
    //处理window没有根控制器的报错
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows) {
        if (window.rootViewController == nil) {
            UIViewController *vc = [[UIViewController alloc]initWithNibName:nil bundle:nil];
            window.rootViewController = vc;
        }
    }
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
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
