//
//  XLShoppingModel.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLShoppingModel : NSObject

@property (nonatomic,strong)NSString *attribute_str;
@property (nonatomic,strong)NSString *count;
@property (nonatomic,strong)NSString *detailId;
@property (nonatomic,strong)NSString *gid;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *mid;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *number;

@property (nonatomic,strong)NSString *order_type;
@property (nonatomic,strong)NSString *order_no;
@property (nonatomic,strong)NSString *pay_integer;
@property (nonatomic,strong)NSString *pay_money;
@property (nonatomic,strong)NSString *payinteger;
@property (nonatomic,strong)NSString *paymoney;
@property (nonatomic,strong)NSString *scopeimg;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *stocks;
@property (nonatomic,strong)NSString *totalfreight;
@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *order_batchid;
@property (nonatomic,strong)NSString *dingDanType;



@property (nonatomic,strong)NSString *refund_batchid;
@property (nonatomic,strong)NSString *goodsCount;
//total_money  total_integral
@property (nonatomic,strong)NSString *total_money;
@property (nonatomic,strong)NSString *total_integral;
@property (nonatomic,strong)NSString *discount_integral;

//退款列表状态
@property (nonatomic,assign)BOOL showBottom;


@property (nonatomic,strong)NSString *refund_count;
@property (nonatomic,strong)NSString *return_goods_count;

@property (nonatomic,strong)NSString *totalStatus;

//生成时间
@property (nonatomic,strong)NSString *getdate;

@property (nonatomic,assign)BOOL isSingle;

/**
 Description 单元格
 */
@property (nonatomic)       CGFloat              cellHeight;



@end
