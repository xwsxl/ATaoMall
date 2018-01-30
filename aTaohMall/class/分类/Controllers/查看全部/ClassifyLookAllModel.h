//
//  ClassifyLookAllModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/21.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyLookAllModel : NSObject


@property(nonatomic,copy)NSString *amount;//付款人数

@property(nonatomic,copy)NSString *good_type;//商品类型

@property(nonatomic,copy)NSString *id;//商品id

@property(nonatomic,copy)NSString *name;//商品名称

@property(nonatomic,copy)NSString *pay_integer;// 积分

@property(nonatomic,copy)NSString *pay_maney;// 价格

@property(nonatomic,copy)NSString *scopeimg;// 商品图片

@property(nonatomic,copy)NSString *tid;//

@property(nonatomic,copy)NSString *total_price;// 总价格

@property(nonatomic,copy)NSString *storename;

@property(nonatomic,copy)NSString *type;// 发货状态

@end
