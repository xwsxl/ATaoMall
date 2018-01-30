//
//  AirWaitePayOneView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/5.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirWaitePayOneView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

-(void)Price:(NSString *)price Inter:(NSString *)inter fuel_oil_airrax:(NSString *)fuel_oil_airrax aviation_accident_insurance_price:(NSString *)aviation_accident_insurance_price Number:(int)number is_aviation_accident_insurance:(NSString *)is_aviation_accident_insurance;

@end
