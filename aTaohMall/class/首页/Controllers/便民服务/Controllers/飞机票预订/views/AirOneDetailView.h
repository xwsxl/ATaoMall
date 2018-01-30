//
//  AirOneDetailView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirOneDetailView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *flightNo;
@property(nonatomic,copy) NSString *DateString;
@property(nonatomic,copy) NSString *fares;
@property(nonatomic,copy) NSString *WeekString;
@property(nonatomic,copy) NSString *DateWeek;
@property(nonatomic,copy) NSString *TypeString;
@property(nonatomic,copy) NSString *Air_StartPortName;
@property(nonatomic,copy) NSString *Air_EndPortName;
@property(nonatomic,copy) NSString *CarrinerName;
@property(nonatomic,copy) NSString *Air_OffTime;
@property(nonatomic,copy) NSString *ArriveTime;
@property(nonatomic,copy) NSString *Air_RunTime;
@property(nonatomic,copy) NSString *Air_StartT;
@property(nonatomic,copy) NSString *Air_EndT;
@property(nonatomic,copy) NSString *Air_Meat;
@property(nonatomic,copy) NSString *Air_PlaneType;
@property(nonatomic,copy) NSString *Air_PlaneModel;
@property (nonatomic,strong)NSString *Air_ByPass;
-(void)Time:(NSString *)time Flight:(NSString *)flightNo;

@end
