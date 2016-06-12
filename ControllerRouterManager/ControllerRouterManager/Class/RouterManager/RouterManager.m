//
//  RouterManager.m
//  Ayibang
//
//  Created by 周际航 on 16/2/2.
//  Copyright © 2016年 ayibang. All rights reserved.
//

#import "RouterManager.h"
#import "StoredKeyManager.h"

@implementation UINavigationController (RouterManager)

- (void)ext_leaveTwoVCInNavigationStack{
    NSArray *childVCArr = self.childViewControllers;
    if (childVCArr.count<=2) return;
    
    NSArray *newChildVCArr = @[[childVCArr firstObject],[childVCArr lastObject]];
    self.viewControllers = newChildVCArr;
}


@end

@implementation RouterManager

+ (void)routerWithRouterInfoModel:(RouterInfoModel *)infoModel fromViewController:(UIViewController *)fromVC{

    if (!infoModel) {return;}
    // 跳转到指定页面
    [self routerToJumpWithRouterInfoModel:infoModel fromController:fromVC];
}
// 跳转到指定页面
+ (void)routerToJumpWithRouterInfoModel:(RouterInfoModel *)infoModel fromController:(UIViewController *)fromVC{
    // 有能跳转的路径才进行跳转
    NSArray *routerVCArr = [self routerVCArrayFromRouterInfoModel:infoModel];
    if (routerVCArr.count == 0) {return;}
    
    UINavigationController *fromNavController = fromVC.navigationController;
    
    // 应该跳到哪个tabbar页签下
    RouterJumpNodeModel *jumpNodeModel = [infoModel.jumpNodeArray firstObject];
    NSInteger tarBarIndex = [RouterRegisterManager indexOfRootViewControllerWithRouterPathName:jumpNodeModel.path];
    
    if (tarBarIndex == -1) {
        // 直接跳转
        [self jumpFromNavigationController:fromNavController withRouterInfoModel:infoModel];
        return;
    }
    
    // 使用路径跳转
    UITabBarController *mainTabBarController = (UITabBarController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    if (![mainTabBarController isKindOfClass:[UITabBarController class]] || mainTabBarController.childViewControllers.count==0) {return;}
    UINavigationController *targetNavController = mainTabBarController.childViewControllers[tarBarIndex];
    
    // 当前nav退出到根控制器下
    [fromNavController ext_leaveTwoVCInNavigationStack];
    [fromNavController popToRootViewControllerAnimated:NO];
    
    // 切换到目标页面所在页签下
    mainTabBarController.selectedIndex = tarBarIndex;
    
    // 目标nav跳转到目标页面
    [targetNavController ext_leaveTwoVCInNavigationStack];
    [targetNavController popToRootViewControllerAnimated:NO];
    
    [self jumpFromNavigationController:targetNavController withRouterInfoModel:infoModel];
}
#pragma mark - 从指定导航栏进行跳转
+ (void)jumpFromNavigationController:(UINavigationController *)navigationController withRouterInfoModel:(RouterInfoModel *)infoModel{
    
    // 1. 判断是否直接push
    RouterJumpNodeModel *jumpNodeModel = [infoModel.jumpNodeArray firstObject];
    NSInteger tarBarIndex = [RouterRegisterManager indexOfRootViewControllerWithRouterPathName:jumpNodeModel.path];
    BOOL isDirectPush = tarBarIndex==-1 ? YES : NO;
    
    // 2. 直接跳转且只跳一个时动画设置为yes
    BOOL animated = isDirectPush&&(infoModel.jumpNodeArray.count==1);
    
    // 3. 获取所有需要跳转的对象集合
    NSArray *routerVCArr = [self routerVCArrayFromRouterInfoModel:infoModel];
    
    // 4. 统一跳转
    for (int i=0; i<routerVCArr.count; i++) {
        // 默认路径跳转时，第一个根路径应该跳过
        if (!isDirectPush && i==0) {continue;}
        
        UIViewController *routerVC = routerVCArr[i];
        [navigationController pushViewController:routerVC animated:animated];
    }
}

#pragma mark - 获取跳转路径的集合
// 如果返回空数组，表示没有合法的跳转路径
+ (NSArray *)routerVCArrayFromRouterInfoModel:(RouterInfoModel *)infoModel{
    NSMutableArray *routerVCMArr = [@[] mutableCopy];
    for (int i=0; i<infoModel.jumpNodeArray.count; i++) {
        BOOL isValidateVC = YES;
        
        RouterJumpNodeModel *nodeModel = infoModel.jumpNodeArray[i];
        
        // 1 跳转对象不为空
        UIViewController *routerVC = [self routableViewControllerWithClass:nodeModel.pathClass parameters:nodeModel.parameters];
        if (!routerVC) {
            NSString *message = [NSString stringWithFormat:@"错误 跳转对象创建失败 class:%@ ,paratemers:%@",nodeModel.pathClass, nodeModel.parameters];
            NSLog(@"router %@",message);
            isValidateVC = NO;
        }
        
        // 2 校验是否需要登录
        if ([routerVC respondsToSelector:@selector(isNeedLogin)]) {
            BOOL needLogin = (BOOL)[routerVC performSelector:@selector(isNeedLogin)];
            BOOL isLogin = [StoredKeyManager sharedManager].isLogin;
            // 跳转对象需要登录，但是当前用户未登录
            if (needLogin && !isLogin) {
                NSString *message = [NSString stringWithFormat:@"错误 跳转对象需要登录权限 class:%@",nodeModel.pathClass];
                NSLog(@"router %@",message);
                isValidateVC = NO;
            }
        }
        
        if (!isValidateVC) {
            // 有一个路径不满足，则整个跳转失败
            [routerVCMArr removeAllObjects];
            break;
        }
        
        routerVC.hidesBottomBarWhenPushed = YES;
        [routerVCMArr addObject:routerVC];
    }

    return [routerVCMArr copy];
}

#pragma mark - 获取单个跳转的对象
+ (UIViewController *)routableViewControllerWithClass:(Class)vcClass parameters:(NSDictionary *)parameters{
    
    UIViewController *vc = nil;
    if (class_respondsToSelector(vcClass, @selector(initWithRoutableParameters:))) {
        vc = [[vcClass alloc] initWithRoutableParameters:parameters];
    }else{
        vc = [[vcClass alloc] init];
    }
    
    return vc;
}

#pragma mark - 判断给定的跳转模型能否跳转
+ (BOOL)isValidateRouterWithModel:(RouterInfoModel *)infoModel{
    NSArray *vcArray = [self routerVCArrayFromRouterInfoModel:infoModel];
    return vcArray.count != 0;
}

@end
