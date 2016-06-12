//
//  RouterInfoModel.m
//  Ayibang
//
//  Created by 周际航 on 16/2/16.
//  Copyright © 2016年 ayibang. All rights reserved.
//

#import "RouterInfoModel.h"
#import "RouterRegisterManager.h"

@implementation RouterInfoModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"jumpNodeArray" : @"jump"
             };
}

+ (NSDictionary *)objectClassInArray{
    return @{
             @"jumpNodeArray" : [RouterJumpNodeModel class]
             };
}

+ (instancetype)modelToHA{
    return [self modelForFileName:@"toHA.json"];
}
+ (instancetype)modelToHB{
    return [self modelForFileName:@"toHB.json"];
}
+ (instancetype)modelToWeb{
    return [self modelForFileName:@"toWeb.json"];
}
+ (instancetype)modelToOA{
    return [self modelForFileName:@"toOA.json"];
}
+ (instancetype)modelRoot2OA{
    return [self modelForFileName:@"Root2OA.json"];
}
+ (instancetype)modelRoot2OA2OB{
    return [self modelForFileName:@"Root2OA2OB.json"];
}
+ (instancetype)modelRoot2HA2HB2Web{
    return [self modelForFileName:@"Root2HA2HB2Web.json"];
}
+ (instancetype)modelRoot2OA2OB2Web{
    return [self modelForFileName:@"Root2OA2OB2Web.json"];
}
+ (instancetype)modelForFileName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    RouterInfoModel *model = [RouterInfoModel mj_objectWithKeyValues:jsonString];
    return model;
}

@end


@implementation RouterJumpNodeModel

- (void)setPath:(NSString *)path{
    _path = [path copy];
    
    RouterRegisterManager *registerManager = [RouterRegisterManager sharedManager];
    if (path.length > 0) {
        Class pathClass = registerManager.routerMDic[path];
        _pathClass = pathClass;
    }
    
}

@end
