//
//  HomeBViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "HomeBViewController.h"

@interface HomeBViewController ()

@property (nonatomic, strong, nullable) UIAlertView *alertView;

@end

@implementation HomeBViewController

+ (BOOL)router_enable {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.alertView dismissWithClickedButtonIndex:0 animated:NO];
    self.alertView = nil;
}

- (NSString *)overload_cellTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [super overload_cellTextForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        text = @"HomeA";
    } else if (indexPath.row == 1) {
        text = @"HouseA";
    } else if (indexPath.row == 2) {
        text = @"alertVC HouseA";
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [XZRouterManager routerWithModel:[XZRouterModel HomeA] fromVC:self];
    } else if (indexPath.row == 1) {
        [XZRouterManager routerWithModel:[XZRouterModel HouseA] fromVC:self];
    } else if (indexPath.row == 2) {
        [self showAlert2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XZRouterManager routerWithModel:[XZRouterModel HouseA] fromVC:self];
        });
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
