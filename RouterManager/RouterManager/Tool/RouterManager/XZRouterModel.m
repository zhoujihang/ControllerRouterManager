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

+ (XZRouterModel *)fakeModel:(NSString *)filePath {
    NSString *path = [[NSBundle mainBundle] pathForResource:filePath ofType:@".json"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
    return [XZRouterModel objectWithKeyValues:dic];
}

@end

@implementation XZRouterNodeModel

@end
