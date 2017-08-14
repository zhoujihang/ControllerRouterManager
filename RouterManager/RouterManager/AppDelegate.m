//
//  AppDelegate.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "AppDelegate.h"
#import "FDTabBarController.h"
#import "FKTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *win = [[UIWindow alloc] init];
    win.rootViewController = [[FDTabBarController alloc] init];
    [win makeKeyAndVisible];
    [[UIApplication sharedApplication] delegate].window = win;
    
    return YES;
}


@end
