//
//  MessageAViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "MessageAViewController.h"

@interface MessageAViewController ()

@end

@implementation MessageAViewController

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
    // Do any additional setup after loading the view.
}


- (NSString *)overload_cellTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [super overload_cellTextForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        text = @"MessageA_B_C";
    } else if (indexPath.row == 1) {
        text = @"present 后3s 连续dismiss";
    } else if (indexPath.row == 2) {
        text = @"Login_PersoanlA";
    } else if (indexPath.row == 3) {
        text = @"present && dismiss";
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [XZRouterManager routerWithModel:[XZRouterModel MessageA_B_C] fromVC:self];
    } else if (indexPath.row == 1) {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        __weak typeof (self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *presentedVC = weakSelf.presentedViewController;
            presentedVC = weakSelf.presentedViewController;
            if (presentedVC) {
                XZDebugLog(@"存在 presentedVC1");
                [presentedVC dismissViewControllerAnimated:NO completion:^{
                    XZDebugLog(@"1");
                }];
            }
            presentedVC = weakSelf.presentedViewController;
            if (presentedVC && !presentedVC.isBeingDismissed) {
                XZDebugLog(@"存在 presentedVC2");
                [presentedVC dismissViewControllerAnimated:NO completion:^{
                    XZDebugLog(@"2");
                }];
            }
        });
    } else if (indexPath.row == 2) {
        [XZRouterManager routerWithModel:[XZRouterModel Login_PersonalA] fromVC:self];
    } else if (indexPath.row == 3) {
        [self presentViewController:[UIViewController new] animated:YES completion:^{
            // GCD 针对iOS8
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.presentedViewController dismissViewControllerAnimated:NO completion:^{
                    XZDebugLog(@"present && dismiss");
                }];
            });
        }];
    }
    
}

@end
