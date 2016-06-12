//
//  StoredKeyManager.h
//  ControllerRouterManager
//
//  Created by 周际航 on 16/6/12.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoredKeyManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, assign, getter=isLogin) BOOL login;

@end
