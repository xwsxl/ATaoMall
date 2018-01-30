//
//  AirPaySuccessRefundViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/5.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPaySuccessRefundViewController : UIViewController

@property(nonatomic,copy)NSString *sigen;//验签值

@property(nonatomic,copy)NSString *orderno;//订单号

@property(nonatomic,copy)NSString *status;//订单状态

@property(nonatomic,copy)NSString *logo;//商户logo

@property(nonatomic,copy)NSString *storename;//店铺名
@property(nonatomic,copy)NSString *scopeimg;

@property(nonatomic,copy)NSString *shopId;

@property(nonatomic,copy)NSString *paymoney;

@property(nonatomic,copy)NSString *backString;//判断返回界面

@property(nonatomic,copy)NSString *payintegral;
@property(nonatomic,copy)NSString *Pay_price;
@property(nonatomic,copy)NSString *fuel_oil_airrax;
@property(nonatomic,copy)NSString *aviation_accident_insurance_price;
@property(nonatomic,copy)NSString *is_aviation_accident_insurance;
@property(nonatomic,copy)NSString *mid;

@property(nonatomic,copy)NSString *gid;

@property(nonatomic,copy)  NSString *attribute;//商品属性
@property(nonatomic,copy)  NSString *good_type;
@property(nonatomic,copy)NSString *goods_status;

@property(nonatomic,copy)NSString *NewNAme;//经度

@property(nonatomic,copy)NSString *NewPhone;//经度

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property(nonatomic,copy)NSString *waybillnumber;

@property(nonatomic,copy)NSString *company;

@property(nonatomic,copy)NSString *OrderStatus;

@property(nonatomic,copy)NSString *order_type;

@property(nonatomic,strong) NSArray *ManArray;//

@property(nonatomic,copy) NSString *Tuipayintegral;

@property(nonatomic,copy) NSString *Tuipaymoney;

@property(nonatomic,copy) NSString *TuiId;

@property(nonatomic,copy) NSString *refund_instructions;



@end
