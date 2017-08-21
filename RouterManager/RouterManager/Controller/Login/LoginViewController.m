//
//  LoginViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/15.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

+ (BOOL)router_enable {
    return YES;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
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
    }
    
}



@end
