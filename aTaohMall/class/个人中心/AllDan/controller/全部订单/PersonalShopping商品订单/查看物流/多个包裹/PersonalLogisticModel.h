//
//  PersonalLogisticModel.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PersonalLogisticsDetailModel.h"
@interface PersonalLogisticModel : NSObject
/*
    "scopeimg": "http://image.anzimall.com/union/upload/93e035050005f90a.jpg",
    "logistics_type": "测试  已签收",
    "goods_number": 1,
    "name": "神器排飞机",
    "company": "圆通",
    "waybillnumber": "886339791964326702"
*/

/*
"scopeimg": "http://image.anzimall.com/union/upload/93c1b4c800002f0a.jpg",
"message": "查询成功！",
"logistics_number": "1",
"status": "10000",
"order_batchid": "A202578201708150953907933",
"name": "加湿器迷你加湿器 空气净化器 迷你车载空气加湿器J8的方式弄丢和人覅无耳机覅偶奇偶额发哦后结覅问佛为覅偶见沃尔夫",
"company": "顺丰",
"remark_list": [
{
"time": "2017-08-19 10:51:25",
"status": "在官网\"运单资料&签收图\",可查看签收人信息"
}
],
"waybillnumber": "199161028423"
*/

@property (nonatomic,strong)NSString *scopeimg;
@property (nonatomic,strong)NSString *logistics_type;
@property (nonatomic,strong)NSString *goods_number;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *company;
@property (nonatomic,strong)NSString *waybillnumber;
@property (nonatomic,strong)NSString *logistics_remark;


@property (nonatomic,strong)NSString *logistics_number;
@property (nonatomic,strong)NSString *order_batchid;
@property (nonatomic,strong)NSMutableArray *remark_list;

-(void)remarkListForArray:(NSArray *)arr;


@end
