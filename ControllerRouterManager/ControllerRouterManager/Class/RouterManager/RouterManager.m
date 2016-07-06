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
    BOOL isValidateRouter = [self isValidateRouterWithModel:infoModel];
    if (!isValidateRouter) {return;}
    
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
// 调用此方法钱应该先调用 isValidateRouterWithModel 判断路径是否合法
// 如果没有合法路径，将返回 @[]
+ (NSArray *)routerVCArrayFromRouterInfoModel:(RouterInfoModel *)infoModel{
    if (![self isValidateRouterWithModel:infoModel]) {return @[];};
    
    NSMutableArray *routerVCMArr = [@[] mutableCopy];
    for (int i=0; i<infoModel.jumpNodeArray.count; i++) {
        RouterJumpNodeModel *nodeModel = infoModel.jumpNodeArray[i];
        UIViewController *vc = [self routableViewControllerWithClass:nodeModel.pathClass parameters:nodeModel.parameters];
        if (vc == nil) {
            [routerVCMArr removeAllObjects];
            break;
        }
        [routerVCMArr addObject:vc];
    }
    
    return [routerVCMArr copy];
}

#pragma mark - 获取单个跳转的对象
+ (UIViewController *)routableViewControllerWithClass:(Class)vcClass parameters:(NSDictionary *)parameters{
    UIViewController *vc = nil;
    if ([vcClass instancesRespondToSelector:@selector(initWithRoutableParameters:)]) {
        vc = [[vcClass alloc] initWithRoutableParameters:parameters];
    }else{
        vc = [[vcClass alloc] init];
    }
    return vc;
}

#pragma mark - 判断给定的跳转模型能否跳转
+ (BOOL)isValidateRouterWithModel:(RouterInfoModel *)infoModel{
    for (RouterJumpNodeModel *nodeModel in infoModel.jumpNodeArray) {
        if ([self isValidateRouterNodeWithModel:nodeModel] == NO) {
            return NO;
        }
    }
    return YES;
}
#pragma mark - 判断单个节点数据是否合法
+ (BOOL)isValidateRouterNodeWithModel:(RouterJumpNodeModel *)nodeModel{
    
    // 判断登录条件
    BOOL isLogin = [StoredKeyManager sharedManager].isLogin;
    BOOL isNeedLogin = NO;
    if ([nodeModel.pathClass respondsToSelector:@selector(isNeedLogin)]) {
        isNeedLogin = [nodeModel.pathClass isNeedLogin];
    }
    if (isNeedLogin==YES && isLogin==NO) {
        NSString *message = [NSString stringWithFormat:@"路由跳转失败，原因：需要登录 path:%@ class:%@ parameters:%@",nodeModel.path,nodeModel.pathClass, nodeModel.parameters];
        NSLog(@"%@",message);
        return NO;
    }
    
    // 判断路由参数
    if ([nodeModel.pathClass respondsToSelector:@selector(validateRoutableParameters:)]) {
        BOOL validate = [nodeModel.pathClass validateRoutableParameters:nodeModel.parameters];
        if (validate==NO) {
            NSString *message = [NSString stringWithFormat:@"路由跳转失败，原因：缺少参数 path:%@ class:%@ parameters:%@",nodeModel.path,nodeModel.pathClass, nodeModel.parameters];
            NSLog(@"%@",message);
            return NO;
        }
    }
    
    return YES;
}

@end
