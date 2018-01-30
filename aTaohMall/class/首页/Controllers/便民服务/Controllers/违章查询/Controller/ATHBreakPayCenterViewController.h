//
//  ATHBreakPayCenterViewController.h
//  违章查询
//
//  Created by JMSHT on 2017/7/27.
//  Copyright © 2017年 yt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PecOrderModel.h"

@interface ATHBreakPayCenterViewController : UIViewController

@property(nonatomic,strong)PecOrderModel *orderModel;
@property(nonatomic,copy)NSString *count;

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

@property(nonatomic,copy) NSString *Alipay_Goods_name;

@property(nonatomic,copy) NSString *Pay_money;
@end
