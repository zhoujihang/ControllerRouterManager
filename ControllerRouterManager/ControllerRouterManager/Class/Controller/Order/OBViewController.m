//
//  Order2ViewController.m
//  ControllerRouterManager
//
//  Created by 周际航 on 16/6/12.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "OBViewController.h"

@interface OBViewController ()

@end

@implementation OBViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"OB";
}


@end
