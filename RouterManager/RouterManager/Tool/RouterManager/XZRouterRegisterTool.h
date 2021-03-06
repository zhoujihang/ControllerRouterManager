//
//  XZRouterRegisterTool.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XZTabBarRouterType) {
    XZTabBarRouterType_none = 0,
    XZTabBarRouterType_FD = 1 << 0,
    XZTabBarRouterType_FK = 1 << 1,
    XZTabBarRouterType_both = XZTabBarRouterType_FD | XZTabBarRouterType_FK ,
};

FOUNDATION_EXTERN NSString *const kRouterTabBar_FD;
FOUNDATION_EXTERN NSString *const kRouterTabBar_FK;

FOUNDATION_EXTERN NSString *const kRouter_HomeA;
FOUNDATION_EXTERN NSString *const kRouter_HomeB;
FOUNDATION_EXTERN NSString *const kRouter_HomeC;
FOUNDATION_EXTERN NSString *const kRouter_HouseA;
FOUNDATION_EXTERN NSString *const kRouter_HouseB;
FOUNDATION_EXTERN NSString *const kRouter_HouseC;
FOUNDATION_EXTERN NSString *const kRouter_OrderA;
FOUNDATION_EXTERN NSString *const kRouter_OrderB;
FOUNDATION_EXTERN NSString *const kRouter_OrderC;
FOUNDATION_EXTERN NSString *const kRouter_MessageA;
FOUNDATION_EXTERN NSString *const kRouter_MessageB;
FOUNDATION_EXTERN NSString *const kRouter_MessageC;
FOUNDATION_EXTERN NSString *const kRouter_PersonalA;
FOUNDATION_EXTERN NSString *const kRouter_PersonalB;
FOUNDATION_EXTERN NSString *const kRouter_PersonalC;
FOUNDATION_EXTERN NSString *const kRouter_Login;


@interface XZRouterRegisterTool : NSObject

+ (void)setup;

+ (NSInteger)indexOfRootPath:(NSString *)path withTabBarType:(XZTabBarRouterType)type;

@end

