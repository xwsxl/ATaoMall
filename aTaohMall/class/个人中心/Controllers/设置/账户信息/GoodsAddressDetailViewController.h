//
//  GoodsAddressDetailViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ReshDataDelegate1 <NSObject>

-(void)reshData1;

@end

@interface GoodsAddressDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;//收货人

@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;//手机号码

@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;//所在地址


@property (weak, nonatomic) IBOutlet UILabel *DetailLabel;//详细地址

@property(nonatomic,copy)NSString *aid;//获取详细地址id

@property(nonatomic,copy)NSString *defaultstate;//是否为默认地址
@property(nonatomic,copy)NSString *sigens;

@property(nonatomic,weak)id <ReshDataDelegate1> delegate;//代理对象
@end
