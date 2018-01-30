//
//  goodListModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/1.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodListModel : NSObject

@property(nonatomic,copy)NSString *amount;//付款人数

@property(nonatomic,copy)NSString *gid;//商品id

@property(nonatomic,copy)NSString *goods_name;//商品名称

@property(nonatomic,copy)NSString *pay_integer;//积分

@property(nonatomic,copy)NSString *pay_maney;//金额

@property(nonatomic,copy)NSString *scopeimg;//图片

@property(nonatomic,copy)NSString *sort_type;//排序

@property(nonatomic,copy)NSString *type;//

@property(nonatomic,copy)NSString *status;//

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *stock;

@property(nonatomic,copy)NSString *storename;

@property(nonatomic,copy)  NSString *attribute;//商品属性；
@end
