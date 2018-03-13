//
//  MerchantModel.h
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantModel : NSObject

//商户首页
@property(nonatomic,copy)NSString *click_volume;//进店逛过
@property(nonatomic,copy)NSString *mid;//商户id
@property(nonatomic,copy)NSString *logo;//商户图片
@property(nonatomic,copy)NSString *storename;//商户名称
@property(nonatomic,copy)NSString *gid;
@property(nonatomic,copy)NSString *OneCoordinates;
@property(nonatomic,copy)NSString *scope;//经营范围
@property(nonatomic,copy)NSString *collectionId;


//店铺详情
@property(nonatomic,copy)NSString *HeaderLogo;//店铺头像
@property(nonatomic,copy)NSString *HeaderName;//店铺名
@property(nonatomic,copy)NSString *note;//店铺简介
@property(nonatomic,copy)NSString *HeaderString;//店铺经纬度
@property(nonatomic,copy)NSString *HeaderId;//店铺Id
//店铺商品
@property(nonatomic,copy)NSString *GoodsId;//商品id
@property(nonatomic,copy)NSString *GoodsName;//商品名称
@property(nonatomic,copy)NSString *GoodsPay_integer;//商品积分
@property(nonatomic,copy)NSString *GoodsPay_maney;//商品金钱
@property(nonatomic,copy)NSString *GoodsImg;//商品图片
@property(nonatomic,copy)NSString *Goods_type;//商品类型
@property(nonatomic,copy)NSString *Goods_start;//商品开始时间
@property(nonatomic,copy)NSString *Goods_end;//商品结束时间
@property(nonatomic,copy)NSString *Goods_status;//商品状态
@property(nonatomic,copy)NSString *Goods_amount;//商品付款人数
@property(nonatomic,copy)NSString *Goods_is_attribute;//商品是否为属性商品
@property(nonatomic,copy)NSString *current_time_stamp;

@property(nonatomic,copy)NSString *status;


//地址
@property(nonatomic,copy)NSString *AddressId;//地址id
@property(nonatomic,copy)NSString *coordinates;//地址id

@end
