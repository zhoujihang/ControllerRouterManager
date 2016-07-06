//
//  WebViewController.m
//  ControllerRouterManager
//
//  Created by 周际航 on 16/6/12.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation WebViewController

+ (BOOL)validateRoutableParameters:(NSDictionary *)dic{
    NSString *url = dic[@"url"];
    
    if ([url isKindOfClass:[NSString class]] && url.length>0) {
        return YES;
    }
    return NO;
}
// 必须传递2个必要参数 才能通过协议跳转到此页面
- (instancetype)initWithRoutableParameters:(NSDictionary *)dic{
    if (![[self class] validateRoutableParameters:dic]) {return nil;}
    
    NSString *urlString = dic[@"url"];
    NSString *title = dic[@"title"];
    
    WebViewController *vc = [[WebViewController alloc] init];
    vc.urlString = urlString;
    vc.urlTitle = title;
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
    self.navigationItem.title = self.urlTitle;
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
}
// 设置控件约束关系
- (void)setUpConstraints{
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leftCons = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *rightCons = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *bottomCons = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraint:leftCons];
    [self.view addConstraint:topCons];
    [self.view addConstraint:rightCons];
    [self.view addConstraint:bottomCons];
}
// 设置初始数据
- (void)setUpData{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]];
    [self.webView loadRequest:req];
}



@end
