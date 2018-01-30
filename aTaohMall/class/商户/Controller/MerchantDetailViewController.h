//
//  MerchantDetailViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MerchantDetailDelegate <NSObject>

//返回商圈刷新数据，进店人数+1
-(void)BackReloadData;

@end
@interface MerchantDetailViewController : UIViewController


@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *NameString;//店铺名

@property(nonatomic,copy)NSString *LogoString;//店铺logo

@property(nonatomic,copy)NSString *TypeString;//店铺类型

@property(nonatomic,copy)NSString *LongString;//店铺距离

@property(nonatomic,copy)NSString *AddressString;//店铺地址

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property(nonatomic,copy)NSString *GetString;//判断来源于几级界面

@property(nonatomic,copy) NSString *mid;

@property(nonatomic,copy) NSString *Logo;

@property(nonatomic,copy) NSString *Type;

@property(nonatomic,copy) NSString *BackString;

@property(nonatomic,weak) id <MerchantDetailDelegate> delegate;

@end
