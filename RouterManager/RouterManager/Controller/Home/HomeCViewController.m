//
//  HomeCViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "HomeCViewController.h"
#import <WebKit/WebKit.h>

@interface HomeCViewController ()

@property (nonatomic, strong, nullable) WKWebView *webView;
@property (nonatomic, copy, nullable) NSString *url;

@end

@implementation HomeCViewController

+ (BOOL)router_enable {
    return YES;
}

+ (BOOL)router_validateRouterParameters:(NSDictionary *)param {
    if (!([param[@"url"] isKindOfClass:[NSString class]] && [param[@"url"] length] > 0)) {return NO;}
    
    return YES;
}
- (instancetype)initWithRouterParameters:(NSDictionary *)param {
    if (self = [super initWithRouterParameters:param]) {
        self.url = param[@"url"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupFrame];
    [self setupData];
}

- (void)setupView {
    self.webView = [[WKWebView alloc] init];
    [self.view addSubview:self.webView];
}
- (void)setupFrame {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.webView.frame = CGRectMake(0, screenSize.height*0.5, screenSize.width, screenSize.height*0.5);
    self.base_tableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height*0.5);
}
- (void)setupData {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}

- (NSString *)overload_cellTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [super overload_cellTextForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        text = @"HouseA_B_C";
    } else if (indexPath.row == 1) {
        
    }
    
    return text;
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [XZRouterManager routerWithModel:[XZRouterModel HouseA_B_C] fromVC:self];
    } else if (indexPath.row == 1) {
        
    }
    
}

@end
