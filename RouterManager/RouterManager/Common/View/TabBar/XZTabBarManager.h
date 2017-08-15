//
//  XZTabBarManager.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/15.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZTabBarManager : NSObject

+ (instancetype)shared;

- (void)switchToFD;
- (void)switchToFK;

@end
