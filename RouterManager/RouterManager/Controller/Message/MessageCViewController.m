//
//  MessageCViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "MessageCViewController.h"
#import "LoginViewController.h"
@interface MessageCViewController ()

@property (nonatomic, strong, nullable) UIAlertView *alertView;

@end

@implementation MessageCViewController

+ (BOOL)router_enable {
    return YES;
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
        text = @"UIAlertView 2s后 Login";
    } else if (indexPath.row == 1) {
        text = @"UIAlertController 2s后 Login";
    } else if (indexPath.row == 2) {
        text = @"UIAlertController 2s后 LoginX5";
    } else if (indexPath.row == 3) {
        text = @"LoginX5";
    } else if (indexPath.row == 4) {
        text = @"Login_PersonalA_OrderC";
    } else if (indexPath.row == 5) {
        text = @"OrderB_Login_Login_OrderC_Login";
    } else if (indexPath.row == 6) {
        text = @"HouseA_B_C";
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self showAlert1];
        __weak typeof (self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XZRouterManager routerWithModel:[XZRouterModel Login] fromVC:weakSelf];
        });
    } else if (indexPath.row == 1) {
        [self showAlert2];
        __weak typeof (self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XZRouterManager routerWithModel:[XZRouterModel Login] fromVC:weakSelf];
        });
    } else if (indexPath.row == 2) {
        [self showAlert2];
        __weak typeof (self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XZRouterManager routerWithModel:[XZRouterModel LoginX5] fromVC:weakSelf];
        });
    } else if (indexPath.row == 3) {
        [XZRouterManager routerWithModel:[XZRouterModel LoginX5] fromVC:self];
    } else if (indexPath.row == 4) {
        [XZRouterManager routerWithModel:[XZRouterModel Login_PersonalA_OrderC] fromVC:self];
    } else if (indexPath.row == 5) {
        [XZRouterManager routerWithModel:[XZRouterModel OrderB_Login_Login_OrderC_Login] fromVC:self];
    } else if (indexPath.row == 6) {
        [XZRouterManager routerWithModel:[XZRouterModel HouseA_B_C] fromVC:self];
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
