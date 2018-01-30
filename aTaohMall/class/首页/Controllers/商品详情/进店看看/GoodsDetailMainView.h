//
//  GoodsDetailMainView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/4/18.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailView.h"
//#import "BottomView.h"
#import "ChoseView.h"
#import "NewGoodsDetailViewController.h"

#import "NewLoginViewController.h"

#import "CartChoseView.h"


@protocol ChangeAttributeDelegate <NSObject>

-(void)ChangeAttributeDelegateClick:(NSString *)detailId andSid:(NSString *)sid andTf:(NSString *)tf andStock:(NSString *)stock andTitle:(NSString *)title andYYYYY:(NSString *)yyyyy andSmallId:(NSString *)smalls;

-(void)ChangeAttributeBackDelegate;

@end
@interface GoodsDetailMainView : UIView<UITextFieldDelegate,LoginMessageDelegate>
{
    CGPoint center;
}
@property(nonatomic, retain)GoodsDetailView *goodsDetail;//详情页所需对象
//@property(nonatomic, retain)BottomView *bottomView;
@property(nonatomic, retain)ChoseView *choseView;//尺寸选择所需对象

@property(nonatomic, retain)CartChoseView *cartchoseView;//尺寸选择所需对象

@property(nonatomic, weak)NewGoodsDetailViewController *vc;
@property(nonatomic, retain)NSString *gid;

@property(nonatomic, retain)NSString *mid;//商户id

@property(nonatomic, retain)NSString *storename;

@property(nonatomic, retain)NSString *yunfei;

@property(nonatomic, retain)NSString *logo;

@property(nonatomic, retain)NSString *SendWayType;

@property(nonatomic, retain)NSString *good_type;

@property(nonatomic, retain)NSString *MoneyType;

@property(nonatomic, retain)NSString *num;

@property(nonatomic, retain)NSString *CartString;//判断是否点击的是加入购物车

@property(nonatomic, retain)NSString *NewGoods_Type;//商品类型

@property(nonatomic,copy) NSString *exchange;//配送方式；

@property(nonatomic,copy) NSString *detailId;//属性商品ID

@property(nonatomic, retain)NSString *count;//属性商品是否限购

@property(nonatomic, retain)NSString *user_amount;//属性商品是否限购

@property(nonatomic, retain)NSString *ShuXingString;

@property(nonatomic, retain)NSString *userId;

@property(nonatomic, retain)NSString *sigen;

@property(nonatomic, retain)NSString *sid;

@property(nonatomic, retain)NSString *tf;

@property(nonatomic, retain)NSString *back;

@property(nonatomic, retain)NSString *yang_str;

@property(nonatomic,copy) NSString *Attribute_back;//属性商品判断返回

@property(nonatomic,copy)NSString *YTSting;

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property(nonatomic,copy)NSString *YTBackString;//判断返回界面

@property(nonatomic,copy) NSString *NotBuy;

@property(nonatomic,copy) NSString *NewHomeString;

@property(nonatomic,copy) NSString *NotBuyMessage;

@property(nonatomic,copy) NSString *YTStatus;

@property(nonatomic,copy) NSString *stock;

@property(nonatomic,copy) NSString *Goods_Type_Switch;

@property(nonatomic,copy) NSString *Good_status;

@property(nonatomic,weak) id <ChangeAttributeDelegate> delegate;


//-(void)initChoseViewSizeArr:(NSArray *)sizeArr andColorArr:(NSArray *)colorArr andStockDic:(NSDictionary *)stockDic;
//原先属性逻辑
-(void)initChoseViewSizeArr:(NSArray *)sizeArr andColorArr:(NSArray *)colorArr andArr3:(NSArray *)Arr3 andArr4:(NSArray *)Arr4 andArr5:(NSArray *)Arr5 andStockDic:(NSDictionary *)stockDic andGoodsImageView:(NSString *)imgStr andMoney:(NSString *)money andJIFen:(NSString *)jifen andKuCun:(NSString *)kucun andGid:(NSString*)gid andcount:(NSString*)count andGoods_type:(NSString *)goods_type andGoods_status:(NSString *)status andback:(NSString*)Attribute_back andYTBack:(NSString *)ytback andMid:(NSString *)mid andYYYY:(NSString *)yyyyyy andSmallIds:(NSString *)smallIds andStorename:(NSString *)storename andLogo:(NSString *)logo andSendWayType:(NSString *)sendWayType andMoneyType:(NSString *)MoneyType andSid:(NSString *)sid andTf:(NSString *)tf andCut:(NSString *)cut andJinDu:(NSString *)jindu andWeiDu:(NSString *)weidu andAddressString:(NSString *)mapaddress andNewHomeString:(NSString *)NewHomeString;

//加如购物车

-(void)initCartChoseViewSizeArr:(NSArray *)sizeArr andColorArr:(NSArray *)colorArr andArr3:(NSArray *)Arr3 andArr4:(NSArray *)Arr4 andArr5:(NSArray *)Arr5 andStockDic:(NSDictionary *)stockDic andGoodsImageView:(NSString *)imgStr andMoney:(NSString *)money andJIFen:(NSString *)jifen andKuCun:(NSString *)kucun andGid:(NSString*)gid andcount:(NSString*)count andGoods_type:(NSString *)goods_type andGoods_status:(NSString *)status andback:(NSString*)Attribute_back andYTBack:(NSString *)ytback;

-(void)initDetailViewImgArr:(NSArray *)imgarr andWebArr:(NSArray *)webarr;
-(void)initBottomView;
-(void)show;

-(void)Cartshow;

-(void)dismiss;
@end
