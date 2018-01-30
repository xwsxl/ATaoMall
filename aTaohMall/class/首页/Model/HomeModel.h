//
//  HomeModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/31.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property(nonatomic,copy)NSString *carousel_figure;//滚动图片

@property(nonatomic,copy)NSString *gid;//id

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *level;//

@property(nonatomic,copy)  NSString *attribute;//商品属性


@property(nonatomic,copy)NSString *ID;//id
@property(nonatomic,copy)NSString *pay_integer;//id
@property(nonatomic,copy)NSString *integral_type;
@property(nonatomic,copy)NSString *pay_maney;
@property(nonatomic,copy)NSString *scopeimg;//id
@property(nonatomic,copy)NSString *stock;//id

@property(nonatomic,copy)NSString *special_name;//id
@property(nonatomic,copy)NSString *subtitle;//id
@property(nonatomic,copy)NSString *picpath;//id
@property(nonatomic,copy)NSString *status;//id
@property(nonatomic,copy)NSString *logo;//id
@property(nonatomic,copy)NSString *title;//id
@property(nonatomic,copy)NSString *click_volume;//id
@property(nonatomic,copy)NSString *storename;//id
@property(nonatomic,copy)NSString *mid;//id
@property(nonatomic,strong)NSArray *array;//id

//小家电
@property (nonatomic,strong)NSString *start_time;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *is_attribute;
@property (nonatomic,strong)NSString *good_type;
@end
