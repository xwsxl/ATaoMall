//
//  ABButton.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABButton : UIButton

- (ABButton *)buttonWithAboveLabelTitle:(NSString *)aStr belowLabelTitle:(NSString *)bStr Name:(NSString *)game_currency_name Rate:(NSString *)rate;

- (ABButton *)buttonWithTitle:(NSString *)aStr;

/** aboveLabel */
@property (nonatomic, strong) UILabel *aboveL;
/** belowLabel */
@property (nonatomic, strong) UILabel *belowL;

@property (nonatomic, strong) UILabel *centerL;

@property(nonatomic,copy) NSString *Money;

@property(nonatomic,copy) NSString *SelectString;
@end
