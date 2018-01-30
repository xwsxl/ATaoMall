//
//  SearchResultModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/2.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultModel : NSObject

@property(nonatomic,copy)NSString *account;//商品描述

@property(nonatomic,copy)NSString *scopeimg;//商品图片

@property(nonatomic,copy)NSString *id;//商品id

@property(nonatomic,copy)NSString *pay_integer;//商品积分

@property(nonatomic,copy)NSString *pay_maney;//商品价格

@property(nonatomic,copy)NSString *name;//商品名称

@property(nonatomic,copy)NSString *amount;//付款数量

@property(nonatomic,copy)NSString *good_type;//判断商品类型

@property(nonatomic,copy)NSString *status;//判断商品状态

@property(nonatomic,copy)NSString *stock;//商品库存

@property(nonatomic,copy)NSString *start_time;//开始时间

@property(nonatomic,copy)NSString *end_time;//结束时间

@property(nonatomic,copy)NSString *storename;

@property(nonatomic,copy)NSString *attribute;

@property(nonatomic,copy)NSString *integral_type;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
