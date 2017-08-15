//
//  XZRouterModel.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XZRouterNodeModel;

@interface XZRouterModel : NSObject

@property (nonatomic, copy, nullable) NSArray<XZRouterNodeModel *> *list;

+ (XZRouterModel * _Nonnull)HomeA_B_C;
+ (XZRouterModel * _Nonnull)HouseA_B_C;
+ (XZRouterModel * _Nonnull)MessageA_B_C;
+ (XZRouterModel * _Nonnull)OrderC;
+ (XZRouterModel * _Nonnull)OrderC_PersonalA_B_C;
+ (XZRouterModel * _Nonnull)OrderB_Login_Login_OrderC_Login;
+ (XZRouterModel * _Nonnull)Login;
+ (XZRouterModel * _Nonnull)LoginX5;
+ (XZRouterModel * _Nonnull)Login_PersonalA_OrderC;

@end

@interface XZRouterNodeModel : NSObject

@property (nonatomic, copy, nullable) NSString *path;
@property (nonatomic, copy, nullable) NSDictionary *param;

@end
