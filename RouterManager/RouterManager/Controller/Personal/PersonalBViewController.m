//
//  PersonalBViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "PersonalBViewController.h"
#import "XZTabBarManager.h"

@interface PersonalBViewController ()

@end

@implementation PersonalBViewController

+ (BOOL)router_enable {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)overload_cellTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [super overload_cellTextForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        text = @"PersonalC";
    } else if (indexPath.row == 1) {
        text = @"switch to FD";
    } else if (indexPath.row == 2) {
        text = @"switch to FK";
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        XZRouterNodeModel *node = [XZRouterNodeModel model:@"PersonalC" param:nil];
        [XZRouterManager routerWithModel:[XZRouterModel model:@[node]] fromVC:self];
    } else if (indexPath.row == 1) {
        [[XZTabBarManager shared] switchToFD];
        XZTabBarManager.shared.tabBarVC_FD.selectedIndex = XZTabBarManager.shared.tabBarVC_FD.childViewControllers.count - 1;
    } else if (indexPath.row == 2) {
        [[XZTabBarManager shared] switchToFK];
        XZTabBarManager.shared.tabBarVC_FK.selectedIndex = XZTabBarManager.shared.tabBarVC_FK.childViewControllers.count - 1;
    }
    
}

@end
