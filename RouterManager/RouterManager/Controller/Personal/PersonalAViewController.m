//
//  PersonalAViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "PersonalAViewController.h"
#import "XZTabBarManager.h"
#import "LoginViewController.h"

@interface PersonalAViewController ()

@property (nonatomic, strong, nullable) UIAlertView *alertView;

@end

@implementation PersonalAViewController

+ (BOOL)router_enable {
    return YES;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.alertView dismissWithClickedButtonIndex:0 animated:NO];
    self.alertView = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)overload_cellTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [super overload_cellTextForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        text = @"switch to FD";
    } else if (indexPath.row == 1) {
        text = @"switch to FK";
    } else if (indexPath.row == 2) {
        text = @"PersonalB_MessageA_B_C_HomeA_B_C";
    } else if (indexPath.row == 3) {
        text = @"PersonalB_MessageA_B_C_HomeA_B_C_Clear";
    } else if (indexPath.row == 4) {
        text = @"Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login";
    } else if (indexPath.row == 5) {
        text = @"UIAlertView + Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login";
    } else if (indexPath.row == 6) {
        text = @"UIAlertController + Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login";
    } else if (indexPath.row == 7) {
        text = @"PresentLogin + Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login";
    } else if (indexPath.row == 8) {
        text = @"PersonalB_MessageA_B_C_HomeA_C";
    } else if (indexPath.row == 9) {
        text = @"PresentLogin + PersonalB_MessageA_B_C_HomeA_C";
    } else if (indexPath.row == 10) {
        text = @"PersonalB_MessageAFD_Login_C_HomeAFD_C";
    } else if (indexPath.row == 11) {
        text = @"PersonalB";
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [[XZTabBarManager shared] switchToFD];
        XZTabBarManager.shared.tabBarVC_FD.selectedIndex = XZTabBarManager.shared.tabBarVC_FD.childViewControllers.count - 1;
    } else if (indexPath.row == 1) {
        [[XZTabBarManager shared] switchToFK];
        XZTabBarManager.shared.tabBarVC_FK.selectedIndex = XZTabBarManager.shared.tabBarVC_FK.childViewControllers.count - 1;
    } else if (indexPath.row == 2) {
        [XZRouterManager routerWithModel:[XZRouterModel PersonalB_MessageA_B_C_HomeA_B_C] fromVC:self];
    } else if (indexPath.row == 3) {
        [XZRouterManager routerWithModel:[XZRouterModel PersonalB_MessageA_B_C_HomeA_B_C_Clear] fromVC:self];
    } else if (indexPath.row == 4) {
        [XZRouterManager routerWithModel:[XZRouterModel Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login] fromVC:self];
    } else if (indexPath.row == 5) {
        [self showAlert1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XZRouterManager routerWithModel:[XZRouterModel Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login] fromVC:self];
        });
    } else if (indexPath.row == 6) {
        [self showAlert2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XZRouterManager routerWithModel:[XZRouterModel Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login] fromVC:self];
        });
    } else if (indexPath.row == 7) {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XZRouterManager routerWithModel:[XZRouterModel Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login] fromVC:self];
        });
    } else if (indexPath.row == 8) {
        [XZRouterManager routerWithModel:[XZRouterModel PersonalB_MessageA_B_C_HomeA_C] fromVC:self];
    } else if (indexPath.row == 9) {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XZRouterManager routerWithModel:[XZRouterModel PersonalB_MessageA_B_C_HomeA_C] fromVC:self];
        });
    } else if (indexPath.row == 10) {
        [XZRouterManager routerWithModel:[XZRouterModel PersonalB_MessageAFK_Login_C_HomeAFK_C] fromVC:self];
    } else if (indexPath.row == 11) {
        XZRouterNodeModel *node = [XZRouterNodeModel model:@"PersonalB" param:nil];
        [XZRouterManager routerWithModel:[XZRouterModel model:@[node]] fromVC:self];
    }
}

- (void)showAlert1 {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UIAlertView" message:@"测试alert出现时路由效果" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alertView show];
    self.alertView = alertView;
}
- (void)showAlert2 {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"UIAlertController" message:@"测试alert出现时路由效果" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
