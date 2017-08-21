//
//  XZRouterRegisterTool.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "XZRouterRegisterTool.h"
#import "XZRouterManager.h"
#import "HomeAViewController.h"
#import "HomeBViewController.h"
#import "HomeCViewController.h"
#import "HouseAViewController.h"
#import "HouseBViewController.h"
#import "HouseCViewController.h"
#import "OrderAViewController.h"
#import "OrderBViewController.h"
#import "OrderCViewController.h"
#import "MessageAViewController.h"
#import "MessageBViewController.h"
#import "MessageCViewController.h"
#import "PersonalAViewController.h"
#import "PersonalBViewController.h"
#import "PersonalCViewController.h"
#import "LoginViewController.h"


NSString *const kRouterTabBar_FD = @"FD";
NSString *const kRouterTabBar_FK = @"FK";
NSString *const kRouter_HomeA = @"HomeA";
NSString *const kRouter_HomeB = @"HomeB";
NSString *const kRouter_HomeC = @"HomeC";
NSString *const kRouter_HouseA = @"HouseA";
NSString *const kRouter_HouseB = @"HouseB";
NSString *const kRouter_HouseC = @"HouseC";
NSString *const kRouter_OrderA = @"OrderA";
NSString *const kRouter_OrderB = @"OrderB";
NSString *const kRouter_OrderC = @"OrderC";
NSString *const kRouter_MessageA = @"MessageA";
NSString *const kRouter_MessageB = @"MessageB";
NSString *const kRouter_MessageC = @"MessageC";
NSString *const kRouter_PersonalA = @"PersonalA";
NSString *const kRouter_PersonalB = @"PersonalB";
NSString *const kRouter_PersonalC = @"PersonalC";
NSString *const kRouter_Login = @"Login";

@implementation XZRouterRegisterTool

+ (void)setup {
    XZRouterManager *shared = [XZRouterManager shared];
    
    [shared registerPath:kRouter_HomeA forClassName:NSStringFromClass([HomeAViewController class])];
    [shared registerPath:kRouter_HomeB forClassName:NSStringFromClass([HomeBViewController class])];
    [shared registerPath:kRouter_HomeC forClassName:NSStringFromClass([HomeCViewController class])];
    
    [shared registerPath:kRouter_HouseA forClassName:NSStringFromClass([HouseAViewController class])];
    [shared registerPath:kRouter_HouseB forClassName:NSStringFromClass([HouseBViewController class])];
    [shared registerPath:kRouter_HouseC forClassName:NSStringFromClass([HouseCViewController class])];
    
    [shared registerPath:kRouter_OrderA forClassName:NSStringFromClass([OrderAViewController class])];
    [shared registerPath:kRouter_OrderB forClassName:NSStringFromClass([OrderBViewController class])];
    [shared registerPath:kRouter_OrderC forClassName:NSStringFromClass([OrderCViewController class])];
    
    [shared registerPath:kRouter_MessageA forClassName:NSStringFromClass([MessageAViewController class])];
    [shared registerPath:kRouter_MessageB forClassName:NSStringFromClass([MessageBViewController class])];
    [shared registerPath:kRouter_MessageC forClassName:NSStringFromClass([MessageCViewController class])];
    
    [shared registerPath:kRouter_PersonalA forClassName:NSStringFromClass([PersonalAViewController class])];
    [shared registerPath:kRouter_PersonalB forClassName:NSStringFromClass([PersonalBViewController class])];
    [shared registerPath:kRouter_PersonalC forClassName:NSStringFromClass([PersonalCViewController class])];
    [shared registerPath:kRouter_Login forClassName:NSStringFromClass([LoginViewController class])];
    
    [shared registerRootPaths:@[kRouter_HomeA, kRouter_HouseA, kRouter_OrderA, kRouter_MessageA, kRouter_PersonalA] forRootName:kRouterTabBar_FD];
    [shared registerRootPaths:@[kRouter_HomeA, kRouter_OrderA, kRouter_MessageA, kRouter_PersonalA] forRootName:kRouterTabBar_FK];
    [shared registerPresentPaths:@[kRouter_Login]];
    
    
}

+ (NSInteger)indexOfRootPath:(NSString *)path withTabBarType:(XZTabBarRouterType)type {
    if (type == XZTabBarRouterType_none || type == XZTabBarRouterType_both) {return NSNotFound;}
    NSInteger index = NSNotFound;
    if (type == XZTabBarRouterType_FD) {
        if ([path isEqualToString:kRouter_HomeA]) {
            index = 0;
        } else if ([path isEqualToString:kRouter_HouseA]) {
            index = 1;
        } else if ([path isEqualToString:kRouter_OrderA]) {
            index = 2;
        } else if ([path isEqualToString:kRouter_MessageA]) {
            index = 3;
        } else if ([path isEqualToString:kRouter_PersonalA]) {
            index = 4;
        }
    } else if (type == XZTabBarRouterType_FK) {
        if ([path isEqualToString:kRouter_HomeA]) {
            index = 0;
        } else if ([path isEqualToString:kRouter_OrderA]) {
            index = 1;
        } else if ([path isEqualToString:kRouter_MessageA]) {
            index = 2;
        } else if ([path isEqualToString:kRouter_PersonalA]) {
            index = 3;
        }
    }
    return index;
}

@end
