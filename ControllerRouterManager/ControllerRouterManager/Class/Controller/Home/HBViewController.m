//
//  Home2ViewController.m
//  ControllerRouterManager
//
//  Created by 周际航 on 16/6/12.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "HBViewController.h"
#import "StoredKeyManager.h"

@interface HBViewController ()

@property (nonatomic, weak) UILabel *centerLbl;

@property (nonatomic, weak) UIButton *centerBtn;

@end

@implementation HBViewController

// 必须当前处于登录状态才能通过协议跳转到此页面
+ (BOOL)isNeedLogin{
    return YES;
}
+ (BOOL)validateRoutableParameters:(NSDictionary *)dic{
    NSString *pID = dic[@"pID"];
    NSString *pName = dic[@"pName"];
    
    if ([pID isKindOfClass:[NSString class]] && pID.length>0) {
        if ([pName isKindOfClass:[NSString class]] && pName.length>0) {
            return YES;
        }
    }
    return NO;
}
// 必须传递2个必要参数 才能通过协议跳转到此页面
- (instancetype)initWithRoutableParameters:(NSDictionary *)dic{
    if (![[self class] validateRoutableParameters:dic]) {return nil;}
    
    NSString *pID = dic[@"pID"];
    NSString *pName = dic[@"pName"];
    
    HBViewController *vc = [[HBViewController alloc] init];
    vc.projectID = pID;
    vc.projectName = pName;
    return vc;
}
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
    [self setUpData];
}
// 创建视图控件
- (void)setUpViews{
    self.navigationItem.title = @"HB";
    
    UILabel *centerLbl = [[UILabel alloc] init];
    [self.view addSubview:centerLbl];
    self.centerLbl = centerLbl;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.titleLabel.font = [UIFont systemFontOfSize:24];
    [btn setTitle:@"pop to root" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(centerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.centerBtn = btn;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump to OB2Web" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClicked)];
}
// 设置控件约束关系
- (void)setUpConstraints{
    
    self.centerLbl.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerLblX = [NSLayoutConstraint constraintWithItem:self.centerLbl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerLblY = [NSLayoutConstraint constraintWithItem:self.centerLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:-50];
    [self.view addConstraint:centerLblX];
    [self.view addConstraint:centerLblY];
    
    
    
    self.centerBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerBtnX = [NSLayoutConstraint constraintWithItem:self.centerBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerBtnY = [NSLayoutConstraint constraintWithItem:self.centerBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:centerBtnX];
    [self.view addConstraint:centerBtnY];
}
// 设置初始数据
- (void)setUpData{
    NSString *text = [NSString stringWithFormat:@"login:%d  id:%@  name:%@",[StoredKeyManager sharedManager].isLogin,self.projectID,self.projectName];
    
    self.centerLbl.text = text;
}
- (void)centerBtnClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)rightBarBtnClicked{
    RouterInfoModel *model = [RouterInfoModel modelRoot2OA2OB2Web];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}

@end
