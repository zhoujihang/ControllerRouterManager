//
//  Home1ViewController.m
//  ControllerRouterManager
//
//  Created by 周际航 on 16/6/12.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "HAViewController.h"
#import "HBViewController.h"

@interface HAViewController ()

@property (nonatomic, weak) UIButton *centerBtn;

@end

@implementation HAViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    [self setUpConstraints];
}
// 创建视图控件
- (void)setUpViews{
    self.navigationItem.title = @"HA";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.titleLabel.font = [UIFont systemFontOfSize:24];
    [btn setTitle:@"push HB" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(centerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.centerBtn = btn;
}
// 设置控件约束关系
- (void)setUpConstraints{
    self.centerBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.centerBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.centerBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:centerX];
    [self.view addConstraint:centerY];
}

- (void)centerBtnClicked{
    HBViewController *vc = [[HBViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
