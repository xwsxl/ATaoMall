//
//  BackCartViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/12/30.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CartNumberDelegate <NSObject>

-(void)ReloadCartNumber;

@end
@interface BackCartViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;//值

@property(nonatomic,copy) NSString *Failure;//是否隐藏失效商品

@property(nonatomic,weak) id <CartNumberDelegate> delegate;


@property(nonatomic,copy) NSString *Attribute_back;

@property(nonatomic,copy) NSString *count;//限购

@property(nonatomic,copy) NSString *StockString;//库存

@property(nonatomic,copy)NSString *ImageString;//图片

@property(nonatomic,copy) NSString *MoneyString;//钱

@property(nonatomic,copy) NSString *IntergelString;//积分

@property(nonatomic,copy) NSString *gid;

@property(nonatomic,copy) NSString *CartString;//购物车件数


@property(nonatomic,copy) NSString *sid;

@property(nonatomic,copy) NSString *tf;

@property(nonatomic,copy) NSString *AttributeString;

@property(nonatomic,copy) NSString *BackString;//商品属性，返回，通知商品详情修改购物车件数

@property(nonatomic,copy) NSString *smallIds;

@property(nonatomic,copy) NSString *good_type;//商品类型

@property(nonatomic,copy) NSString *status;//商品状态

@property(nonatomic,copy) NSString *YTSid;

@property(nonatomic,copy) NSString *BackBack;//反向传值detailId

@property(nonatomic,copy) NSString *YTNumber;

@property(nonatomic,copy) NSString *YTDetailId;

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@end
