//
//  YTDetailViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/9.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YTDetailViewControllerDelegate <NSObject>

-(void)setGoodsPrice:(NSString *)price setGid:(NSString *)gid setSigen:(NSString *)sigen setStorename:(NSString *)storename setLogo:(NSString *)logo setSendWayType:(NSString *)SendWayType setGoodsType:(NSString *)good_type setMoneyType:(NSString *)MoneyType setmid:(NSString *)mid setYunFei:(NSString *)yunfei setPanduan:(NSString *)panduan setNum:(NSString *)num setexchange:(NSString *)exchange setdetailId:(NSString *)detailId setexchange2:(NSString *)exchange2 setYTString:(NSString *)yt;

@end
@interface YTDetailViewController : UIViewController

@property(nonatomic,copy) NSString *gid;

@property(nonatomic,copy) NSString *logo;

@property(nonatomic,copy) NSString *storename;

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

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

@property(nonatomic,strong)UILabel *PayMoneyLabel;

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

@property(nonatomic,copy) NSString *CartString;

@property(nonatomic,copy) NSString *TTTTTT;//是否失效

@property(nonatomic,copy) NSString *amount;//销售总量

@property(nonatomic,copy) NSString *num;//购买数量

@property(nonatomic,copy) NSString *ytString;//购买数量

@property(nonatomic,copy) NSString *pay_money;//小计现金

@property(nonatomic,copy) NSString *pay_integral;//小计积分

@property(nonatomic,copy) NSString *xuanze;//小计积分

@property(nonatomic,copy) NSString *NewGoods_Type;//判断商品类型



@property(nonatomic,copy) NSString *TTTType;//判断商品类型


@property(nonatomic,copy) NSString *Attribute_back;//属性商品判断返回

@property(nonatomic,copy)NSString *YYYYYYY;//判断属性是否为确定按钮

@property(nonatomic,copy)NSString *note;

@property(nonatomic,copy)NSString *ShuXingUnable;//属性选择不可点击

@property(nonatomic,copy)NSString *webString;

@property(nonatomic,copy)NSString *integral_type;//专题积分

@property(nonatomic,copy)NSString *StockString;//库存为0，设置遮罩层2

@property(nonatomic,copy)NSString *MoRenString;//默认选中

@property(nonatomic,copy)NSString *YTGood_type;

@property(nonatomic,copy)NSString *JuHuaShow;

@property(nonatomic,copy)NSString *YTStatus;//判断倒计时失效

@property(nonatomic,copy) NSString *NewHomeString;

@property(nonatomic,copy)NSString *YTAttribute;

@property(nonatomic,weak) id <YTDetailViewControllerDelegate> delegate;

@property (nonatomic, weak) NSIndexPath *m_indexPath;

@property (nonatomic)       BOOL         m_isDisplayed;
@property(nonatomic,strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property(nonatomic,strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
