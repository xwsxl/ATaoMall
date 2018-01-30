//
//  AirGoBackDetailView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirGoBackDetailView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIView           *shareListView1;
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

@property(nonatomic,copy) NSString *time1;
@property(nonatomic,copy) NSString *flightNo1;
@property(nonatomic,copy) NSString *DateString1;
@property(nonatomic,copy) NSString *fares1;
@property(nonatomic,copy) NSString *WeekString1;
@property(nonatomic,copy) NSString *DateWeek1;
@property(nonatomic,copy) NSString *TypeString1;
@property(nonatomic,copy) NSString *Air_StartPortName1;
@property(nonatomic,copy) NSString *Air_EndPortName1;
@property(nonatomic,copy) NSString *CarrinerName1;
@property(nonatomic,copy) NSString *Air_OffTime1;
@property(nonatomic,copy) NSString *ArriveTime1;
@property(nonatomic,copy) NSString *Air_RunTime1;
@property(nonatomic,copy) NSString *Air_StartT1;
@property(nonatomic,copy) NSString *Air_EndT1;
@property(nonatomic,copy) NSString *Air_Meat1;
@property(nonatomic,copy) NSString *Air_PlaneType1;
@property(nonatomic,copy) NSString *Air_PlaneModel1;

@property(nonatomic,copy) NSString *gotime;
@property(nonatomic,copy) NSString *goflightNo;
@property(nonatomic,copy) NSString *backtime;
@property(nonatomic,copy) NSString *backFlight;

-(void)Time:(NSString *)gotime Flight:(NSString *)goflightNo Back:(NSString *)backtime backFlight:(NSString *)backFlight;

@end
