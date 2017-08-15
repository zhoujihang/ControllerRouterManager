//
//  AppDelegate.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "AppDelegate.h"
#import "XZTabBarManager.h"
#import "XZRouterRegisterTool.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setup];
    
    return YES;
}

- (void)setup {
    [XZRouterRegisterTool setup];
    
    UIWindow *win = [[UIWindow alloc] init];
    [win makeKeyAndVisible];
    [[UIApplication sharedApplication] delegate].window = win;
    [[XZTabBarManager shared] switchToFD];
}


@end
