//
//  AllDingDanCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllDingDanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *LogoImageView;

@property (weak, nonatomic) IBOutlet UIButton *ShopNameButton;

@property (weak, nonatomic) IBOutlet UILabel *TypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (weak, nonatomic) IBOutlet UILabel *GoodsCountLabel;//共几件商品

@property (weak, nonatomic) IBOutlet UILabel *AllMoneyLabel;//合计

@property (weak, nonatomic) IBOutlet UILabel *YunFeiLabel;//运费


@property (weak, nonatomic) IBOutlet UILabel *GoodsShuXingLabel;

@property (weak, nonatomic) IBOutlet UILabel *YangGoodsLabel;

@end
