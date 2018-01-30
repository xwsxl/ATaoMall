//
//  XLDingDanModel.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLShoppingModel.h"
#import "PersonalShoppingDanDetailModel.h"
@interface XLDingDanModel : NSObject
@property (nonatomic,strong)NSMutableArray *goods_order_list;
@property (nonatomic,strong)NSString *logo;
@property (nonatomic,strong)NSString *mid;
@property (nonatomic,strong)NSString *order_batchid;
@property (nonatomic,strong)NSString *storename;
@property (nonatomic,strong)NSString *total_freight;
@property (nonatomic,strong)NSString *total_integral;
@property (nonatomic,strong)NSString *total_money;
@property (nonatomic,strong)NSString *total_number_goods;
@property (nonatomic,strong)NSString *total_status;

@property (nonatomic,strong)NSString *type;


@property (nonatomic,strong)NSString *dingDanType;
//包裹号码
@property (nonatomic,strong)NSString *waybillnumber;
//
@property (nonatomic,strong)NSString *batchid;
@property (nonatomic,strong)NSString *orderno;
@property (nonatomic,strong)NSString *company;
@property (nonatomic,strong)NSString *logisticnumber;
/*
String batchid = request.getParameter("batchid");                    //退款批次号
String orderno = request.getParameter("orderno");                    //订单号
String company = request.getParameter("company");                    //物流公司
String logisticnumber = request.getParameter("logisticnumber");        //运单号
 */
/**
 Description 订单高度
 */
@property (nonatomic)       CGFloat              sectionFootHeight;
/**
 Description 退款订单高度
 */
@property (nonatomic)       CGFloat              refundFootHeight;


-(void)goodsOrderListFromArray:(NSArray *)tempArr;
-(void)goodsOrderListFromArray:(NSArray *)tempArr withType:(NSString *)type;

-(instancetype)initWithPersonalShoppingDetailModel:(PersonalShoppingDanDetailModel *)model;


@end
