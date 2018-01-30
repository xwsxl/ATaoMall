//
//  CartChoseView.h
//  aTaohMall
//
//  Created by JMSHT on 2016/12/28.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TypeView.h"
#import "BuyCountView.h"

@interface CartChoseView : UIView<UITextFieldDelegate,UIAlertViewDelegate,TypeSeleteDelegete>


@property(nonatomic, retain)UIView *alphaiView;
@property(nonatomic, retain)UIView *whiteView;

@property(nonatomic, retain)UIImageView *img;

@property(nonatomic, retain)UILabel *lb_price;
@property(nonatomic, retain)UILabel *lb_stock;
@property(nonatomic, retain)UILabel *lb_detail;

@property(nonatomic, retain)UILabel *lb_arr3;
@property(nonatomic, retain)UILabel *lb_arr4;
@property(nonatomic, retain)UILabel *lb_line;

@property(nonatomic, retain)UIScrollView *mainscrollview;

@property(nonatomic, retain)TypeView *sizeView;
@property(nonatomic, retain)TypeView *colorView;

@property(nonatomic, retain)TypeView *arr3View;
@property(nonatomic, retain)TypeView *arr4View;
@property(nonatomic, retain)BuyCountView *countView;

@property(nonatomic, retain)UIButton *bt_sure;
@property(nonatomic, retain)UIButton *bt_cancle;

@property(nonatomic)NSArray *sizearr;
@property(nonatomic)NSArray *colorarr;
@property(nonatomic)NSArray *arr3;
@property(nonatomic)NSArray *arr4;
@property(nonatomic)NSArray *arr5;
@property(nonatomic)NSDictionary *stockdic;
@property(nonatomic) int stock;//库存

@property(nonatomic,copy) NSString *ShuXingString;//属性

@property(nonatomic,copy) NSString *pay_money;//现金

@property(nonatomic,copy) NSString *user_amount;//user_amount

@property(nonatomic,copy) NSString *pay_integral;//积分

@property(nonatomic,copy) NSString *exchange;//配送方式；

@property(nonatomic,copy) NSString *detailId;//属性商品ID

@property(nonatomic,copy) NSString *count;//商品是否限购

@property(nonatomic,copy) NSString *amount;//销售总量

@property(nonatomic,copy) NSString *num;//购买数量；

@property(nonatomic,copy) NSString *yunfei;

@property(nonatomic,copy) NSString *gid1;

@property(nonatomic,copy) NSString *yangtao;

@property(nonatomic,copy) NSString *userId;

@property(nonatomic,copy) NSString *Goods_type;
@property(nonatomic,copy) NSString *Goods_status;

@property(nonatomic,copy) NSString *string;
@property(nonatomic,copy) NSString *string1;
@property(nonatomic,copy) NSString *string5;
@property(nonatomic,copy) NSString *string6;


@property(nonatomic,copy) NSString *YTLogo;//配送方式；

@property(nonatomic,copy) NSString *YTOrderno;//配送方式；

@property(nonatomic,copy) NSString *YTStorename;//配送方式；

@property(nonatomic,copy) NSString *bPandun;//购买数量；

-(void)initTypeView:(NSArray *)sizeArr :(NSArray *)colorArr :(NSArray*)Arr3 :(NSArray*)Arr4:(NSArray*)Arr5:(NSDictionary *)stockDic andGoodsImageView:(NSString *)imgStr andMoney:(NSString *)money andJiFen:(NSString *)jifen andKuCun:(NSString *)kucun andCount:(NSString*)count andGoods_type:(NSString *)type andStatus:(NSString *)status andGid:(NSString *)gid andYTBack:(NSString *)ytback angCut:(NSString *)cut;


@end
