//
//  ABButton.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ABButton.h"

#import "UIView+Extension.h"


#define ABColor(R, G, B, Alpha) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(Alpha)]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface ABButton()

@end

@implementation ABButton

- (ABButton *)buttonWithAboveLabelTitle:(NSString *)aStr belowLabelTitle:(NSString *)bStr Name:(NSString *)game_currency_name Rate:(NSString *)rate{
    
    if ([game_currency_name isEqualToString:@""]) {
        
        self.centerL = [[UILabel alloc] init];
        self.centerL.text = [NSString stringWithFormat:@"%@元",aStr];
        self.centerL.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
        self.centerL.textColor = ABColor(226, 226, 226, 1.0);
        self.centerL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.centerL];
        
    }else{
        
        self.aboveL = [[UILabel alloc] init];
        self.aboveL.text = [NSString stringWithFormat:@"%@元",aStr];
        self.aboveL.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
        self.aboveL.textColor = ABColor(226, 226, 226, 1.0);
        self.aboveL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.aboveL];
        //    self.aboveL = aboveL;
        
        self.belowL = [[UILabel alloc] init];
        self.belowL.text = [NSString stringWithFormat:@"%d%@",[aStr intValue] * [rate intValue],bStr];
        self.belowL.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        self.belowL.textColor = ABColor(226, 226, 226, 1.0);
        self.belowL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.belowL];
        
    }
    
    
    
    
//    self.belowL = belowL;
    
    return self;
}

- (ABButton *)buttonWithTitle:(NSString *)aStr
{
    [self setTitle:aStr forState:0];
    [self setTitleColor:ABColor(21, 135, 228, 1.0) forState:0];
    self.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    
    self.Money = aStr;
    
    return self;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.size = CGSizeMake((SCREEN_WIDTH-60)/3, 59);
//        self.layer.borderColor = ABColor(21, 135, 228, 1.0).CGColor;
//        self.layer.borderWidth = 1;
//        self.layer.cornerRadius = 5.0f;
//        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.aboveL.frame = CGRectMake(0, 13, self.width, 16);
    self.belowL.frame = CGRectMake(0, CGRectGetMaxY(self.aboveL.frame)+6, self.width, 11);
    self.centerL.frame = CGRectMake(0, (self.height-16)/2, self.width, 16);
}


//- (void)setEnabled:(BOOL)enabled {
//    [super setEnabled:enabled];
//    if (!enabled) {
//        self.aboveL.textColor = [UIColor lightGrayColor];
//        self.belowL.textColor = [UIColor lightGrayColor];
//        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        self.layer.cornerRadius = 5.0f;
//    }
//}




@end
