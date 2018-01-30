//
//  FailureAttributeCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/2/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopModel.h"


@class ShopModel;

@interface FailureAttributeCell : UITableViewCell


@property(nonatomic,strong) UIButton *SelectButton;

@property(nonatomic,strong) UIImageView *LogoImgView;

@property(nonatomic,strong) UILabel *GoodsNameLabel;

@property(nonatomic,strong) UILabel *AttributeLabel;

@property(nonatomic,strong) UIImageView *line;

@property(nonatomic,strong) UILabel *PriceLabel;//有属性价格

@property(nonatomic,strong) UILabel *NewPriceLabel;//无属性价格

@property(nonatomic,strong) UILabel *NumberLabel;

@property(nonatomic,strong) UILabel *NewNumberLabel;

@property(nonatomic,copy) NSString *YTString;//判断价格隐藏

//从外部传入model
@property(nonatomic, strong)ShopModel *model;


@end
