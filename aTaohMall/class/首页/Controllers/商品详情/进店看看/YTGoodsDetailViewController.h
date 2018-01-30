//
//  YTGoodsDetailViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/9.
//  Copyright © 2016年 ysy. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface YTGoodsDetailViewController : UIViewController

@property(nonatomic,copy) NSString *gid;

@property(nonatomic,copy) NSString *ID;

@property(nonatomic,copy) NSString *type;

@property(nonatomic,copy) NSString *attribute;

@property(nonatomic,copy) NSString *Attribute_back;

@property(nonatomic,copy) UILabel *price;

@property(nonatomic,copy) UIButton *button;

@property(nonatomic,copy) NSString *logo;

@property(nonatomic,copy) NSString *storename;

@property(nonatomic,copy) NSString *NewHomeString;


//判断是否显示倒计时
@property(nonatomic,copy)NSString *good_type;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *sigen;

@property(nonatomic,copy)NSString *HoldOn;

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

@property(nonatomic,copy)NSString *JuHuaShow;//菊花显示

@property(nonatomic,copy)NSString *CartString;

@property(nonatomic,copy)NSString *ytBack;

@property(nonatomic,copy) NSString *exchange;//配送方式；

@property(nonatomic,copy) NSString *exchange2;//配送方式(首次获取)

@property(nonatomic,copy) NSString *detailId;//属性商品ID

@property(nonatomic,copy) NSString *count;//属性商品是否限购；

@property(nonatomic,copy) NSString *MoneyType;//已选的配送方式（“0”或者“1”）

@property(nonatomic,copy) NSString *yunfei;

@property(nonatomic,copy) NSString *TTTTTT;

@property(nonatomic,copy) NSString *amount;//销售总量

@property(nonatomic,copy) NSString *num;//购买数量

@property(nonatomic,copy) NSString *pay_money;//小计现金

@property(nonatomic,copy) NSString *pay_integral;//小计积分

@property(nonatomic,strong)UIView *view1;

@property(nonatomic,copy) NSString *ytString;

@property(nonatomic,copy) NSString *caonima;//小计积分

@property(nonatomic,assign)NSInteger tag0;

@property(nonatomic,assign)NSInteger tag1; //待付款按钮的tag值

@end
