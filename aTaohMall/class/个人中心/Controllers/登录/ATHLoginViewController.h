//
//  ATHLoginViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

//协议实现反向传值
@protocol LoginMessageDelegate <NSObject>

-(void)GoodsDetailReloadData:(NSString *)sigen;

-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6 andUserName:(NSString *)name;

-(void)LoginToBackCrat:(NSString *)sigen;

-(void)NoShowView;

-(void)shuxingYT;

-(void)LoginToTuWen:(NSString *)sigen ID:(NSString *)gid;

@end

@interface ATHLoginViewController : UIViewController


@property (nonatomic, strong) NSArray *dataArray;//字符素材数组

@property (nonatomic, strong) NSMutableString *authcodeString;//验证码字符串

@property (nonatomic,strong)NSString *Air_ByPass;

@property (nonatomic,copy) NSString *CartBack;//购物车登录返回

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property (nonatomic,copy) NSString *gid;

@property (nonatomic,copy) NSString *sigen;

@property (nonatomic,copy) NSString *storename;

@property (nonatomic,copy) NSString *logo;

@property (nonatomic,copy) NSString *GoodsDetailType;

@property (nonatomic,copy) NSString *Goods_Type_Switch;

@property (nonatomic,copy) NSString *SendWayType;

@property (nonatomic,copy) NSString *MoneyType;

@property (nonatomic,copy) NSString *midddd;

@property (nonatomic,copy) NSString *yunfei;

@property (nonatomic,copy) NSString *attributenum;

@property (nonatomic,copy) NSString *exchange ;

@property (nonatomic,copy) NSString *Good_status;

@property (nonatomic,copy) NSString *detailId ;

@property(nonatomic,copy) NSString *NotBuy;

@property(nonatomic,copy) NSString *NotBuyMessage;

@property(nonatomic,copy) NSString *YTStatus;

@property(nonatomic,copy) NSString *stock;

@property(nonatomic,copy) NSString *Phone;

@property(nonatomic,copy) NSString *BackBack;

@property (nonatomic,copy) NSString *choseView_gid;
@property (nonatomic,copy) NSString *choseView_mid;
@property (nonatomic,copy) NSString *choseView_num;
@property (nonatomic,copy) NSString *choseView_NewGoods_Type;
@property (nonatomic,copy) NSString *choseView_detailId;
@property (nonatomic,copy) NSString *choseView_exchange;

@property (nonatomic,copy) NSString *HeindBack;//判断创建通知方式

@property (nonatomic,copy) NSString *OOOOOOOOO;//判断创建通知方式

@property (nonatomic,copy) NSString *again;

@property(nonatomic,copy) NSString *backString;

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *userPassWord;

@property(nonatomic,copy) NSString *cancleString;//取消按钮隐藏

//便民服务
@property (nonatomic,copy) NSString *TitleString;
@property (nonatomic,copy) NSString *BianMinType;
@property (nonatomic,copy) NSString *BianMinPhone;
@property (nonatomic,copy) NSString *BianMinPrice;
@property (nonatomic,copy) NSString *BianMinFlow_size;
@property (nonatomic,copy) NSString *BianMinFlow_id;
@property (nonatomic,copy) NSString *BianMinGame_name;
@property (nonatomic,copy) NSString *BianMinGame_number;
@property (nonatomic,copy) NSString *BianMinGame_service;

@property(nonatomic,copy) NSString *Commitprice;

@property(nonatomic,copy) NSString *Commitid;

@property(nonatomic,copy) NSString *Commitcardid;

@property(nonatomic,copy) NSString *Commitcardnum;

@property(nonatomic,copy) NSString *Commitgame_userid;

@property(nonatomic,copy) NSString *Commitcardname;

@property(nonatomic,copy) NSString *Commitgame_area;

@property(nonatomic,copy) NSString *Commitpervalue;

@property(nonatomic,copy) NSString *Commitgame_srv;

@property(nonatomic,copy) NSString *Commitis_traffic_permit;


@property(nonatomic,copy) NSString *Text;

@property(nonatomic,copy) NSString *JiJian;
@property(nonatomic,copy) NSString *PanDuan;//记录选择的是经济舱，还是商务舱
@property(nonatomic,copy) NSString *TagString;//记录预定按钮tag
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *flightNo;

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
@property(nonatomic,copy) NSString *Pay_aviation_accident_insurance_price;

//火车票预订

@property(nonatomic,copy) NSString *Train_phone;
@property(nonatomic,copy) NSString *Train_StartCity;
@property(nonatomic,copy) NSString *Train_StartTime;
@property(nonatomic,copy) NSString *Train_ArriveCity;
@property(nonatomic,copy) NSString *Train_ArriveTime;
@property(nonatomic,copy) NSString *Train_CheCi;
@property(nonatomic,copy) NSString *Train_RunTime;
@property(nonatomic,copy) NSString *Train_from_station;
@property(nonatomic,copy) NSString *Train_to_station;
@property(nonatomic,copy) NSString *Train_DateString;
@property(nonatomic,copy) NSString *Train_Name;
@property(nonatomic,copy) NSString *Train_Price;
@property(nonatomic,copy) NSString *Train_TicketCount;
@property(nonatomic,strong) NSArray *Train_PriceArray;
@property(nonatomic,copy) NSString *Train_TypeString;
@property(nonatomic,copy) NSString *Train_zwcode;
@property(nonatomic,copy) NSString *Train_run_time;
@property(nonatomic,copy) NSString *Train_che_type;
@property(nonatomic,copy) NSString *Train_train_date;
@property(nonatomic,copy) NSString *Train_is_accept_standing;

@property(nonatomic,copy) NSString *json;

@property(nonatomic,copy) NSString *AddressPhone;//

@property(nonatomic,copy) NSString *AddressAid;//

//@property(nonatomic,copy) NSString *UserName;//

@property(nonatomic,copy) NSString *UserPhone;//

@property(nonatomic,copy) NSString *UserAddress;//

@property(nonatomic,copy) NSString *UserType;//

@property(nonatomic,copy) NSString *UserID;//

@property(nonatomic,copy) NSString *AddressReloadString;

@property(nonatomic,copy) NSString *UserInteger;//用户积分

@property(nonatomic,copy) NSString *Alipay_Goods_name;

@property(nonatomic,copy) NSString *order_id;//成人票号

@property(nonatomic,copy) NSString *refund_instructions;

@property(nonatomic,weak)id <LoginMessageDelegate> delegate;//代理对象

@end
