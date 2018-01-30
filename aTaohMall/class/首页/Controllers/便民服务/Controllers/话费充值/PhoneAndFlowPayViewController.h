//
//  PhoneAndFlowPayViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneAndFlowPayViewController : UIViewController

@property(nonatomic,copy) NSString *Sigen;

@property(nonatomic,copy) NSString *Phone;

@property(nonatomic,copy) NSString *integral;

@property(nonatomic,copy) NSString *orderno;

@property(nonatomic,copy) NSString *pay_integral;

@property(nonatomic,copy) NSString *pay_money;

@property(nonatomic,copy) NSString *price;

@property(nonatomic,copy) NSString *type;

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *sta;
//请求支付宝参数
@property(nonatomic,copy) NSString *Alipay_Goods_name;

@property(nonatomic,copy) NSString *APP_ID;

@property(nonatomic,copy) NSString *SELLER;

@property(nonatomic,copy) NSString *RSA_PRIVAT;

@property(nonatomic,copy) NSString *Pay_orderno;

@property(nonatomic,copy) NSString *Notify_url;

@property(nonatomic,copy) NSString *PPay_money;

@property(nonatomic,copy) NSString *Return_url;

@property(nonatomic,copy) NSString *Money_url;

@property(nonatomic,copy) NSString *proportion;

@property(nonatomic,copy)NSString *PayType;

@property(nonatomic,copy) NSString *Status;//根据状态判断支付方式

@property(nonatomic,copy) NSString *successurl;


@end
