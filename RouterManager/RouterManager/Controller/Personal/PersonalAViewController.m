//
//  PersonalAViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "PersonalAViewController.h"
#import "XZTabBarManager.h"

@interface PersonalAViewController ()

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
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [[XZTabBarManager shared] switchToFD];
    } else if (indexPath.row == 1) {
        [[XZTabBarManager shared] switchToFK];
    } else if (indexPath.row == 2) {
        [XZRouterManager routerWithModel:[XZRouterModel PersonalB_MessageA_B_C_HomeA_B_C] fromVC:self];
    }
    
}

@end
