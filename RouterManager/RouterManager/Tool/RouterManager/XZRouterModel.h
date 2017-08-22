//
//  XZRouterModel.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XZRouterNodeModel;
@class XZRouterRootNodeInfoModel;

FOUNDATION_EXTERN NSString *const kRouterTargetTab_FK;
FOUNDATION_EXTERN NSString *const kRouterTargetTab_FD;
FOUNDATION_EXTERN NSString *const kRouterTargetTab_NOW;

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
+ (XZRouterModel * _Nonnull)PersonalB_MessageA_B_C_HomeA_B_C;
+ (XZRouterModel * _Nonnull)PersonalB_MessageA_B_C_HomeA_B_C_Clear;
+ (XZRouterModel * _Nonnull)Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login;
+ (XZRouterModel * _Nonnull)PersonalB_MessageA_B_C_HomeA_C;
+ (XZRouterModel * _Nonnull)PersonalB_MessageAFK_Login_C_HomeAFK_C;

+ (instancetype _Nonnull)model:(NSArray *_Nonnull)nodeList;
@end

@interface XZRouterNodeModel : NSObject

@property (nonatomic, copy, nullable) NSString *path;
@property (nonatomic, copy, nullable) NSDictionary *param;
@property (nonatomic, strong, nullable) XZRouterRootNodeInfoModel *rootInfo;

+ (instancetype _Nonnull)model:(NSString *_Nonnull)path param:(NSDictionary *_Nullable)param;
@end

@interface XZRouterRootNodeInfoModel : NSObject     // 跳转根节点的额外逻辑

@property (nonatomic, assign) BOOL isSaveHistory;         // 切换到新的根节点前，是否保留当前根节点拥有的历史页面，默认NO
@property (nonatomic, copy, nullable) NSString *targetTab;  // 新的根节点所属的 tabBar 名称

@end
