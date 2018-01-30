//
//  QueDingDingDanViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueDingDingDanViewController : UIViewController

@property(nonatomic,copy)NSString *Goods_Type_Switch;//判断纯积分商品，开关不能关

@property(nonatomic,assign)NSInteger num;//购买件数

@property(nonatomic,copy)NSString *bankList;//支付需要

@property(nonatomic,copy)NSString *logo;//商标

@property(nonatomic,copy)NSString *path;//支付返回值

@property(nonatomic,copy)NSString *storename;//店铺名

@property(nonatomic,copy)NSString *gid;//商品id

@property(nonatomic,copy)NSString *number;//

@property(nonatomic,copy)NSString *money;//价格

@property(nonatomic,copy)NSString *type;//判断支付方式

@property(nonatomic,copy)NSString *MoneyType;

@property(nonatomic,copy)NSString *phone;//电话

@property(nonatomic,copy)NSString *mid;//店铺ID

@property(nonatomic,copy)NSString *money1;//支付价格

@property(nonatomic,copy)NSString *orderno;//

@property(nonatomic,copy)NSString *stock;//库存

@property(nonatomic,copy)NSString *pay_integer;//

@property(nonatomic,copy)NSString *pay_maney;//

@property(nonatomic,copy)NSString *integer;//总积分

@property(nonatomic,copy)NSString *PayType;

@property(nonatomic,copy)NSString *ID;//获取订单号id

@property(nonatomic,copy)NSString *aid;//地址id

@property(nonatomic,copy) NSString *GoodsDetailType;//从商品详情传type到订单详情

@property(nonatomic,copy) NSString *Status;//根据状态判断支付方式

@property(nonatomic,copy) NSString *ZongJi;//总计

@property(nonatomic,copy) NSString *ShiYongJiFen;//使用积分

@property(nonatomic,copy) NSString *sigen;//


@property(nonatomic,copy) NSString *UserName;//

@property(nonatomic,copy) NSString *UserPhone;//

@property(nonatomic,copy) NSString *UserAddress;//

@property(nonatomic,copy) NSString *UserType;//

@property(nonatomic,copy) NSString *UserID;//

@property(nonatomic,copy) NSString *SendWayType;//

@property(nonatomic,copy) NSString *message;

@property(nonatomic,copy) NSString *freight;//邮费

@property(nonatomic,copy) NSString *count;//限购件数

@property(nonatomic,copy) NSString *good_type;

@property(nonatomic,copy) NSString *ChaoChuKuCun;//判断是否超出库存

@property(nonatomic,copy) NSString *stuts;//判断限购商品是否超出

@property(nonatomic,copy) NSString *AddressReloadString;

@property(nonatomic,copy) NSString *midddd;

@property(nonatomic,copy) NSString *exchange;//配送方式；

@property(nonatomic,copy) NSString *detailId;//属性商品ID

@property(nonatomic,copy) NSString *yunfei;

@property(nonatomic,copy) NSString *Alipay_Goods_name;

@property(nonatomic,copy) NSString *successurl;

@property(nonatomic,copy) NSString *YTmoney;

@property(nonatomic,copy) NSString *CutLogin;

@property(nonatomic,copy) NSString *YTLiuYan;

@property(nonatomic,copy) NSString *attributenum;//属性商品已选的购买数量


@property(nonatomic,copy) NSString *YTLogo;//配送方式；

@property(nonatomic,copy) NSString *YTOrderno;//配送方式；

@property(nonatomic,copy) NSString *YTStorename;//配送方式；



//请求支付宝参数
@property(nonatomic,copy) NSString *APP_ID;

@property(nonatomic,copy) NSString *SELLER;

@property(nonatomic,copy) NSString *RSA_PRIVAT;

@property(nonatomic,copy) NSString *Pay_orderno;

@property(nonatomic,copy) NSString *Notify_url;

@property(nonatomic,copy) NSString *Pay_money;

@property(nonatomic,copy) NSString *Return_url;

@property(nonatomic,copy) NSString *Money_url;

@end
