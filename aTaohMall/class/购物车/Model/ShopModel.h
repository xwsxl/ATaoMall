//
//  ShopModel.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject

@property(nonatomic,copy) NSString *attribute_str;//判断是否有属性,2为属性商品

@property(nonatomic,copy) NSString *count;//商品限购

@property(nonatomic,copy) NSString *detailId;//商品属性id

@property(nonatomic,copy) NSString *exchange_type;//兑换方式

@property(nonatomic,copy) NSString *gid;//商品id

@property(nonatomic,copy) NSString *good_type;//商品类型

@property(nonatomic,copy) NSString *mid;//商户id

@property(nonatomic,copy) NSString *YYYYYYYYY;//商户id

@property(nonatomic,copy) NSString *TTTTTTTTT;//商户id

@property(nonatomic,copy) NSString *name;//商品名称

@property(nonatomic,copy) NSString *EditChangeString;//记录编辑需要修改的信息

@property(nonatomic,copy) NSString *EditChangeAttribute;//记录编辑需要修改的信息

@property(nonatomic,copy) NSString *smallIds;//商品组合id

@property(nonatomic,copy) NSString *number;//商品数量

@property(nonatomic,copy) NSString *pay_integer;//单间商品积分

@property(nonatomic,copy) NSString *attribute;//是否有属性

@property(nonatomic,copy) NSString *pay_maney;//单件商品金额

@property(nonatomic,copy) NSString *scopeimg;//商品图片

@property(nonatomic,copy) NSString *status;//商品状态 

@property(nonatomic,copy) NSString *status1;//在购物车是否失效 1失效 0有效

@property(nonatomic,copy) NSString *stock;//库存

@property(nonatomic,copy) NSString *sid;//加入购物车商品id

/** 记录选中状态 */
@property (nonatomic, assign) BOOL selectState;
/** 记录删除按钮状态 */
@property (nonatomic, assign) BOOL deleteBtnState;
/** 记录单元格的编辑状态 */
@property (nonatomic, assign) BOOL cellEditState;

@end
