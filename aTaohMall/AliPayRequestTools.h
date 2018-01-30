//
//  AliPayRequestTools.h
//  aTaohMall
//
//  Created by DingDing on 2017/8/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Result)(id responseObj,NSError *error);
//请求数据成功的Block
typedef void(^Success)(NSDictionary *responseObj);
//请求失败的Block
typedef void(^Failure)(NSError *error);

@interface AliPayRequestTools : NSObject

@property(nonatomic,copy) NSString *orderno;
//自2017-11-7号起传批次号
@property (nonatomic,strong)NSString *order_batchid;

@property(nonatomic,copy) NSString *status;

@property(nonatomic,copy) NSString *debitBankJson;

@property(nonatomic,copy) NSString *description1;

@property(nonatomic,copy) NSString *notifyurl;

@property(nonatomic,copy) NSString *ordername;

@property(nonatomic,copy) NSString *out_trade_no;

@property(nonatomic,copy) NSString *pmoney;

@property(nonatomic,copy) NSString *message;

@property (nonatomic, copy) NSString *sigens;

@property (nonatomic, copy) NSString *successurl;

@property (nonatomic, copy) NSString *backString;

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


-(void)ContinuePayWithOrderNum:(NSString *)orderNum OnViewController:(UIViewController *)VC AndResponseSuccess:(Success)success failed:(Failure)failed;
-(void)BMContinuePayWithOrderNum:(NSString *)orderNum OnViewController:(UIViewController *)VC AndResponseSuccess:(Success)success failed:(Failure)failed;
+(instancetype)shareAlipayTool;
@end

