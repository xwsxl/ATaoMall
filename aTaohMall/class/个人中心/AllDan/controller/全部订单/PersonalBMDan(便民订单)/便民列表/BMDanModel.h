//
//  BMDanModel.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/28.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMSingleModel.h"
@interface BMDanModel : NSObject

@property (nonatomic, copy) NSString *order_type;

@property (nonatomic, copy) NSString *airport_flight;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *orderno;

@property (nonatomic, copy) NSString *airport_name;

@property (nonatomic, copy) NSString *scopeimg;

@property (nonatomic, copy) NSString *payintegral;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *getdate;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *pay_order;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *pay_money;

@property (nonatomic, copy) NSString *paymoney;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *pay_status;

@property (nonatomic, copy) NSString *storename;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *pay_integral;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *service_charge;

@property (nonatomic,strong)NSString *che_type;

@property (nonatomic,strong)NSString *checi;

@property (nonatomic,strong)NSString *CarNo;

@property (nonatomic,strong)NSString *total_deductPoint;

@property (nonatomic,strong)NSString *total_fine;

@property (nonatomic,strong)NSString *is_refund;

//@property (nonatomic,strong)NSString *service_charge;

@property (nonatomic)   CGFloat       cellHeight;


-(CGFloat)getCellHeight;

@end
