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
    
    NSMutableArray<XZRouterNodeModel *> *marr = [model.list mutableCopy];
    XZRouterNodeModel *firstNode = marr.firstObject;
    BOOL animated = marr.count == 1;
    NSInteger tabIndex = [XZRouterRegisterTool indexOfRootPath:firstNode.path];
    UINavigationController *fromNav = fromVC.navigationController;
    XZRouterManager *shared = [self shared];
    
    // 取消当前页面下presented的页面，如 UIAlertController
    [fromVC.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    
    if (tabIndex == NSNotFound) {
        // 直接跳转
        [shared private_recursiveShow:marr index:0 toNavigation:fromNav animated:animated completion:nil];
    } else {
        // 返回根路径，选中目标tab
        UINavigationController *targetNav = [self private_backToTabBarFromVC:fromVC selectTabBarIndex:tabIndex modelList:marr];
        if (targetNav == nil) {return;}
        [marr removeObjectAtIndex:0];
        
        // 新节点中依次跳转
        [shared private_recursiveShow:marr index:0 toNavigation:targetNav animated:NO completion:nil];
    }
    XZDebugLog(@"路由完成");
}

- (void)private_recursiveShow:(NSArray<XZRouterNodeModel *> *)modelList index:(NSInteger)index toNavigation:(UINavigationController *)nav animated:(BOOL)animated completion:(void (^)(UINavigationController *newNav))completion {
    if (modelList.count == 0) {return;}
    if (index >= modelList.count) {return;}
    
    XZRouterNodeModel *node = modelList[index];
    NSString *path = node.path;
    Class class = [self pathMDic][path];
    UIViewController *newVC = [[class alloc] initWithRouterParameters:node.param];
    
    __weak typeof (self) weakSelf = self;
    void (^finalBlock)(UINavigationController *) = ^(UINavigationController *newNav) {
        if (index==modelList.count-1 && completion!=nil) {completion(newNav);}
        [weakSelf private_recursiveShow:modelList index:index+1 toNavigation:newNav animated:NO completion:completion];
    };
    
    if ([self.presentMArr containsObject:path]) {
        UINavigationController *newNav = [[BaseNavigationController alloc] initWithRootViewController:newVC];
        [nav presentViewController:newNav animated:animated completion:^{
            finalBlock(newNav);
        }];
    } else {
        [nav pushViewController:newVC animated:animated];
        finalBlock(nav);
    }
}

+ (UINavigationController *)private_backToTabBarFromVC:(UIViewController *)fromVC selectTabBarIndex:(NSInteger)index modelList:(NSArray<XZRouterNodeModel *> *)list {
    UIViewController *rootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (![rootVC isKindOfClass:[UITabBarController class]]) {return nil;}
    UITabBarController *tabVC = (UITabBarController *)rootVC;
    if (index >= tabVC.childViewControllers.count) {return nil;}
    if (![tabVC.selectedViewController isKindOfClass:[UINavigationController class]]) {return nil;}
    UINavigationController *fromNav = (UINavigationController *)tabVC.selectedViewController;
    
    BOOL animated = (list.count==1 && tabVC.selectedIndex==index) ? YES : NO;
    
    // dismiss present的视图
    UIViewController *vc = fromVC;
    while (vc.presentingViewController != nil) {
        vc = vc.presentingViewController;
    }
    if (vc != fromVC) {
        [vc dismissViewControllerAnimated:animated completion:nil];
        animated = NO;
    }
    
    // pop 当前nav
    [fromNav router_popToRootViewController:animated];
    
    // 选中目标nav
    tabVC.selectedIndex = index;
    if (![tabVC.selectedViewController isKindOfClass:[UINavigationController class]]) {return nil;}
    UINavigationController *targetNav = (UINavigationController *)tabVC.selectedViewController;
    [targetNav router_popToRootViewController:NO];
    
    return  targetNav;
}


+ (BOOL)private_validateModel:(XZRouterModel *)model {
    if (model.list.count == 0) {return NO;}
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

