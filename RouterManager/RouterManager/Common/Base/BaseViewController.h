//
//  BaseViewController.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZRouterManager.h"

@interface BaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, XZRoutableProtocol>

@property (nonatomic, strong, readonly, nullable) UITableView *base_tableView;

- (NSString *_Nonnull)overload_cellTextForRowAtIndexPath:(NSIndexPath *_Nonnull)indexPath NS_REQUIRES_SUPER;
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *_Nonnull)indexPath;

@end
