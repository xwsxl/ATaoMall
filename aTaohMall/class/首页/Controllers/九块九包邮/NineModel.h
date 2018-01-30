//
//  NineModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/30.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NineModel : NSObject

@property(nonatomic,copy)NSString *amount;//付款人数

@property(nonatomic,copy)NSString *gid;//商品id

@property(nonatomic,copy)NSString *money;//价格

@property(nonatomic,copy)NSString *name;//商品名称

@property(nonatomic,copy)NSString *picture_address;//商品图片

@property(nonatomic,copy)NSString *product_address;

@property(nonatomic,copy)NSString *type_name;

@property(nonatomic,copy)NSString *tid;

@property(nonatomic,copy)  NSString *attribute;//商品属性

@property(nonatomic,copy)NSString *storename;

@end
