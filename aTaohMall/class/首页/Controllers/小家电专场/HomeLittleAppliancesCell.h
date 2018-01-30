//
//  HomeLittleAppliancesCell.h
//  aTaohMall
//
//  Created by DingDing on 2017/10/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLittleAppliancesCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *GoodsImageView;

@property(nonatomic,strong) UILabel *GoodsNameLabel;

@property(nonatomic,strong) UILabel *GoodsPriceLabel;

@property(nonatomic,strong) UILabel *GoodsAmountLabel;

@property(nonatomic,strong) UILabel *StrorenameLabel;

@property(nonatomic,copy) NSString *status;

@property(nonatomic,copy) NSString *stock;

@property(nonatomic,strong) UIImageView *view;
@end
