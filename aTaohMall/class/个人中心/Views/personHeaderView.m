//
//  personHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/11.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "personHeaderView.h"

@implementation personHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIViewController*)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



@end
