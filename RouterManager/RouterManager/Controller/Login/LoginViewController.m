//
//  LoginViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/15.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "LoginViewController.h"
#import "AnimationTool.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

+ (BOOL)router_enable {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSString *)overload_cellTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [super overload_cellTextForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        text = @"dismiss";
    } else if (indexPath.row == 1) {
        text = @"present";
    } else if (indexPath.row == 2) {
        text = @"Login";
    } else if (indexPath.row == 3) {
        text = @"LoginX5";
    } else if (indexPath.row == 4) {
        text = @"Login_PersonalA_OrderC";
    } else if (indexPath.row == 5) {
        text = @"OrderB_Login_Login_OrderC_Login";
    } else if (indexPath.row == 6) {
        text = @"HouseA_B_C";
    } else if (indexPath.row == 7) {
        text = @"登陆";
    } else if (indexPath.row == 8) {
        text = @"退出登陆";
    } else if (indexPath.row == 9) {
        text = @"MessageA_B_C  需要登陆";
    } else if (indexPath.row == 10) {
        text = @"magic transition";
    } else if (indexPath.row == 11) {
        text = @"HomeA";
    } else if (indexPath.row == 12) {
        text = @"测试 self.presentedVC dimisss 效果";
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (indexPath.row == 1) {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        [XZRouterManager routerWithModel:[XZRouterModel Login] fromVC:self];
    } else if (indexPath.row == 3) {
        [XZRouterManager routerWithModel:[XZRouterModel LoginX5] fromVC:self];
    } else if (indexPath.row == 4) {
        [XZRouterManager routerWithModel:[XZRouterModel Login_PersonalA_OrderC] fromVC:self];
    } else if (indexPath.row == 5) {
        [XZRouterManager routerWithModel:[XZRouterModel OrderB_Login_Login_OrderC_Login] fromVC:self];
    } else if (indexPath.row == 6) {
        [XZRouterManager routerWithModel:[XZRouterModel HouseA_B_C] fromVC:self];
    } else if (indexPath.row == 7) {
        isUserLogin = YES;
        XZDebugLog(@"用户成功登陆");
    } else if (indexPath.row == 8) {
        isUserLogin = NO;
        XZDebugLog(@"用户退出登陆");
    } else if (indexPath.row == 9) {
        [XZRouterManager routerWithModel:[XZRouterModel MessageA_B_C] fromVC:self];
    } else if (indexPath.row == 10) {
        UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
        [[AnimationTool shared] transitionWithType:@"" WithSubtype:@"" ForView:win];
        
        UITabBarController *tabbarVC = (UITabBarController *)win.rootViewController;
        tabbarVC.selectedIndex = 0;
        UINavigationController *selectedNav = tabbarVC.selectedViewController;
        
        UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
        [selectedNav presentViewController:nav1 animated:NO completion:^{
            [nav1 pushViewController:[LoginViewController new] animated:NO];
            UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
            [nav1 presentViewController:nav2 animated:NO completion:^{
                [nav2 pushViewController:[LoginViewController new] animated:NO];
                UIViewController *loginVC = [LoginViewController new];
                [nav2 presentViewController:loginVC animated:NO completion:^{
                    UIViewController *loginVC2 = [LoginViewController new];
                    [loginVC presentViewController:loginVC2 animated:NO completion:^{
                        UIViewController *loginVC3 = [LoginViewController new];
                        [loginVC2 presentViewController:loginVC3 animated:NO completion:^{
                        }];
                    }];
                }];
            }];
        }];
    } else if (indexPath.row == 11) {
        [XZRouterManager routerWithModel:[XZRouterModel HomeA] fromVC:self];
    } else if (indexPath.row == 12) {
//        LoginViewController *loginVC1 = [LoginViewController new];
//        loginVC1.view.backgroundColor = [UIColor redColor];
//        loginVC1.navigationItem.title = @"loginVC1";
////        LoginViewController *loginVC2 = [LoginViewController new];
////        loginVC2.view.backgroundColor = [UIColor blueColor];
////        loginVC2.navigationItem.title = @"loginVC2";
//        
//        [self presentViewController:loginVC1 animated:YES completion:^{
////            [loginVC1 presentViewController:loginVC2 animated:YES completion:nil];
//        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
    
}



@end
