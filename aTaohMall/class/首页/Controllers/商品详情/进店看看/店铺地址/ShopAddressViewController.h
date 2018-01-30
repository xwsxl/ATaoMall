//
//  ShopAddressViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopAddressViewController : UIViewController

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *coordinates;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString *province;

@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;

@property(nonatomic,copy)NSString *JinDu;

@property(nonatomic,copy)NSString *WeiDu;

@property(nonatomic,copy)NSString *mid;
@end
