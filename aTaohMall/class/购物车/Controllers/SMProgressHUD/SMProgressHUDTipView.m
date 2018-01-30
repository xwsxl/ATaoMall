//
//  SMProgressHUDTipView.m
//  SMProgressHUD
//
//  Created by OrangeLife on 15/10/12.
//  Copyright (c) 2015年 Shenme Studio. All rights reserved.
//

#import "SMProgressHUDTipView.h"
#import "SMProgressHUDConfigure.h"
#import "SMProgressHUD.h"
#import "UIView+SMAutolayout.h"

@implementation SMProgressHUDTipView
- (instancetype)initWithTip:(NSString *)tip tipType:(SMProgressHUDTipType)type
{
    if (self = [super init])
    {
        [self.layer setCornerRadius:kSMProgressHUDCornerRadius];
        [self setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        [self.layer setShadowOffset:CGSizeMake(2, 2)];
        [self.layer setShadowOpacity:0.2];
        [self setAlpha:0];
        [self.layer setBorderWidth:.2f];
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
        UIImageView *icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        [icon addConstraint:NSLayoutAttributeWidth value:18.5];
        [icon addConstraint:NSLayoutAttributeHeight value:14];
        [icon addConstraint:NSLayoutAttributeCenterX equalTo:self offset:0];
        [icon addConstraint:NSLayoutAttributeTop equalTo:self offset:23];
       
        switch (type)
        {
            case SMProgressHUDTipTypeSucceed:
                [icon setImage:[UIImage imageNamed:@"progresshud.bundle/成功提示"]];
                break;
            case SMProgressHUDTipTypeDone:
                [icon setImage:[UIImage imageNamed:@"progresshud.bundle/done"]];
                break;
            case SMProgressHUDTipTypeError:
                [icon setImage:[UIImage imageNamed:@"progresshud.bundle/error"]];
                break;
            case SMProgressHUDTipTypeWarning:
                [icon setImage:[UIImage imageNamed:@"progresshud.bundle/warning"]];
                break;
        }
        
        UILabel *message = [UILabel new];
        [message setTextColor:[UIColor whiteColor]];
        [message setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:11]];
        [message setNumberOfLines:0];
        [message setLineBreakMode:NSLineBreakByCharWrapping];
        [message setTextAlignment:NSTextAlignmentLeft];
        [message setText:tip];
        [message setPreferredMaxLayoutWidth:kSMProgressHUDContentWidth-20];
        [self addSubview:message];
        
        [message addConstraint:NSLayoutAttributeTop equalTo:icon fromConstraint:NSLayoutAttributeBottom offset:10];
        [message addConstraint:NSLayoutAttributeCenterX equalTo:self offset:0];
        [message layoutIfNeeded];
        
        NSLog(@"==1=fffff==%f",message.frame.size.width);
        
        CGFloat width = message.frame.size.width>60?message.frame.size.width+22:60.f+20;
        
        
        
        [self addConstraint:NSLayoutAttributeWidth value:120];
        [self addConstraint:NSLayoutAttributeHeight value:80];
        
        
        NSLog(@"==2=fffff==%f==%f===%f",width,self.frame.size.height,self.frame.size.width);
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:message attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    }
    return self;
}

- (void)didMoveToSuperview
{
    if (self.superview)
    {
        [self layoutIfNeeded];
    }
}
@end
