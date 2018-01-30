//
//  AirPlaneReserveGoBackViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPlaneReserveGoBackViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,copy) NSString *Text;

@property(nonatomic,copy) NSString *LoginBack;//判断返回界面
@property(nonatomic,copy) NSString *PanDuan;//记录选择的是经济舱，还是商务舱
@property(nonatomic,copy) NSString *TagString;//记录预定按钮tag
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *flightNo;

@property (nonatomic,strong)NSString *Air_ByPass;//是否经停

@property(nonatomic,copy) NSString *GoBackString;
@property(nonatomic,copy) NSString *ManOrKidString;//判断选择的是成人还是儿童
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

@property(nonatomic,copy) NSString *start_code;
@property(nonatomic,copy) NSString *arrive_code;
@property(nonatomic,copy) NSString *cabin;
@property(nonatomic,copy) NSString *fare;
@property(nonatomic,copy) NSString *ischd;
@property(nonatomic,copy) NSString *isspe;
@property(nonatomic,copy) NSString *istehui;


@property(nonatomic,copy) NSString *Price;

@property(nonatomic,copy) NSString *Remark;//保险

@property(nonatomic,copy) NSString *Money;

@property(nonatomic,copy) NSString *OilString;

@property(nonatomic,copy) NSString *TicketString;//余票数

@property(nonatomic,copy) NSString *order_id;//成人票号去程
@property(nonatomic,copy) NSString *order_id1;//返程

@property(nonatomic,copy) NSString *CanUseInter;//可使用积分
@property(nonatomic,copy) NSString *sale;//保险费
@property(nonatomic,copy) NSString *JiJianString;//基建费
@property(nonatomic,copy) NSString *proportion;//抵扣率
@property(nonatomic,copy) NSString *integral;//用户总积分

@property(nonatomic,copy) NSString *RanYou;//可使用积分
@property(nonatomic,copy) NSString *DiKouInter;//可使用积分
@property(nonatomic,copy) NSString *BaoXianInter;//可使用积分

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
@property(nonatomic,copy) NSString *Pay_adultTicketNo1;
@property(nonatomic,copy) NSString *Pay_adultTicketNoBack;
@property(nonatomic,copy) NSString *Pay_aviation_accident_insurance_price;
@property(nonatomic,copy) NSString *refund_instructions;

@property(nonatomic,copy) NSString *json;

@property(nonatomic,copy) NSString *AddressPhone;//

@property(nonatomic,copy) NSString *AddressAid;//

@property(nonatomic,copy) NSString *UserName;//

@property(nonatomic,copy) NSString *UserPhone;//

@property(nonatomic,copy) NSString *UserAddress;//

@property(nonatomic,copy) NSString *UserType;//

@property(nonatomic,copy) NSString *UserID;//

@property(nonatomic,copy) NSString *AddressReloadString;

@property(nonatomic,copy) NSString *UserInteger;//用户积分

@property(nonatomic,copy) NSString *Alipay_Goods_name;

//
@property(nonatomic,copy) NSString *Go_Price;//去程价格

@property(nonatomic,copy) NSString *Go_Inter;//去程抵扣积分

@property(nonatomic,copy) NSString *Back_Price;//返程价格

@property(nonatomic,copy) NSString *Back_Inter;//返程抵扣积分

//请求支付宝参数
@property(nonatomic,copy) NSString *APP_ID;

@property(nonatomic,copy) NSString *SELLER;

@property(nonatomic,copy) NSString *RSA_PRIVAT;

@property(nonatomic,copy) NSString *Pay_orderno;

@property(nonatomic,copy) NSString *Notify_url;

@property(nonatomic,copy) NSString *ALiPay_money;

@property(nonatomic,copy) NSString *Return_url;

@property(nonatomic,copy) NSString *Money_url;


@property(nonatomic,copy)NSString *PayType;

@property(nonatomic,copy) NSString *Status;//根据状态判断支付方式

@property(nonatomic,copy) NSString *successurl;

@end
