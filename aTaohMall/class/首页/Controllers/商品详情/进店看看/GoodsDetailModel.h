//
//  GoodsDetailModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject

@property(nonatomic,copy)NSString *account;

@property(nonatomic,copy)NSString *amount;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *scopeimg;

@property(nonatomic,copy)NSString *pay_integer;

@property(nonatomic,copy)NSString *pay_maney;

@property(nonatomic,copy)NSString *pice;

@property(nonatomic,copy)NSString *integral;

@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *tname;

@property(nonatomic,copy)NSString *freight;//邮费

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *coordinates;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString *logo;

@property(nonatomic,copy)NSString *mobile;

@property(nonatomic,copy)NSString *province;

@property(nonatomic,copy)NSString *storename;

@property(nonatomic,copy)NSString *mid;//商户id

@property(nonatomic,copy)NSString *type;//判断包邮类型


@property(nonatomic,copy)NSString *good_type;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *is_attribute;//商品属性判断值

@property(nonatomic,copy)NSString *max_price;//原价最高;

@property(nonatomic,copy)NSString *min_price;//原价最低;

@property(nonatomic,copy)NSString *end_time_str;

@property(nonatomic,copy)NSString *start_time_str;



@end
