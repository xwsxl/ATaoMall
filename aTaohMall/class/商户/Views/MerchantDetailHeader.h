//
//  MerchantDetailHeader.h
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantDetailHeader : UICollectionReusableView

@property(nonatomic,strong) UIImageView *bgImgView;

@property(nonatomic,strong) UIImageView *logoImgView;

@property(nonatomic,strong) UILabel *ShopNameLabel;

@property(nonatomic,strong) UILabel *ShopIntroduceLabel;

@property(nonatomic,copy)NSString *logoString;

@end
