//
//  UIColor+Extension.m
//  RouterManager
//
//  Created by 周际航 on 2017/8/14.
//  Copyright © 2017年 周际航. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)ext_random {
    return [UIColor colorWithRed:(arc4random_uniform(100)+155)/255.0 green:(arc4random_uniform(100)+155)/255.0 blue:(arc4random_uniform(100)+155)/255.0 alpha:1];
}

@end
