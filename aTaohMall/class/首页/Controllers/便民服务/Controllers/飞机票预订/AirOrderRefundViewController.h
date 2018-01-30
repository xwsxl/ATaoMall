//
//  AirOrderRefundViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirOrderRefundViewController : UIViewController

@property(nonatomic,strong) NSArray *ManArray;//

@property(nonatomic,copy) NSString *payintegral;

@property(nonatomic,copy) NSString *paymoney;

@property(nonatomic,copy) NSString *refund_instructions;

@property(nonatomic,copy)NSString *sigen;//验签值

@property(nonatomic,copy)NSString *orderno;//订单号

@property(nonatomic,copy) NSString *TuiId;

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址


@end
