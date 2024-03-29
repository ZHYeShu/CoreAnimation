//
//  AppDelegate.m
//  CoreAnimation
//
//  Created by ZHYeShu on 2018/5/8.
//  Copyright © 2018年 ZHYeShu. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>
@property(nonatomic,strong)UITabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
//    UIViewController *viewController1 = [[FirstViewController alloc] init];
//    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"cap_1"] tag:1];
//    viewController1.tabBarItem = item1;
//    UIViewController *viewController2 = [[SecondViewController alloc] init];
//    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"cap_2"] tag:2];
//    viewController2.tabBarItem = item2;
//    self.tabBarController = [[UITabBarController alloc] init];
//    self.tabBarController.viewControllers = @[viewController1, viewController2];
//    self.tabBarController.delegate = self;
//    self.tabBarController.tabBar.translucent = NO;
//    self.window.rootViewController = self.tabBarController;
//    [self.window makeKeyAndVisible];
    return YES;
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    //apply transition to tab bar controller's view
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
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
