//
//  CartGoToDingDanViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CartGoToDingDanDelegate <NSObject>

-(void)CartGoToDingDanReloadData;


@end
@interface CartGoToDingDanViewController : UIViewController

@property(nonatomic,strong) NSMutableArray *NewAddressArrM;//地址
//
//@property(nonatomic,strong) NSMutableArray *StoreArrM;//店铺
//
//@property(nonatomic,strong) NSMutableArray *GoodsArrM;//商品
//
//@property(nonatomic,strong) NSMutableArray *LabelArrM;//合计
//
//@property(nonatomic,strong) NSMutableArray *RedArrM;//金钱

@property(nonatomic,strong) id responseObj;

@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,copy) NSString *json;

@property(nonatomic,copy) NSString *AddressPhone;//

@property(nonatomic,copy) NSString *AddressAid;//

@property(nonatomic,copy) NSString *UserName;//

@property(nonatomic,copy) NSString *UserPhone;//

@property(nonatomic,copy) NSString *UserAddress;//

@property(nonatomic,copy) NSString *UserType;//

@property(nonatomic,copy) NSString *UserID;//

@property(nonatomic,copy) NSString *PanDuan;//是否影藏tababr

@property(nonatomic,copy) NSString *AddressReloadString;

@property(nonatomic,copy) NSString *UserInteger;//用户积分

@property(nonatomic,copy) NSString *Alipay_Goods_name;

//请求支付宝参数
@property(nonatomic,copy) NSString *APP_ID;

@property(nonatomic,copy) NSString *SELLER;

@property(nonatomic,copy) NSString *RSA_PRIVAT;

@property(nonatomic,copy) NSString *Pay_orderno;

@property(nonatomic,copy) NSString *Notify_url;

@property(nonatomic,copy) NSString *Pay_money;

@property(nonatomic,copy) NSString *Return_url;

@property(nonatomic,copy) NSString *Money_url;


@property(nonatomic,copy)NSString *PayType;

@property(nonatomic,copy) NSString *Status;//根据状态判断支付方式

@property(nonatomic,copy) NSString *successurl;

@property(nonatomic,weak) id <CartGoToDingDanDelegate> delegate;

@end
