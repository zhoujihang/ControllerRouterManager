//
//  BaseViewController.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong, nullable) UITableView *base_tableView;

@end

@implementation BaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [self base_setupView];
    [self base_setupFrame];
}

- (void)base_setupView {
    self.navigationItem.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor ext_random];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.base_tableView = [[UITableView alloc] init];
    self.base_tableView.backgroundColor = [UIColor clearColor];
    self.base_tableView.delegate = self;
    self.base_tableView.dataSource = self;
    self.base_tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.base_tableView.contentOffset = CGPointMake(-64, 0);
    [self.base_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.base_tableView];
}

- (void)base_setupFrame {
    self.base_tableView.frame = [UIScreen mainScreen].bounds;
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self overload_cellTextForRowAtIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self overload_cellDidSelectAtIndexPath:indexPath];
}


- (NSString *)overload_cellTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld - %ld", indexPath.section, indexPath.row];
}
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
