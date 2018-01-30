//
//  CalendarMonthFooterView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/7/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CalendarMonthFooterView.h"

@implementation CalendarMonthFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup
{
        UIImageView *Fenge = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.bounds.size.width, 1)];
        Fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
        [self addSubview:Fenge];
    
}
@end
