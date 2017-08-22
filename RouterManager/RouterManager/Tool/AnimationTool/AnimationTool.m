//
//  AnimationTool.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/22.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "AnimationTool.h"

@interface AnimationTool ()



@end

@implementation AnimationTool

+ (instancetype)shared {
    static AnimationTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 2;
    
    //设置运动type
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}


@end
