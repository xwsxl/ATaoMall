//
//  AirPlaneBackDetailViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirPlaneDetailBackDetegate <NSObject>

-(void)AirPlaneDetailBack;

@end

@interface AirPlaneBackDetailViewController : UIViewController

@property(nonatomic,copy) NSString *PanDuan;//记录选择的是经济舱，还是商务舱
@property(nonatomic,copy) NSString *TagString;//记录预定按钮tag
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *flightNo;
@property(nonatomic,copy) NSString *sigen;
@property(nonatomic,copy) NSString *GoBackString;

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

@property(nonatomic,copy) NSString *Text;

@property(nonatomic,copy) NSString *ManOrKidString;//判断选择的是成人还是儿童

@property(nonatomic,copy) NSString *start_code;
@property(nonatomic,copy) NSString *arrive_code;
@property(nonatomic,copy) NSString *cabin;
@property(nonatomic,copy) NSString *fare;
@property(nonatomic,copy) NSString *ischd;
@property(nonatomic,copy) NSString *isspe;
@property(nonatomic,copy) NSString *istehui;

@property(nonatomic,copy) NSString *TicketString;
@property(nonatomic,copy) NSString *Price;
@property(nonatomic,copy) NSString *Money;
@property(nonatomic,copy) NSString *JiJian;
@property(nonatomic,copy) NSString *OilString;
@property(nonatomic,copy) NSString *JiJianString;//基建费

//支付需要数据
@property(nonatomic,copy) NSString *Pay_money;
@property(nonatomic,copy) NSString *Pay_integral;
@property(nonatomic,copy) NSString *Pay_run_time;
@property(nonatomic,copy) NSString *Pay_start_time;
@property(nonatomic,copy) NSString *Pay_arrive_time;
@property(nonatomic,copy) NSString *Pay_start_airport;
@property(nonatomic,copy) NSString *Pay_start_terminal;
@property(nonatomic,copy) NSString *Pay_arrive_airport;
@property(nonatomic,copy) NSString *Pay_arrive_terminal;
@property(nonatomic,copy) NSString *Pay_airport_flight;
@property(nonatomic,copy) NSString *Pay_airport_name;
@property(nonatomic,copy) NSString *Pay_airport_code;
@property(nonatomic,copy) NSString *Pay_phone1;
@property(nonatomic,copy) NSString *Pay_linkman_name;
@property(nonatomic,copy) NSString *Pay_is_aviation_accident_insurance;
@property(nonatomic,copy) NSString *Pay_shipping_space;
@property(nonatomic,copy) NSString *Pay_cabin;
@property(nonatomic,copy) NSString *Pay_clientId;
@property(nonatomic,copy) NSString *Pay_bookpara;
@property(nonatomic,copy) NSString *Pay_plane_type;
@property(nonatomic,copy) NSString *Pay_is_quick_meal;
@property(nonatomic,copy) NSString *Pay_is_arrive_and_depart;
@property(nonatomic,copy) NSString *Pay_is_tehui;
@property(nonatomic,copy) NSString *Pay_is_spe;
@property(nonatomic,copy) NSString *Pay_price;
@property(nonatomic,copy) NSString *Pay_airrax;
@property(nonatomic,copy) NSString *Pay_fuel_oil;
@property(nonatomic,copy) NSString *Pay_psgtype;
@property(nonatomic,copy) NSString *Pay_adultTicketNo;
@property(nonatomic,copy) NSString *Pay_aviation_accident_insurance_price;
@property(nonatomic,copy) NSString *refund_instructions;

@property(nonatomic,weak) id <AirPlaneDetailBackDetegate> delegate;

@end
