//
//  MerchantCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantCell : UITableViewCell

@property(nonatomic,strong) UIImageView *ShopImgView;//商户图片

@property(nonatomic,strong) UILabel *ShopNameLabel;//商户名称

@property(nonatomic,strong) UILabel *ShopTypeLabel;//商户类型

@property(nonatomic,strong) UIImageView *LookImgView;//进店看看图标

@property(nonatomic,strong) UILabel *NumberLabel;//进店看看人数

@end
