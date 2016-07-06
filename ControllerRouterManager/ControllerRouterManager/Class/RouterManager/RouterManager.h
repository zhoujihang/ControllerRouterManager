//
//  RouterManager.h
//  Ayibang
//
//  Created by 周际航 on 16/2/2.
//  Copyright © 2016年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RouterInfoModel.h"
#import "RouterRegisterManager.h"

@interface UINavigationController (RouterManager)

// 抽空 navigationController 中的控制器栈，只保留根控制器和当前控制器
// 这么做是因为 nav poptoroot 然后再 push 时有个系统bug，会导致tabbar消失
// 但是该bug在 nav 的栈中只有2个控制器时并不存在！！
- (void)ext_leaveTwoVCInNavigationStack;

@end


// 路由代理方法
@protocol RoutableDelegate <NSObject>
// 如果路由跳转时需要参数则实现该方法
@optional
// 给定参数的初始化方法
- (instancetype)initWithRoutableParameters:(NSDictionary *)dic;
// 路由页面自己给出是否需要登录，不实现则认为不需要登录
+ (BOOL)isNeedLogin;
// 校验路由参数是否合法
+ (BOOL)validateRoutableParameters:(NSDictionary *)dic;
@end

@interface RouterManager : NSObject

// 跳转通用方法
+ (void)routerWithRouterInfoModel:(RouterInfoModel *)infoModel fromViewController:(UIViewController *)fromVC;

// 判断给定的跳转模型能否跳转
+ (BOOL)isValidateRouterWithModel:(RouterInfoModel *)infoModel;

@end

