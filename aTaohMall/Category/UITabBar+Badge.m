//
//  UITabBar+Badge.m
//  YFQChildPro
//
//  Created by ab on 2017/4/13.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import "UITabBar+Badge.h"

@implementation UITabBar (Badge)


/**
 Description 显示消息小红点

 @param index Tab下标
 */
- (void)showBadgeOnItemIndex:(int)index {
    
    [self removeBadgeOnItemIndex:index];
    
    UIView *badgeView = [[UIView alloc] init];
    badgeView.tag = 888+index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    float precentX = (index + 0.6)/4;
    CGFloat x = ceilf(precentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:badgeView];
}


/**
 Description 隐藏小红点

 @param index <#index description#>
 */
- (void)hideBadgeOnItemIndex:(int)index {
    
    [self removeBadgeOnItemIndex:index];
}

/**
 Description 移除消息小红点

 @param index 下标
 */
- (void)removeBadgeOnItemIndex:(int)index {
    
    for (UIView *subview in self.subviews) {
        if (subview.tag == 888+index) {
            [subview removeFromSuperview];
        }
    }
}

@end
