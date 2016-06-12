//
//  RouterInfoModel.h
//  Ayibang
//
//  Created by 周际航 on 16/2/16.
//  Copyright © 2016年 ayibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
@class RouterJumpNodeModel;

@interface RouterInfoModel : NSObject
// 跳转对应的节点数组
@property (nonatomic, strong) NSArray *jumpNodeArray;

+ (instancetype)modelToHA;
+ (instancetype)modelToHB;
+ (instancetype)modelToWeb;
+ (instancetype)modelToOA;
+ (instancetype)modelRoot2OA;
+ (instancetype)modelRoot2OA2OB;
+ (instancetype)modelRoot2HA2HB2Web;
+ (instancetype)modelRoot2OA2OB2Web;

@end


@interface RouterJumpNodeModel : NSObject
// 路由协议名称
@property (nonatomic, copy) NSString *path;
// 协议对应的参数
@property (nonatomic, strong) NSDictionary *parameters;

// 路由协议名称对应的跳转类
@property (nonatomic, strong, readonly) Class pathClass;

@end