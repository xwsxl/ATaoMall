//
//  ZTSelectViewCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTSelectViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *GoodsImageView;

@property(nonatomic,strong) UILabel *GoodsNameLabel;

@property(nonatomic,strong) UILabel *GoodsPriceLabel;

@property(nonatomic,strong) UILabel *StrorenameLabel;

@property(nonatomic,strong) UIImageView *view;

@property(nonatomic,copy) NSString *status;

-(void)StatusString:(NSString *)status Type:(NSString *)stock;

@end
