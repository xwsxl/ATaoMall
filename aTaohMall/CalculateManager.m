//
//  CalculateManager.m
//  aTaohMall
//
//  Created by DingDing on 2017/9/1.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CalculateManager.h"

@implementation CalculateManager
+ (CGFloat)calculateWidthWithNum:(NSInteger)num {
    // 750x1334
    CGFloat scale = num / 375.0;
    CGFloat width = kScreen_Width * scale;
    return width;
}

+ (CGFloat)calculateHeightWithNum:(NSInteger)num {
    CGFloat scale = num / 667.0;
    CGFloat heigth = kScreen_Height * scale;
    if (kScreenHeight==812.0) {
        heigth=667*scale;
    }
    return heigth;
}
@end
