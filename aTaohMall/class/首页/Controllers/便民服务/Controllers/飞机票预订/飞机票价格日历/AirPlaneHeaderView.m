//
//  AirPlaneHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneHeaderView.h"
#import "Color.h"

#define CATDayLabelWidth  40.0f
#define CATDayLabelHeight 20.0f

@implementation AirPlaneHeaderView

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
    
    self.clipsToBounds = YES;
    
    //月份
    UILabel *masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width-30, 30.f)];
    [masterLabel setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:246/255.0 alpha:1.0]];
    [masterLabel setTextAlignment:NSTextAlignmentCenter];
    [masterLabel setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:14.0f]];
    self.masterLabel = masterLabel;
    self.masterLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self addSubview:self.masterLabel];
    
   
}



@end
