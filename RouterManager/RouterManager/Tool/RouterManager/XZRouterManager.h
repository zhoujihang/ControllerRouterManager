//
//  XZRouterManager.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZRouterModel.h"

@protocol XZRoutableProtocol <NSObject>

- (instancetype)initWithRouterParameters:(NSDictionary *)param;
+ (BOOL)router_validateRouterParameters:(NSDictionary *)param;
+ (BOOL)router_enable;

@end


@interface XZRouterManager : NSObject

+ (instancetype)shared;

+ (void)routerWithModel:(XZRouterModel *)model fromVC:(UIViewController *)fromVC;
+ (BOOL)validateModel:(XZRouterModel *)model;

- (void)registerPath:(NSString *)path forClassName:(NSString *)className;
- (void)registerRootPaths:(NSArray<NSString *> *)paths forRootName:(NSString *)name;
- (void)registerPresentPaths:(NSArray<NSString *>*)paths;

@end
