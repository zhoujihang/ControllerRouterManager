//
//  AnimationTool.h
//  RouterManager
//
//  Created by 周际航 on 2017/8/22.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationTool : NSObject

+ (instancetype)shared;

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view;

@end
