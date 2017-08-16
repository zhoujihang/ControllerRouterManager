//
//  XZTabBarManager.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/15.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDTabBarController.h"
#import "FKTabBarController.h"

typedef NS_ENUM(NSUInteger, XZTabBarType) {
    XZTabBarType_FD,
    XZTabBarType_FK,
};

@interface XZTabBarManager : NSObject

@property (nonatomic, strong, readonly, nullable) FDTabBarController *tabBarVC_FD;
@property (nonatomic, strong, readonly, nullable) FKTabBarController *tabBarVC_FK;
@property (nonatomic, assign, readonly) XZTabBarType currentType;

+ (instancetype _Nonnull )shared;

- (void)switchToFD;
- (void)switchToFK;

@end
