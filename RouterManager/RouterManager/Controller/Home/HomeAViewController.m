//
//  HomeAViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "HomeAViewController.h"
#import "XZRouterManager.h"
#import "HomeBViewController.h"
@interface HomeAViewController ()

@end

@implementation HomeAViewController

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
        text = @"Home_A_B_C";
    } else if (indexPath.row == 1) {
        text = @"Home_A_B_C[缺url]";
    } else if (indexPath.row == 2) {
        text = @"HomeB router";
    } else if (indexPath.row == 3) {
        text = @"HomeB";
    } else if (indexPath.row == 4) {
        text = @"Login";
    } else if (indexPath.row == 5) {
        text = @"测试 self.presentedVC dimisss 效果";
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [XZRouterManager routerWithModel:[XZRouterModel HomeA_B_C] fromVC:self];
    } else if (indexPath.row == 1) {
        XZRouterModel *model = [XZRouterModel HomeA_B_C];
        [model.list.lastObject setParam:nil];
        [XZRouterManager routerWithModel:model fromVC:self];
    } else if (indexPath.row == 2) {
        [XZRouterManager routerWithModel:[XZRouterModel OrderC] fromVC:self];
    } else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[HomeBViewController new] animated:YES];
    } else if (indexPath.row == 4) {
        [XZRouterManager routerWithModel:[XZRouterModel Login] fromVC:self];
    } else if (indexPath.row == 5) {
        LoginViewController *loginVC1 = [LoginViewController new];
        loginVC1.view.backgroundColor = [UIColor redColor];
        loginVC1.navigationItem.title = @"loginVC1";
        LoginViewController *loginVC2 = [LoginViewController new];
        loginVC2.view.backgroundColor = [UIColor blueColor];
        loginVC2.navigationItem.title = @"loginVC2";

        [self presentViewController:loginVC1 animated:YES completion:^{
            [loginVC1 presentViewController:loginVC2 animated:YES completion:nil];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        });
    }
    
}


@end
