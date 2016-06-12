//
//  RouterRegisterManager.m
//  Ayibang
//
//  Created by 周际航 on 16/2/2.
//  Copyright © 2016年 ayibang. All rights reserved.
//

#import "RouterRegisterManager.h"

#import "HomeViewController.h"
#import "HAViewController.h"
#import "HBViewController.h"
#import "OrderViewController.h"
#import "OAViewController.h"
#import "OBViewController.h"
#import "WebViewController.h"

// 首页
NSString *const kRouterTypeHomePage     = @"HomePage";
// HA 页面
NSString *const kRouterTypeHA           = @"HA";
// HB 页面
NSString *const kRouterTypeHB           = @"HB";
// 订单
NSString *const kRouterTypeOrderPage    = @"OrderPage";
// OA 页面
NSString *const kRouterTypeOA           = @"OA";
// OB 页面
NSString *const kRouterTypeOB           = @"OB";
// web
NSString *const kRouterTypeWeb           = @"Web";


@implementation RouterRegisterManager

+ (void)load{
    [super load];
    [self setUpRoutableDictionary];
}

+ (instancetype)sharedManager{
    static RouterRegisterManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (instancetype)init{
    if (self = [super init]) {
        _routerMDic = [@{} mutableCopy];
    }
    return self;
}

// 给定协议名称，返回该协议对应的是根节点中第几个位置，如果不是根节点对应的协议，直接返回-1
+ (NSInteger)indexOfRootViewControllerWithRouterPathName:(NSString *)pathName{
    NSInteger index = -1;
    
    if ([pathName isEqualToString:kRouterTypeHomePage]) {
        index = 0;
    }else if([pathName isEqualToString:kRouterTypeOrderPage]){
        index = 1;
    }
    
    return index;
}

+ (void)setUpRoutableDictionary{
    RouterRegisterManager *sharedManager = [self sharedManager];
    [sharedManager registerRouterType];
}


#pragma mark - 注册跳转默认路径
- (void)registerRouterType{
    
    [_routerMDic setObject:[HomeViewController class] forKey:kRouterTypeHomePage];
    [_routerMDic setObject:[HAViewController class] forKey:kRouterTypeHA];
    [_routerMDic setObject:[HBViewController class] forKey:kRouterTypeHB];
    
    [_routerMDic setObject:[OrderViewController class] forKey:kRouterTypeOrderPage];
    [_routerMDic setObject:[OAViewController class] forKey:kRouterTypeOA];
    [_routerMDic setObject:[OBViewController class] forKey:kRouterTypeOB];
    
    [_routerMDic setObject:[WebViewController class] forKey:kRouterTypeWeb];
}
@end
