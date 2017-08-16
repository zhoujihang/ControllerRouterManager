//
//  XZRouterModel.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "XZRouterModel.h"
#import <MJExtension/MJExtension.h>

@implementation XZRouterModel

+ (NSDictionary *)objectClassInArray {
    return @{
             @"list" : [XZRouterNodeModel class]
             };
}

+ (instancetype)model:(NSArray *)nodeList {
    XZRouterModel *model = [[XZRouterModel alloc] init];
    model.list = nodeList;
    return model;
}

#warning "fake model"
+ (XZRouterModel *)HomeA_B_C {
    return [self fakeModel:@"HomeA_B_C"];
}
+ (XZRouterModel *)HouseA_B_C {
    return [self fakeModel:@"HouseA_B_C"];
}
+ (XZRouterModel *)MessageA_B_C {
    return [self fakeModel:@"MessageA_B_C"];
}
+ (XZRouterModel *)OrderC {
    return [self fakeModel:@"OrderC"];
}
+ (XZRouterModel *)OrderC_PersonalA_B_C {
    return [self fakeModel:@"OrderC_PersonalA_B_C"];
}
+ (XZRouterModel *)OrderB_Login_Login_OrderC_Login {
    return [self fakeModel:@"OrderB_Login_Login_OrderC_Login"];
}
+ (XZRouterModel *)Login {
    return [self fakeModel:@"Login"];
}
+ (XZRouterModel *)LoginX5 {
    return [self fakeModel:@"LoginX5"];
}
+ (XZRouterModel *)Login_PersonalA_OrderC {
    return [self fakeModel:@"Login_PersonalA_OrderC"];
}
+ (XZRouterModel *)PersonalB_MessageA_B_C_HomeA_B_C {
    return [self fakeModel:@"PersonalB_MessageA_B_C_HomeA_B_C"];
}
+ (XZRouterModel *)PersonalB_MessageA_B_C_HomeA_B_C_Clear {
    return [self fakeModel:@"PersonalB_MessageA_B_C_HomeA_B_C_Clear"];
}
+ (XZRouterModel *)Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login {
    return [self fakeModel:@"Login_PersonalB_Login_MessageA_C_HomeA_Login_C_Login"];
}
+ (XZRouterModel *)PersonalB_MessageA_B_C_HomeA_C {
    return [self fakeModel:@"PersonalB_MessageA_B_C_HomeA_C"];
}
+ (XZRouterModel *)PersonalB_MessageAFD_Login_C_HomeAFD_C {
    return [self fakeModel:@"PersonalB_MessageAFD_Login_C_HomeAFD_C"];
}
+ (XZRouterModel *)fakeModel:(NSString *)filePath {
    NSString *path = [[NSBundle mainBundle] pathForResource:filePath ofType:@".json"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
    return [XZRouterModel objectWithKeyValues:dic];
}

@end

@implementation XZRouterNodeModel

+ (instancetype)model:(NSString *)path param:(NSDictionary *)param {
    XZRouterNodeModel *model = [[XZRouterNodeModel alloc] init];
    model.path = path;
    model.param = param;
    return model;
}

@end

@implementation XZRouterRootNodeInfoModel

@end
