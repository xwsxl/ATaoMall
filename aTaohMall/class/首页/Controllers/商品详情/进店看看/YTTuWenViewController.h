//
//  YTTuWenViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/9.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTTuWenViewController : UIViewController
@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *storename;

@property(nonatomic,copy)NSString *logo;

@property(nonatomic,copy)NSString *gid;

@property(nonatomic,copy)NSString *note;


@property(nonatomic,copy)NSString *sigen;

@property(nonatomic,copy)NSString *type;//判断返回几级页面
@property(nonatomic,copy)NSString *SendWayType;//传给二级页面

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *scopeimg;

@property(nonatomic,copy) NSString *Good_status;

@property(nonatomic,copy) NSString *stock;//库存

@property(nonatomic,copy)NSString *good_type;

@property(nonatomic,copy)NSString *num;

@property(nonatomic,copy)NSString *mid;

@property(nonatomic,copy)NSString *Panduan;


@property(nonatomic,copy)NSString *detailId;

@property(nonatomic,copy)NSString *detailId2;//当前页面获取的ID


@property(nonatomic,copy)NSString *is_attribute;


@property(nonatomic,copy) NSString *pay_xiaoji;//属性商品小计

@property(nonatomic,copy) NSString *MoneyType;//已选的配送方式（“0”或者“1”）

@property(nonatomic,copy) NSString *exchange;//配送方式；

@property(nonatomic,copy) NSString *NewPrice;//价格；

@property(nonatomic,copy) NSString *pay_integer;//金钱；
@property(nonatomic,copy) NSString *pay_maney;//金钱；

@property(nonatomic,copy) NSString *freight;//运费

@property(nonatomic,copy) NSString *PriceShow;//运费

@property(nonatomic,copy) NSString *ShowString;//运费
@end
