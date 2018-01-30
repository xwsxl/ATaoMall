//
//  CartAddressCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartAddressCell : UITableViewCell


@property(nonatomic,strong) UILabel *Name;//收货人

@property(nonatomic,strong) UILabel *Phone;//收货人电话

@property(nonatomic,strong) UILabel *Address;//地址

@property(nonatomic,strong) UIImageView *ImgView;//箭头

@property(nonatomic,strong) UIView *RedView;//

@property(nonatomic,strong) UILabel *ShuoMingLabel;//请先添加收货地址

@property(nonatomic,strong) NSArray *AddressArray;

@property(nonatomic,copy) NSString *UserType;//

@end
