//
//  FKTabBarController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "FKTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeAViewController.h"
#import "HouseAViewController.h"
#import "OrderAViewController.h"
#import "MessageAViewController.h"
#import "PersonalAViewController.h"

@interface FKTabBarController ()

@end

@implementation FKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:[HomeAViewController new]];
    homeNav.tabBarItem.image = [UIImage imageNamed:@"discover_icon"];
    homeNav.tabBarItem.selectedImage = [UIImage imageNamed:@"discover_icon_select"];
    homeNav.tabBarItem.title = @"首页";
    
    UIViewController *orderNav = [[BaseNavigationController alloc] initWithRootViewController:[OrderAViewController new]];
    orderNav.tabBarItem.image = [UIImage imageNamed:@"discover_order"];
    orderNav.tabBarItem.selectedImage = [UIImage imageNamed:@"discover_order_select"];
    orderNav.tabBarItem.title = @"订单";
    
    UIViewController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:[MessageAViewController new]];
    messageNav.tabBarItem.image = [UIImage imageNamed:@"discover_message"];
    messageNav.tabBarItem.selectedImage = [UIImage imageNamed:@"discover_messag_select"];
    messageNav.tabBarItem.title = @"消息";
    
    UIViewController *personalNav = [[BaseNavigationController alloc] initWithRootViewController:[PersonalAViewController new]];
    personalNav.tabBarItem.image = [UIImage imageNamed:@"discover_me"];
    personalNav.tabBarItem.selectedImage = [UIImage imageNamed:@"discover_me_select"];
    personalNav.tabBarItem.title = @"房客";
    
    [self setViewControllers:@[homeNav, orderNav, messageNav, personalNav]];
}


@end
