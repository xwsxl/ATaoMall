//
//  DuiHuanSuccessViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/9/1.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DuiHuanSuccessViewController : UIViewController


@property(nonatomic,copy)NSString *sigen;//验签值

@property(nonatomic,copy)NSString *orderno;//订单号

@property(nonatomic,copy)NSString *status;//订单状态

@property(nonatomic,copy)NSString *logo;//商户logo

@property(nonatomic,copy)NSString *storename;//店铺名

@property(nonatomic,copy)NSString *shopId;

@property(nonatomic,copy)NSString *paymoney;

@property(nonatomic,copy)NSString *payintegral;

@property(nonatomic,copy)NSString *mid;

@property(nonatomic,copy)NSString *gid;

@property(nonatomic,copy)NSString *backType;//判断返回界面

@property(nonatomic,copy)  NSString *attribute;//商品属性


@end
