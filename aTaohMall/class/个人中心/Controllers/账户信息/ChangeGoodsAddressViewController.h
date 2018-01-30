//
//  ChangeGoodsAddressViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeGoodsAddressViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *NameTextField;//收货人

@property (weak, nonatomic) IBOutlet UITextField *PhoneTextField;//电话号码

@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;//地址

@property (weak, nonatomic) IBOutlet UITextField *DetailTextField;//详细地址

@property (weak, nonatomic) IBOutlet UISwitch *SettingSwitch;//设为默认开关

@property(nonatomic,copy)NSString *sigens;

@property(nonatomic,copy)NSString *province;//省

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString *defaultstate;

@property(nonatomic,copy) NSString *aid;

@property(nonatomic,copy) NSString *SwitchStatus;//开关状态

@property(nonatomic,copy) NSString *aaid;

@property(nonatomic,copy) NSString *MoRen;
@end
