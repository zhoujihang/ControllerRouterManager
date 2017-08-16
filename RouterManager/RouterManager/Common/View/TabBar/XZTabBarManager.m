//
//  XZTabBarManager.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/15.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "XZTabBarManager.h"

@interface XZTabBarManager ()

@property (nonatomic, strong, readwrite, nullable) FDTabBarController *tabBarVC_FD;
@property (nonatomic, strong, readwrite, nullable) FKTabBarController *tabBarVC_FK;
@property (nonatomic, assign, readwrite) XZTabBarType currentType;

@end

@implementation XZTabBarManager

+ (instancetype)shared {
    static XZTabBarManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarVC_FD = [[FDTabBarController alloc] init];
        self.tabBarVC_FK = [[FKTabBarController alloc] init];
    }
    return self;
}

- (void)switchToFD {
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    win.rootViewController = [self tabBarVC_FD];
    self.currentType = XZTabBarType_FD;
    XZDebugLog(@"切换到 FD");
}

- (void)switchToFK {
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    win.rootViewController = [self tabBarVC_FK];
    self.currentType = XZTabBarType_FK;
    XZDebugLog(@"切换到 FK");
}

@end
