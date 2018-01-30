//
//  FristHomeCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/19.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FristHomeCell : UICollectionViewCell


@property(nonatomic,strong) UIImageView *GoodsImageView;

@property(nonatomic,strong) UILabel *GoodsNameLabel;

@property(nonatomic,strong) UILabel *GoodsPriceLabel;

@property(nonatomic,strong) UILabel *GoodsAmountLabel;

@property(nonatomic,strong) UILabel *StrorenameLabel;

@property(nonatomic,copy) NSString *status;

@property(nonatomic,copy) NSString *stock;

@property(nonatomic,strong) UIImageView *view;
@end
