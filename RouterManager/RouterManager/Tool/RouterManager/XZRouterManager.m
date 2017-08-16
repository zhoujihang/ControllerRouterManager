//
//  XZRouterManager.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "XZRouterManager.h"
#import "XZRouterRegisterTool.h"
#import "BaseNavigationController.h"

@interface UINavigationController (XZRouter)

- (void)router_popToRootViewController:(BOOL)animated;
    
@end

@interface XZRouterManager (XZRouter)

+ (void)private_routerWithModel:(XZRouterModel *)model fromVC:(UIViewController *)fromVC;

+ (BOOL)private_validateModel:(XZRouterModel *)model;

@end

@interface XZRouterManager()

@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *, Class> *pathMDic;
@property (nonatomic, strong, nullable) NSMutableArray<NSString *> *rootMArr;
@property (nonatomic, strong, nullable) NSMutableArray<NSString *> *presentMArr;

@property (nonatomic, strong, nullable) XZRouterModel *currentModel;


@end

@implementation XZRouterManager

+ (instancetype)shared {
    static XZRouterManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.pathMDic = [@{} mutableCopy];
        self.rootMArr = [@[] mutableCopy];
        self.presentMArr = [@[] mutableCopy];
    }
    return self;
}

- (void)registerPath:(NSString *)path forClass:(Class)class {
    if (!([path isKindOfClass:[NSString class]] && path.length > 0)) {
        NSAssert(false, @"路由注册失败， path %@ 必须为非空字符串", path);
        return;
    }
    if (![class conformsToProtocol:@protocol(XZRoutableProtocol)]) {
        NSAssert(false, @"路由注册失败， class %@ 必须实现 XZRoutableProtocol 协议", class);
        return;
    }
    if (self.pathMDic[path] != nil) {
        NSAssert(false, @"路由注册失败， %@ 已被注册为 %@，不可覆盖注册", path, self.pathMDic[path]);
        return;
    }
    self.pathMDic[path] = class;
}
- (void)registerRootPaths:(NSArray<NSString *> *)paths {
    self.rootMArr = [paths mutableCopy];
}
- (void)registerPresentPaths:(NSArray<NSString *> *)paths{
    self.presentMArr = [paths mutableCopy];
}

+ (void)routerWithModel:(XZRouterModel *)model fromVC:(UIViewController *)fromVC {
    [self private_routerWithModel:model fromVC:fromVC];
}

+ (BOOL)validateModel:(XZRouterModel *)model {
    return [self private_validateModel:model];
}

@end

@implementation XZRouterManager (XZRouter)

+ (void)private_routerWithModel:(XZRouterModel *)model fromVC:(UIViewController *)fromVC {
    if (![self private_validateModel:model]) {return;}
    if (fromVC.navigationController == nil) {
        XZDebugLog(@"fromVC %@ 必须存在navigationController才可使用路由", fromVC);
        return;
    }
    
    BOOL animated = model.list.count == 1;
    UINavigationController *fromNav = fromVC.navigationController;
    XZRouterManager *shared = [self shared];
    
    // 取消当前页面下presented的页面，如 UIAlertController
    if (fromVC.presentedViewController) {
        [fromVC.presentedViewController dismissViewControllerAnimated:NO completion:^{
            [shared private_recursiveShow:model.list index:0 toNavigation:fromNav animated:animated completion:^(UINavigationController *newNav) {}];
        }];
    } else {
        [shared private_recursiveShow:model.list index:0 toNavigation:fromNav animated:animated completion:^(UINavigationController *newNav) {}];
    }
    XZDebugLog(@"路由完成");
}

- (void)private_recursiveShow:(NSArray<XZRouterNodeModel *> *)modelList index:(NSInteger)index toNavigation:(UINavigationController *)nav animated:(BOOL)animated completion:(void (^)(UINavigationController *newNav))completion {
    if (modelList.count == 0) {return;}
    if (index >= modelList.count) {return;}
    XZRouterNodeModel *node = modelList[index];
    NSString *path = node.path;
    
    __weak typeof (self) weakSelf = self;
    void (^finalBlock)(UINavigationController *) = ^(UINavigationController *newNav) {
        if (index==modelList.count-1 && completion!=nil) {completion(newNav);}
        [weakSelf private_recursiveShow:modelList index:index+1 toNavigation:newNav animated:NO completion:completion];
    };
    
    if ([self.rootMArr containsObject:path]) {
        // 返回选中根节点
        [self private_selectTabBarRoot:modelList index:index fromNavigation:nav animated:animated completion:completion];
    } else {
        Class class = self.pathMDic[path];
        UIViewController *newVC = [[class alloc] initWithRouterParameters:node.param];
        if ([self.presentMArr containsObject:path]) {
            // present
            UINavigationController *newNav = [[BaseNavigationController alloc] initWithRootViewController:newVC];
            [nav presentViewController:newNav animated:animated completion:^{
                finalBlock(newNav);
            }];
        } else {
            // push
            [nav pushViewController:newVC animated:animated];
            finalBlock(nav);
        }
    }
}

- (void)private_selectTabBarRoot:(NSArray<XZRouterNodeModel *> *)modelList index:(NSInteger)index fromNavigation:(UINavigationController *)nav animated:(BOOL)animated completion:(void (^)(UINavigationController *newNav))completion {
    if (modelList.count == 0) {return;}
    if (index >= modelList.count) {return;}
    XZRouterNodeModel *node = modelList[index];
    
    UIViewController *rootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (![rootVC isKindOfClass:[UITabBarController class]]) {return;}
    UITabBarController *tabVC = (UITabBarController *)rootVC;
    
    // 1 得到 fromNav
    if (![tabVC.selectedViewController isKindOfClass:[UINavigationController class]]) {return;}
    UINavigationController *fromNav = (UINavigationController *)tabVC.selectedViewController;
    
    __weak typeof (self) weakSelf = self;
    void (^dismissCompletionBlock)() = ^() {
        if (node.rootInfo.isSaveHistory == NO) {
            [fromNav router_popToRootViewController:animated];
        }
        // 3 得到 targetNav
        NSInteger targetIndex = [XZRouterRegisterTool indexOfRootPath:node.path];
        if (targetIndex >= tabVC.childViewControllers.count) {return;}
        if (![tabVC.childViewControllers[targetIndex] isKindOfClass:[UINavigationController class]]) {return;}
        UINavigationController *targetNav = (UINavigationController *)tabVC.childViewControllers[targetIndex];
        [targetNav router_popToRootViewController:NO];
        
        // 4 清理 targetNav 的层级，选中tabVC相应的节点
        tabVC.selectedIndex = targetIndex;
        if (index==modelList.count-1 && completion!=nil) {completion(targetNav);}
        [weakSelf private_recursiveShow:modelList index:index+1 toNavigation:targetNav animated:NO completion:completion];
    };
    
    // 2 清理 fromNav的层级
    if (fromNav.presentedViewController) {
        [fromNav.presentedViewController dismissViewControllerAnimated:animated completion:^{
            dismissCompletionBlock();
        }];
    } else {
        dismissCompletionBlock();
    }
}

+ (BOOL)private_validateModel:(XZRouterModel *)model {
    if (model.list.count == 0) {
        XZDebugLog(@"路由校验失败：节点个数为0 %@", model.list);
        return NO;
    }
    XZRouterManager *shared = [self shared];
    for (XZRouterNodeModel *node in model.list) {
        NSString *path = node.path;
        Class pathClass = shared.pathMDic[path];
        
        if (!(pathClass!=nil && [pathClass isSubclassOfClass:[UIViewController class]] && [pathClass conformsToProtocol:@protocol(XZRoutableProtocol)])) {
            XZDebugLog(@"路由校验失败：%@ 协议对应的class %@ 不合法", path, pathClass);
            return NO;
        }
        
        if ([pathClass respondsToSelector:@selector(router_enable)]) {
            if (![pathClass router_enable]) {
                XZDebugLog(@"路由校验失败：%@ 协议对应的class %@ 未开启路由功能", path, pathClass);
                return NO;
            }
        }
        
        if ([pathClass respondsToSelector:@selector(router_validateRouterParameters:)]) {
            if (![pathClass router_validateRouterParameters:node.param]) {
                XZDebugLog(@"路由校验失败：%@ 协议对应的class %@ 校验参数 %@ 未通过", path, pathClass, node.param);
                return NO;
            }
        }
    }
    return YES;
}

@end


@implementation UINavigationController (XZRouter)

- (void)router_popToRootViewController:(BOOL)animated {
    [self router_onlyRemainTopAndBottomViewController];
    [self popViewControllerAnimated:animated];
}

- (void)router_onlyRemainTopAndBottomViewController {
    if (self.viewControllers.count <= 2) {return;}
    self.viewControllers = @[self.viewControllers.firstObject, self.viewControllers.lastObject];
}

@end

