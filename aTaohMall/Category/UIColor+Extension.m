//
//  UIColor+Extension.m
//  YFQChildPro
//
//  Created by ab on 2017/4/12.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

#define RANDOMCOLOR arc4random() % 256 / 255.0

+ (instancetype)colorWithRandom
{
    return [UIColor colorWithRed:RANDOMCOLOR green:RANDOMCOLOR blue:RANDOMCOLOR alpha:0.5];
}


@end
