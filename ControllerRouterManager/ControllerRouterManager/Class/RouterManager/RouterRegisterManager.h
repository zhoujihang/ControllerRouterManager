//
//  RouterRegisterManager.h
//  Ayibang
//
//  Created by 周际航 on 16/2/2.
//  Copyright © 2016年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 首页
FOUNDATION_EXTERN NSString *const kRouterTypeHomePage;
// HA 页面
FOUNDATION_EXTERN NSString *const kRouterTypeHA;
// HB 页面
FOUNDATION_EXTERN NSString *const kRouterTypeHB;
// 订单
FOUNDATION_EXTERN NSString *const kRouterTypeOrderPag;
// OA 页面
FOUNDATION_EXTERN NSString *const kRouterTypeOA;
// OB 页面
FOUNDATION_EXTERN NSString *const kRouterTypeOB;


@interface RouterRegisterManager : NSObject
// 路由映射的字典： @"rcbj" : [UIViewController class]
@property (nonatomic, strong, readonly) NSMutableDictionary *routerMDic;
// 单例
+ (instancetype)sharedManager;

// 给定协议名称，返回该协议对应的是根节点中第几个位置，如果不是根节点对应的协议，直接返回-1
+ (NSInteger)indexOfRootViewControllerWithRouterPathName:(NSString *)pathName;

@end
