//
//  BianMinModel.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/26.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BianMinModel : NSObject

@property(nonatomic,copy) NSString *Id;

@property(nonatomic,copy) NSString *p;

@property(nonatomic,copy) NSString *v;

@property(nonatomic,copy) NSString *inprice;

@property(nonatomic,copy) NSString *cardid;

@property(nonatomic,copy) NSString *cardname;

@property(nonatomic,copy) NSString *cardkey;

@property(nonatomic,copy) NSString *AREA;

@property(nonatomic,copy) NSString *SERVER;

@property(nonatomic,copy) NSString *qufuName;

@property(nonatomic,copy) NSString *amounts;

@property(nonatomic,copy) NSString *ji_cardid;

@property(nonatomic,copy) NSString *you_cardid;

@property(nonatomic,copy) NSString *pervalue;

@property(nonatomic,copy) NSString *recharge_type;

@property(nonatomic,copy) NSString *cardname_type;

//飞机票
@property(nonatomic,copy) NSString *city_code;
@property(nonatomic,copy) NSString *city_name;
@property(nonatomic,copy) NSString *city_name_full;
@property(nonatomic,copy) NSString *city_phoneticize;
@property(nonatomic,copy) NSString *first_letter;

//飞机票航班次
@property(nonatomic,copy) NSString *Air_name;//航空公司简称
@property(nonatomic,copy) NSString *Air_value;//航空公司二字码
@property(nonatomic,copy) NSString *Air_selectGongsi;//是否选中

@property(nonatomic,copy) NSString *Air_selectjiXing;//是否选中

@property(nonatomic,copy) NSString *Air_selectCangwei;//是否选中


@property(nonatomic,copy) NSString *Air_AirLineCode;//航空公司二字码
@property(nonatomic,copy) NSString *Air_CarrinerName;//航空公司简称
@property(nonatomic,copy) NSString *Air_StartPortName;//出发机场名称
@property(nonatomic,copy) NSString *Air_StartPort;//出发城市三字码
@property(nonatomic,copy) NSString *Air_EndPortName;//到达机场名称
@property(nonatomic,copy) NSString *Air_EndPort;//到达城市三字码
@property(nonatomic,copy) NSString *Air_FlightNo;//航班号
@property(nonatomic,copy) NSString *Air_JoinPort;//
@property(nonatomic,copy) NSString *Air_JoinDate;//
@property(nonatomic,copy) NSString *Air_MinCabin;//最低舱位
@property(nonatomic,copy) NSString *Air_MinDiscount;//最低舱折扣
@property(nonatomic,copy) NSString *Air_MinFare;//最低舱票面价
@property(nonatomic,copy) NSString *Air_MinTicketCount;//最低舱票数
@property(nonatomic,copy) NSString *Air_OffTime;//起飞时间
@property(nonatomic,copy) NSString *Air_ArriveTime;//到达时间
@property(nonatomic,copy) NSString *Air_StartT;//起飞航站楼
@property(nonatomic,copy) NSString *Air_EndT;//到达航站楼
@property(nonatomic,copy) NSString *Air_ByPass;//是否转机(0 不是 1 是）
@property(nonatomic,copy) NSString *Air_Meat;//是否有餐食(0没有 1有)
@property(nonatomic,copy) NSString *Air_StaFare;//标准舱价格(全价舱)
@property(nonatomic,copy) NSString *Air_Oil;//燃油费
@property(nonatomic,copy) NSString *Air_Tax;//机场建设费
@property(nonatomic,copy) NSString *Air_Distance;//距离
@property(nonatomic,copy) NSString *Air_PlaneType;//机型代码
@property(nonatomic,copy) NSString *Air_PlaneModel;//机型
@property(nonatomic,copy) NSString *Air_RunTime;//飞行时间
@property(nonatomic,copy) NSString *Air_ETicket;//是否电子票（0 不是 1 是）

//日期
@property(nonatomic,copy) NSString *date;

@property(nonatomic,copy) NSString *week;


//机票详情

@property(nonatomic,copy) NSString *CabinKey;//舱位key
@property(nonatomic,copy) NSString *AirLineCode;//航空公司二字码
@property(nonatomic,copy) NSString *Cabin;//舱位代码
@property(nonatomic,copy) NSString *CabinName;//舱位名称
@property(nonatomic,copy) NSString *Discount;//折扣
@property(nonatomic,copy) NSString *IsTeHui;//是否特惠(0 不是 1 是)
@property(nonatomic,copy) NSString *Fare;//票面价
@property(nonatomic,copy) NSString *IsSpe;//是否特价舱位（0 不是 1 是）
@property(nonatomic,copy) NSString *IsSpePolicy;//是否特殊政策 (1是 0 不是)
@property(nonatomic,copy) NSString *Sale;//售价
@property(nonatomic,copy) NSString *BabySalePrice;//婴儿售价(仅单程和查询成人票时有效)【2017-02-20 新增接口参数 用于预订婴儿票】
@property(nonatomic,copy) NSString *TicketCount;//票数
@property(nonatomic,copy) NSString *TuiGaiQian;//退改签说明
@property(nonatomic,copy) NSString *UserRate;//用户返点
@property(nonatomic,copy) NSString *VTWorteTime;//供应商退票时间
@property(nonatomic,copy) NSString *WorkTime;//供应商上下班时间
@property(nonatomic,copy) NSString *YouHui;//优惠
@property(nonatomic,copy) NSString *IsKx;//特惠节点
@property(nonatomic,copy) NSString *KxSpValue;//特惠节点
@property(nonatomic,copy) NSString *Bookpara;


//乘车人信息
@property(nonatomic,copy) NSString *ManId;
@property(nonatomic,copy) NSString *Index;
@property(nonatomic,copy) NSString *ManUid;
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *air_passenger;
@property(nonatomic,copy) NSString *passporttypeseid;
@property(nonatomic,copy) NSString *passportseno;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,strong) NSMutableArray *childArr;


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


@property(nonatomic,copy) NSString *NewadultTicketNo;
@property(nonatomic,copy) NSString *Newpassportseno;
@property(nonatomic,copy) NSString *Newpassenger_name;


//退款
@property(nonatomic,copy) NSString *airport_name;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *airport_flight;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *TagString;

@property(nonatomic,copy) NSString *ManSelectString;

@property(nonatomic,copy) NSString *GongsiTag;
@property(nonatomic,copy) NSString *JiXingTag;
@property(nonatomic,copy) NSString *CangWeiTag;

//火车
@property(nonatomic,copy) NSString *Train_name;
@property(nonatomic,copy) NSString *Train_code;
@property(nonatomic,copy) NSString *Train_first_initial;

@property(nonatomic,copy) NSString *trainSelectedStart;
@property(nonatomic,copy) NSString *trainSelectedEnd;
@property(nonatomic,copy) NSString *trainSelectedSitType;

@property(nonatomic,copy) NSString *arrive_time;
@property(nonatomic,copy) NSString *from_station_code;
@property(nonatomic,copy) NSString *from_station_name;
@property(nonatomic,copy) NSString *last_price;
@property(nonatomic,copy) NSString *run_time;
@property(nonatomic,copy) NSString *run_time_minute;



@property(nonatomic,copy) NSString *start_time;
@property(nonatomic,copy) NSString *to_station_code;
@property(nonatomic,copy) NSString *to_station_name;
@property(nonatomic,copy) NSString *traincode;
@property(nonatomic,copy) NSString *train_type;


@property(nonatomic,copy) NSString *wz_num;//无座
@property(nonatomic,copy) NSString *wz_price;//无座
@property(nonatomic,copy) NSString *yw_num;//硬卧
@property(nonatomic,copy) NSString *yw_price;//硬卧
@property(nonatomic,copy) NSString *ywx_num;//
@property(nonatomic,copy) NSString *ywx_price;//
@property(nonatomic,copy) NSString *yz_num;//硬座
@property(nonatomic,copy) NSString *yz_price;//硬座
@property(nonatomic,copy) NSString *rw_num;//软卧
@property(nonatomic,copy) NSString *rw_price;//软卧
@property(nonatomic,copy) NSString *rz_num;//软卧
@property(nonatomic,copy) NSString *rz_price;//软卧
@property(nonatomic,copy) NSString *rwx_num;//软卧
@property(nonatomic,copy) NSString *rwx_price;//软卧

@property(nonatomic,copy) NSString *ydz_price;//一等座
@property(nonatomic,copy) NSString *edz_price;//二等座
@property(nonatomic,copy) NSString *swz_price;//商务座
@property(nonatomic,copy) NSString *tdz_price;//特等座
@property(nonatomic,copy) NSString *gjrw_price;//高级软卧

@property(nonatomic,copy) NSString *ydz_num;//一等座
@property(nonatomic,copy) NSString *edz_num;//二等座
@property(nonatomic,copy) NSString *swz_num;//商务座
@property(nonatomic,copy) NSString *tdz_num;//特等座
@property(nonatomic,copy) NSString *gjrw_num;//高级软卧

//车票预订
@property(nonatomic,copy) NSString *Detail_num;//高级软卧
@property(nonatomic,copy) NSString *Detail_price;//高级软卧
@property(nonatomic,copy) NSString *Detail_name;//高级软卧
@property(nonatomic,copy) NSString *Detail_type;//高级软卧
@property(nonatomic,copy) NSString *Detail_select;//高级软卧
@property(nonatomic,copy) NSString *zwcode;
@property(nonatomic,copy) NSString *is_accept_standing;

//火车票提交
@property(nonatomic,copy) NSString *Commit_child_name;
@property(nonatomic,copy) NSString *Commit_piaotypename;
@property(nonatomic,copy) NSString *Commit_zwcode;
@property(nonatomic,copy) NSString *Commit_piaotype;
@property(nonatomic,copy) NSString *Commit_passengersename;
@property(nonatomic,copy) NSString *Commit_passportseno;
@property(nonatomic,copy) NSString *Commit_passporttypeseidname;
@property(nonatomic,copy) NSString *Commit_passporttypeseid;
@property(nonatomic,copy) NSString *Commit_seat_type_name;
@property(nonatomic,copy) NSString *Commit_ticket_no;
@property(nonatomic,copy) NSString *Commit_cxin;

@end
