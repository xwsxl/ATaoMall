//
//  TuWenViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuWenViewController : UIViewController


@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *storename;

@property(nonatomic,copy)NSString *logo;

@property(nonatomic,copy)NSString *gid;

@property(nonatomic,copy)NSString *note;

@property(nonatomic,copy)NSString *NotBuy;

@property(nonatomic,copy)NSString *NotBuyMessage;

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

@property(nonatomic,copy) NSString *NewHomeString;

@property(nonatomic,copy)NSString *detailId;

@property(nonatomic,copy)NSString *detailId2;//当前页面获取的ID

@property (weak, nonatomic) IBOutlet UIButton *NowBuyButton;

@property(nonatomic,copy)NSString *is_attribute;

@property (weak, nonatomic) IBOutlet UILabel *XiaoJiLabel;//小计

@property(nonatomic,copy) NSString *pay_xiaoji;//属性商品小计

@property(nonatomic,copy) NSString *MoneyType;//已选的配送方式（“0”或者“1”）

@property(nonatomic,copy) NSString *exchange;//配送方式；

@property(nonatomic,copy) NSString *ytString;//判断是否选择了商品属性；

@property(nonatomic,copy) NSString *count;//属性商品是否限购；

@property(nonatomic,copy) NSString *Attribute_back;//属性商品判断返回

@property(nonatomic,copy) NSString *caonima;//小计积分

@property(nonatomic,copy) NSString *NewGoods_Type;//判断商品类型

@property(nonatomic,copy)NSString *YYYYYYY;//判断属性是否为确定按钮

@property(nonatomic,copy)  NSString *attribute;//商品属性；

@property(nonatomic,copy) NSString *yunfei;

@property(nonatomic,copy) NSString *TTTTTTT;//是否失效

@property(nonatomic,copy) NSString *amount;//销售总量

@property(nonatomic,copy) NSString *pay_money;//小计现金

@property(nonatomic,copy) NSString *pay_integral;//小计积分

@property(nonatomic,copy) NSString *YXZattribute;

@property(nonatomic,copy)NSString *yyBack;

@property(nonatomic,copy)NSString *YTStock;//属性商品返回库存

@property(nonatomic,copy)NSString *YTStatus;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property(nonatomic,copy)NSString *YTBackString;//判断返回界面

//@property(nonatomic,copy) NSString *num;//购买数量

@end
