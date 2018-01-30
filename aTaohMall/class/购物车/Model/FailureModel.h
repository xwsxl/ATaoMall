//
//  FailureModel.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FailureModel : NSObject


@property(nonatomic,copy) NSString *attribute_failure;//判断是否有属性,2为属性商品

@property(nonatomic,copy) NSString *count;//商品限购

@property(nonatomic,copy) NSString *detailId;//商品属性id

@property(nonatomic,copy) NSString *exchange_type;//兑换方式

@property(nonatomic,copy) NSString *freight;//运费

@property(nonatomic,copy) NSString *attribute_str;//运费

@property(nonatomic,copy) NSString *gid;//商品id

@property(nonatomic,copy) NSString *good_type;//商品类型

@property(nonatomic,copy) NSString *mid;//商户id

@property(nonatomic,copy) NSString *name;//商品名称

@property(nonatomic,copy) NSString *number;//商品数量

@property(nonatomic,copy) NSString *pay_integer;//单间商品积分

@property(nonatomic,copy) NSString *pay_maney;//单件商品金额

@property(nonatomic,copy) NSString *scopeimg;//商品图片

@property(nonatomic,copy) NSString *reason;//失效原因

@property(nonatomic,copy) NSString *status;//商品状态

@property(nonatomic,copy) NSString *status1;//在购物车是否失效 1失效 0有效

@property(nonatomic,copy) NSString *stock;//库存

@property(nonatomic,copy) NSString *sid;//加入购物车商品id

@property(nonatomic,copy) NSString *storename;//店铺名

@property(nonatomic,copy) NSString *uid;//

@end
