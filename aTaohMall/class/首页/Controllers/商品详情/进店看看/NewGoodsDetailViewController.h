//
//  NewGoodsDetailViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGoodsDetailViewController : UIViewController

@property(nonatomic,copy) NSString *gid;

@property(nonatomic,copy) NSString *logo;

@property(nonatomic,copy) NSString *storename;

@property (weak, nonatomic) IBOutlet UILabel *PayMoneyLabel;


//判断是否显示倒计时
@property(nonatomic,copy)NSString *good_type;
@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *sigen;

@property(nonatomic,copy)NSString *type;//判断返回几级页面
@property(nonatomic,copy)NSString *SendWayType;//传给二级页面

@property(nonatomic,copy) NSString *startString;

@property(nonatomic,copy) NSString *endString;

@property(nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,copy) NSString *String;//判断图文详情按钮是否可以点击


@property(nonatomic,copy) NSString *Good_status;

@property(nonatomic,copy) NSString *stock;//库存

@property(nonatomic,copy) NSString *mid;

@property(nonatomic,copy) NSString *NotBuy;

@property(nonatomic,copy) NSString *NotBuyMessage;

@property(nonatomic,weak) NSString *Panduan;

@property(nonatomic,copy) NSString *YXZattribute;

@property(nonatomic,copy)  NSString *attribute;//商品属性；

@property(nonatomic,copy) NSString *exchange;//配送方式；

@property(nonatomic,copy) NSString *exchange2;//配送方式(首次获取)

@property(nonatomic,copy) NSString *detailId;//属性商品ID

@property(nonatomic,copy) NSString *count;//属性商品是否限购；

@property(nonatomic,copy) NSString *MoneyType;//已选的配送方式（“0”或者“1”）

@property(nonatomic,copy) NSString *yunfei;

@property(nonatomic,copy) NSString *amount;//销售总量

@property(nonatomic,copy) NSString *num;//购买数量

@property(nonatomic,copy) NSString *pay_money;//小计现金

@property(nonatomic,copy) NSString *pay_integral;//小计积分


@property(nonatomic,copy) NSString *Attribute_back;//属性商品判断返回

@end
