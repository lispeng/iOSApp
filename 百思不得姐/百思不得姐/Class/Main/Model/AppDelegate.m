//
//  AppDelegate.m
//  百思不得姐
//
//  Created by mac on 16-2-4.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "AppDelegate.h"
#import "LSPTabBarViewController.h"
#import "LSPPushGuideView.h"
#import "LSPTopWindow.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建控制器
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //设置根控制器
    LSPTabBarViewController *vc = [[LSPTabBarViewController
                                    alloc] init];
    //self.window.rootViewController = vc;
    [self.window setRootViewController:vc];
    vc.delegate = self;
    //设置控制器可见属性
    [self.window makeKeyAndVisible];
    
    //加载引导页面
    //[LSPPushGuideView showGuidePage];
    
  
    
    return YES;
}
#pragma mark--UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //发出通知
    [LSPNotiCenter postNotificationName:LSPTabBarDidSelectNotification object:nil userInfo:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //添加一个UIWindow对象，点击这个对象可以让scrollView回滚到顶部
    //[LSPTopWindow show];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
