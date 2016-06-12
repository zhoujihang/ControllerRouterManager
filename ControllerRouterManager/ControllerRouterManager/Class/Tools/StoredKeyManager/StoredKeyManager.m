//
//  StoredKeyManager.m
//  ControllerRouterManager
//
//  Created by 周际航 on 16/6/12.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "StoredKeyManager.h"

@implementation StoredKeyManager

+ (instancetype)sharedManager{
    static StoredKeyManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

@end
