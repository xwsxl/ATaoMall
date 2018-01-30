//
//  XLShoppingRefundModel.h
//  aTaohMall
//
//  Created by Hawky on 2017/12/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLShoppingRefundModel : NSObject

@property (nonatomic, copy) NSString *logistics_message;

@property (nonatomic, strong) NSArray *goods_list;

@property (nonatomic, copy) NSString *order_batchid;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *total_status;

@property (nonatomic, copy) NSString *checkdate;

@property (nonatomic, copy) NSString *logisticnumber;

@property (nonatomic, copy) NSString *add_phone;

@property (nonatomic, copy) NSString *total_money;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, copy) NSString *batchid;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, copy) NSString *add_name;

@property (nonatomic, copy) NSString *sysdate;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *total_integral;

@property (nonatomic, copy) NSString *refund_status;

@property (nonatomic, copy) NSString *refun_record_number;

@end
