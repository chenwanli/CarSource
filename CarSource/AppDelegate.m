//
//  AppDelegate.m
//  CarSource
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyBoardManager.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import <RongIMKit/RongIMKit.h>
//#import "RCDLoginViewController.h"
//#import "RCDRCIMDataSource.h"
//#import "RCDLoginInfo.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIImageView+WebCache.h"
//#import "MBProgressHUD.h"
//#import "UIColor+RCColor.h"
//#import "RCWKRequestHandler.h"
//#import "RCWKNotifier.h"
//#import "RCDCommonDefine.h"
//#import "RCDHttpTool.h"
//#import "AFHttpTool.h"
//#import "RCDataBaseManager.h"
//#import "RCDTestMessage.h"
//#import "MobClick.h"

#define RONGCLOUD_IM_APPKEY @"z3v5yqkbv8v30" // online key

#define UMENG_APPKEY @"563755cbe0f55a5cb300139c"

#define iPhone6                                                                \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                              \
[[UIScreen mainScreen] currentMode].size)           \
: NO)
#define iPhone6Plus                                                            \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)

@interface AppDelegate ()
//<RCWKAppInfoProvider>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];

    [[RCIM sharedRCIM] initWithAppKey:@"YourTestAppKey"];

//    ViewController *image = [[ViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:image];
//    self.window.rootViewController = nav;


    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    self.window.rootViewController = nav;

    [IQKeyBoardManager installKeyboardManager];
    [self.window makeKeyAndVisible];

    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.window endEditing:YES];
//     猪之歌
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
