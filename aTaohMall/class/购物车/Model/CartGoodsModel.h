//
//  CartGoodsModel.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartGoodsModel : NSObject


@property(nonatomic,copy) NSString *attribute_str;

@property(nonatomic,copy) NSString *detailId;

@property(nonatomic,copy) NSString *exchange;

@property(nonatomic,copy) NSString *exchange_type;

@property(nonatomic,copy) NSString *freight;

@property(nonatomic,copy) NSString *good_type;//商品类型

@property(nonatomic,copy) NSString *gid;

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *number;

@property(nonatomic,copy) NSString *pay_integer;

@property(nonatomic,copy) NSString *pay_maney;

@property(nonatomic,copy) NSString *scopeimg;

@property(nonatomic,copy) NSString *sid;

@end
