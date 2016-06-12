//
//  HomeViewController.m
//  ControllerRouterManager
//
//  Created by 周际航 on 16/6/12.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "HomeViewController.h"
#import "RouterManager.h"
#import "StoredKeyManager.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *toggleLoginBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
}
// 创建视图控件
- (void)setUpViews{
    self.navigationItem.title = @"home";
}

- (IBAction)toHA:(id)sender {
    RouterInfoModel *model = [RouterInfoModel modelToHA];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}
- (IBAction)toHB:(id)sender {
    RouterInfoModel *model = [RouterInfoModel modelToHB];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}
- (IBAction)toWeb:(id)sender {
    RouterInfoModel *model = [RouterInfoModel modelToWeb];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}
- (IBAction)toOA:(id)sender {
    RouterInfoModel *model = [RouterInfoModel modelToOA];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}
- (IBAction)Root2OA:(id)sender {
    RouterInfoModel *model = [RouterInfoModel modelRoot2OA];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}
- (IBAction)Root2OA2OB:(id)sender {
    RouterInfoModel *model = [RouterInfoModel modelRoot2OA2OB];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}
- (IBAction)Root2HA2HB2Web:(id)sender {
    RouterInfoModel *model = [RouterInfoModel modelRoot2HA2HB2Web];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}
- (IBAction)Root2OA2OB2Web:(id)sender {
    RouterInfoModel *model = [RouterInfoModel modelRoot2OA2OB2Web];
    [RouterManager routerWithRouterInfoModel:model fromViewController:self];
}

- (IBAction)toggleLogin:(id)sender {
    StoredKeyManager *sharedManager = [StoredKeyManager sharedManager];
    sharedManager.login = !sharedManager.isLogin;
    self.toggleLoginBtn.title = sharedManager.isLogin ? @"logout" : @"login";
    
}


@end
