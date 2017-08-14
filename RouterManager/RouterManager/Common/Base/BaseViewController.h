//
//  BaseViewController.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (NSString *)overload_cellTextForRowAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;
- (void)overload_cellDidSelectAtIndexPath:(NSIndexPath *)indexPath;

@end
