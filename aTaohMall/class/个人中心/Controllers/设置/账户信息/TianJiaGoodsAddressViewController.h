//
//  TianJiaGoodsAddressViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/4.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ReshDataDelwgate <NSObject>

-(void)reshData;

@end
@interface TianJiaGoodsAddressViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *NameTextField;//收货人姓名


@property (weak, nonatomic) IBOutlet UITextField *PhoneTextField;//手机号码

@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;//收货地址

@property (weak, nonatomic) IBOutlet UITextField *DetailTextField;//详细地址

@property (weak, nonatomic) IBOutlet UISwitch *SettingSwitch;//设置按钮

@property(nonatomic,copy)NSString *sigens;

@property(nonatomic,copy)NSString *province;//省

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString *defaultstate;


@property(nonatomic,weak)id <ReshDataDelwgate> delegate;//代理对象
@end
