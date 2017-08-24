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

@property (nonatomic, strong, nullable) UIWindow *bottomWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setup];
    
    return YES;
}

- (void)setup {
    [XZRouterRegisterTool setup];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [[XZTabBarManager shared] switchToFD];
}

@end
