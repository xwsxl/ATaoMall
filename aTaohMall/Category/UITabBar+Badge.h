//
//  UITabBar+Badge.h
//  YFQChildPro
//
//  Created by ab on 2017/4/13.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)


/**
 Description 显示消息小红点

 @param index <#index description#>
 */
- (void)showBadgeOnItemIndex:(int)index;

/**
 Description 隐藏消息小红点

 @param index <#index description#>
 */
- (void)hideBadgeOnItemIndex:(int)index;


@end
