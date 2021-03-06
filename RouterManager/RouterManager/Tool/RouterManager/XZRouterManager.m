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
#import "XZTabBarManager.h"

BOOL isUserLogin = YES;
static CGFloat const kRouterTransitionTime = 0.5;

typedef NS_ENUM(NSUInteger, XZRouterTransitionType) {
    XZRouterTransitionTypePresent,
    XZRouterTransitionTypePush
};

@interface UIViewController (XZRouter)

- (void)router_dismissPresentedViewControllerAnimated:(BOOL)animated completion:(void (^)())completion;

@end

@interface UINavigationController (XZRouter)

- (void)router_popToRootViewController:(BOOL)animated;
    
@end

@interface UITabBarController (XZRouter)

- (void)router_allChildNavigationControllersPopToRoot;

@end

@interface XZRouterManager (XZRouter) <CAAnimationDelegate>

+ (void)private_routerWithModel:(XZRouterModel *)model fromVC:(UIViewController *)fromVC;

+ (BOOL)private_validateModel:(XZRouterModel *)model;

@end

@interface XZRouterManager()

@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *, NSString *> *pathMDic;
@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *, NSArray<NSString *>*> *rootMDic;
@property (nonatomic, strong, nullable) NSMutableArray<NSString *> *presentMArr;

@property (nonatomic, strong, nullable) XZRouterModel *currentModel;
@property (nonatomic, strong, nullable) UIWindow *transitionWindow;     // 用于处理 CATransition 是黑色背景的问题

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
        self.rootMDic = [@{} mutableCopy];
        self.presentMArr = [@[] mutableCopy];
    }
    return self;
}

- (void)registerPath:(NSString *)path forClassName:(NSString *)className {
    if (!([path isKindOfClass:[NSString class]] && path.length > 0)) {
        NSAssert(false, @"路由注册失败， path %@ 必须为非空字符串", path);
        return;
    }
    Class class = NSClassFromString(className);
    if (![class conformsToProtocol:@protocol(XZRoutableProtocol)]) {
        NSAssert(false, @"路由注册失败， class %@ 必须实现 XZRoutableProtocol 协议", class);
        return;
    }
    if (self.pathMDic[path] != nil) {
        NSAssert(false, @"路由注册失败， %@ 已被注册为 %@，不可覆盖注册", path, self.pathMDic[path]);
        return;
    }
    self.pathMDic[path] = className;
}
- (void)registerRootPaths:(NSArray<NSString *> *)paths forRootName:(NSString *)name {
    if (!([name isKindOfClass:[NSString class]] && name.length > 0)) {
        NSAssert(false, @"路由注册失败， rootName %@ 必须为非空字符串", name);
        return;
    }
    if ((self.rootMDic[name] != nil)) {
        NSAssert(false, @"路由注册失败， rootName 不可覆盖注册", name);
        return;
    }
    if (!(paths.count > 0)) {
        NSAssert(false, @"路由注册失败， rootPaths %@ 必须为非空数组", paths);
        return;
    }
    for (NSString *path in paths) {
        if (self.pathMDic[path] == nil) {
            NSAssert(false, @"路由注册失败， rootPaths 中包含的路径 path %@ 必须为已注册的路径", path);
            return;
        }
    }
    self.rootMDic[name] = paths;
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

- (UIWindow *)transitionWindow {
    if (_transitionWindow==nil) {
        _transitionWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _transitionWindow.rootViewController = [UIViewController new];
        _transitionWindow.backgroundColor = [UIColor whiteColor];
        _transitionWindow.windowLevel = UIWindowLevelNormal-1;
        _transitionWindow.hidden = NO;
    }
    return _transitionWindow;
}

@end

@implementation XZRouterManager (XZRouter)

- (XZTabBarRouterType)private_tabBarRouterTypeForPathName:(NSString *)pathName {
    __block XZTabBarRouterType type = XZTabBarRouterType_none;
    [self.rootMDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<NSString *> * _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj containsObject:pathName]) {return;}
        
        if ([key isEqualToString:kRouterTabBar_FD]) {
            type = type | XZTabBarRouterType_FD;
        } else if ([key isEqualToString:kRouterTabBar_FK]) {
            type = type | XZTabBarRouterType_FK;
        }
    }];
    return type;
}

- (BOOL)private_isRootPath:(NSString *)path {
    __block BOOL isRoot = NO;
    [self.rootMDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<NSString *> * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj containsObject:path]) {
            isRoot = YES;
            *stop = YES;
        }
    }];
    return isRoot;
}

+ (void)private_routerWithModel:(XZRouterModel *)model fromVC:(UIViewController *)fromVC {
    if (![self private_validateModel:model]) {return;}
    if (fromVC.navigationController == nil) {
        XZDebugLog(@"fromVC %@ 必须存在navigationController才可使用路由", fromVC);
        return;
    }
    XZRouterManager *shared = [self shared];
    
    // 根据model数据，选择使用何种转场动画
    [self private_selectTransitionTypeWithRouterModel:model];
    
    // 取消当前页面下presented的页面，如 UIAlertController
    UINavigationController *fromNav = fromVC.navigationController;
    if (fromVC.presentedViewController && !fromVC.presentedViewController.isBeingDismissed) {
        [fromVC router_dismissPresentedViewControllerAnimated:NO completion:^{
            [shared private_recursiveShow:model.list index:0 toNavigation:fromNav completion:^(UINavigationController *newNav) {}];
        }];
    } else {
        [shared private_recursiveShow:model.list index:0 toNavigation:fromNav completion:^(UINavigationController *newNav) {}];
    }
    XZDebugLog(@"路由完成");
}

- (void)private_recursiveShow:(NSArray<XZRouterNodeModel *> *)modelList index:(NSInteger)index toNavigation:(UINavigationController *)nav completion:(void (^)(UINavigationController *newNav))completion {
    if (modelList.count == 0) {return;}
    if (index >= modelList.count) {return;}
    XZRouterNodeModel *node = modelList[index];
    NSString *path = node.path;
    
    __weak typeof (self) weakSelf = self;
    void (^finalBlock)(UINavigationController *) = ^(UINavigationController *newNav) {
        if (index==modelList.count-1 && completion!=nil) {completion(newNav);}
        [weakSelf private_recursiveShow:modelList index:index+1 toNavigation:newNav completion:completion];
    };
    
    if ([self private_tabBarRouterTypeForPathName:path] != XZTabBarRouterType_none) {
        // 返回选中根节点
        [self private_selectTabBarRoot:modelList index:index fromNavigation:nav completion:completion];
    } else {
        NSString *className = self.pathMDic[path];
        Class class = NSClassFromString(className);
        UIViewController *newVC = [[class alloc] initWithRouterParameters:node.param];
        if ([self.presentMArr containsObject:path]) {
            // present
            UINavigationController *newNav = [[BaseNavigationController alloc] initWithRootViewController:newVC];
            [nav presentViewController:newNav animated:NO completion:^{
                finalBlock(newNav);
            }];
        } else {
            // push
            [nav pushViewController:newVC animated:NO];
            finalBlock(nav);
        }
    }
}

- (void)private_selectTabBarRoot:(NSArray<XZRouterNodeModel *> *)modelList index:(NSInteger)index fromNavigation:(UINavigationController *)nav completion:(void (^)(UINavigationController *newNav))completion {
    if (modelList.count == 0) {return;}
    if (index >= modelList.count) {return;}
    XZRouterNodeModel *node = modelList[index];
    
    UIViewController *rootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (![rootVC isKindOfClass:[UITabBarController class]]) {return;}
    UITabBarController *currentTabVC = (UITabBarController *)rootVC;
    
    // 1 得到 fromNav
    if (![currentTabVC.selectedViewController isKindOfClass:[UINavigationController class]]) {return;}
    UINavigationController *fromNav = (UINavigationController *)currentTabVC.selectedViewController;
    
    __weak typeof (self) weakSelf = self;
    void (^dismissCompletionBlock)() = ^() {
        if (node.rootInfo.isSaveHistory == NO ) {
            [fromNav router_popToRootViewController:NO];
        }
        // 3 得到 targetNav
        XZTabBarRouterType targetType = [self private_targetTabBarTypeWithModel:node];
        UITabBarController *targetTabVC = targetType==XZTabBarRouterType_FD ? [XZTabBarManager shared].tabBarVC_FD : [XZTabBarManager shared].tabBarVC_FK;
        NSInteger targetIndex = [XZRouterRegisterTool indexOfRootPath:node.path withTabBarType:targetType];
        if (targetIndex >= targetTabVC.childViewControllers.count) {return;}
        if (![targetTabVC.childViewControllers[targetIndex] isKindOfClass:[UINavigationController class]]) {return;}
        
        // 切换tabbar
        if (currentTabVC != targetTabVC) {
            if (targetType == XZTabBarRouterType_FD) {
                [[XZTabBarManager shared] switchToFD];
            } else {
                [[XZTabBarManager shared] switchToFK];
            }
            // 之前的tabbar必须回到根位置
            [currentTabVC router_allChildNavigationControllersPopToRoot];
        }
        
        UINavigationController *targetNav = (UINavigationController *)targetTabVC.childViewControllers[targetIndex];
        [targetNav router_popToRootViewController:NO];
        
        // 4 清理 targetNav 的层级，选中tabVC相应的节点
        targetTabVC.selectedIndex = targetIndex;
        if (index==modelList.count-1 && completion!=nil) {completion(targetNav);}
        [weakSelf private_recursiveShow:modelList index:index+1 toNavigation:targetNav completion:completion];
    };
    
    // 2 清理 fromNav的层级
    if (fromNav.presentedViewController && !fromNav.presentedViewController.isBeingDismissed) {
        [fromNav router_dismissPresentedViewControllerAnimated:NO completion:^{
            dismissCompletionBlock();
        }];
    } else {
        dismissCompletionBlock();
    }
}

+ (void)private_selectTransitionTypeWithRouterModel:(XZRouterModel *)model {
    if (model.list.count == 0) {return;}
    
    // 返回指定根路径时，不使用动画
    if (!(model.list.count == 1 && [[self shared] private_isRootPath:model.list.firstObject.path])) {
        BOOL isPresentTransition = [[[self shared] presentMArr] containsObject:model.list.lastObject.path];
        XZRouterTransitionType type = isPresentTransition ? XZRouterTransitionTypePresent : XZRouterTransitionTypePush;
        [self private_transitionWithType:type];
    }
}

- (XZTabBarRouterType)private_targetTabBarTypeWithModel:(XZRouterNodeModel *)model {
    NSString *targetTab = model.rootInfo.targetTab;
    if ([targetTab isEqualToString:kRouterTabBar_FD]) {
        return XZTabBarRouterType_FD;
    } else if ([targetTab isEqualToString:kRouterTabBar_FK]) {
        return XZTabBarRouterType_FK;
    } else {
        XZTabBarRouterType targetType = [self private_tabBarRouterTypeForPathName:model.path];
        if (targetType==XZTabBarRouterType_none || targetType==XZTabBarRouterType_both) {
            targetType = [XZTabBarManager shared].currentType==XZTabBarType_FD ? XZTabBarRouterType_FD : XZTabBarRouterType_FK;
        }
        return targetType;
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
        Class pathClass = NSClassFromString(shared.pathMDic[path]);
        
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
        
        if ([pathClass respondsToSelector:@selector(router_needLogin)]) {
            if ([pathClass router_needLogin] && !isUserLogin) {
                XZDebugLog(@"路由校验失败：%@ 协议对应的class %@ 需要登陆才能访问", path, pathClass);
                return NO;
            }
        }
        
        if (node.rootInfo != nil && node.rootInfo.targetTab != nil) {
            if ([node.rootInfo.targetTab isEqualToString:kRouterTargetTab_NOW]) {
                if ([[XZTabBarManager shared] currentType] == XZTabBarType_FK && ![shared.rootMDic[kRouterTabBar_FK] containsObject:node.path]) {
                    XZDebugLog(@"路由校验失败：targetTab %@ (FK)不包含 rootPath %@ ", node.rootInfo.targetTab, node.path);
                    return NO;
                }
                if ([[XZTabBarManager shared] currentType] == XZTabBarType_FD && ![shared.rootMDic[kRouterTabBar_FD] containsObject:node.path]) {
                    XZDebugLog(@"路由校验失败：targetTab %@ (FD)不包含 rootPath %@ ", node.rootInfo.targetTab, node.path);
                    return NO;
                }
            } else if ([node.rootInfo.targetTab isEqualToString:kRouterTargetTab_FK]) {
                if (![shared.rootMDic[kRouterTabBar_FK] containsObject:node.path]) {
                    XZDebugLog(@"路由校验失败：targetTab %@ (FK)不包含 rootPath %@ ", node.rootInfo.targetTab, node.path);
                    return NO;
                }
            } else if ([node.rootInfo.targetTab isEqualToString:kRouterTargetTab_FD]) {
                if (![shared.rootMDic[kRouterTabBar_FD] containsObject:node.path]) {
                    XZDebugLog(@"路由校验失败：targetTab %@ (FD)不包含 rootPath %@ ", node.rootInfo.targetTab, node.path);
                    return NO;
                }
            } else {
                XZDebugLog(@"路由校验失败：targetTab %@ 不包含 rootPath %@ ", node.rootInfo.targetTab, node.path);
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

+ (void)private_transitionWithType:(XZRouterTransitionType)type {
    [[XZRouterManager shared] transitionWindow];
    
    CGFloat transitionDuration = kRouterTransitionTime;
    
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    win.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transitionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        win.userInteractionEnabled = YES;
    });
    
    CATransition *animation = [CATransition animation];
    animation.duration = transitionDuration;
    
    animation.type = kCATransitionMoveIn;
    if (type == XZRouterTransitionTypePush) {
        animation.subtype = kCATransitionFromRight;
    } else if (type == XZRouterTransitionTypePresent) {
        animation.subtype = kCATransitionFromTop;
    }
    
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [win.layer addAnimation:animation forKey:@"animation"];
}

@end

@implementation UIViewController (XZRouter)

// [self dismissViewControllerAnimated...] 可能将自己dimiss掉，或将self.presentedvc给dismiss掉，此方法确保只会dismiss自己的self.presentedVC
// dispatch_after，确保iOS8下present、dismiss同时进行不会崩溃
- (void)router_dismissPresentedViewControllerAnimated:(BOOL)animated completion:(void (^)())completion {
    if (self.presentedViewController && !self.presentedViewController.isBeingDismissed) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:animated completion:completion];
        });
    }
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

@implementation UITabBarController (XZRouter)

- (void)router_allChildNavigationControllersPopToRoot {
    __weak typeof (self) weakSelf = self;
    void (^finalBlock)() = ^ {
        NSArray *childs = weakSelf.childViewControllers;
        for (UIViewController *vc in childs) {
            if ([vc isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)vc;
                [nav router_popToRootViewController:NO];
            }
        }
    };
    if (self.presentedViewController && !self.presentedViewController.isBeingDismissed) {
        [self router_dismissPresentedViewControllerAnimated:NO completion:^{
            finalBlock();
        }];
    } else {
        finalBlock();
    }
}

@end


