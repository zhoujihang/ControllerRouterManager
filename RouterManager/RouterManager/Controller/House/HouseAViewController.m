//
//  HouseAViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "HouseAViewController.h"
#import "LoginViewController.h"
#import "AnimationTool.h"
#import "HomeCViewController.h"
@interface HouseAViewController ()
@property (nonatomic, strong, nullable) UIViewController *loginVC;
@property (nonatomic, strong, nullable) UIViewController *homeCVC;
@end

@implementation HouseAViewController

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
        text = @"transition present";
    } else if (indexPath.row == 1) {
        text = @"transition tabbar";
    } else if (indexPath.row == 2) {
        text = @"transition push animated";
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self test0];
    } else if (indexPath.row == 1) {
        [self test1];
    } else if (indexPath.row == 2) {
        [self test2];
    }
    
}

- (void)test0 {
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    [[AnimationTool shared] transitionWithType:@"" WithSubtype:@"" ForView:win];

    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
    [nav1 pushViewController:[LoginViewController new] animated:NO];
    [self.navigationController presentViewController:nav1 animated:NO completion:^{
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
}

- (void)test1 {
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    [[AnimationTool shared] transitionWithType:@"" WithSubtype:@"" ForView:win];
    
    [self.navigationController pushViewController:[LoginViewController new] animated:NO];
    
    UITabBarController *tabbarVC = (UITabBarController *)win.rootViewController;
    tabbarVC.selectedIndex = 3;
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
}

- (void)test2 {
    [self private_startPushTransition];
    
    [self.navigationController pushViewController:[LoginViewController new] animated:NO];
}


- (void)private_startPushTransition {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.7;
    
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.view.window.layer addAnimation:animation forKey:@"animation"];
}
- (void)private_startPresentTransition {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.7;
    
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.view.window.layer addAnimation:animation forKey:@"animation"];
}

@end
