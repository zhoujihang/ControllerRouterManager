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
    }
    
}


@end
