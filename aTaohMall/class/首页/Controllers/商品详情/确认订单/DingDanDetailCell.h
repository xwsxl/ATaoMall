//
//  DingDanDetailCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DingDanDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *LogoImageView;

@property (weak, nonatomic) IBOutlet UIButton *ShopNameButton;

@property (weak, nonatomic) IBOutlet UILabel *GoodsShuXingLabel;//属性

@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *NewGoodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;

@property (weak, nonatomic) IBOutlet UIButton *ReduceButton;

@property (weak, nonatomic) IBOutlet UIButton *AddButton;

@property (weak, nonatomic) IBOutlet UIButton *TypeButton;


@property (weak, nonatomic) IBOutlet UILabel *AmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;


@property (weak, nonatomic) IBOutlet UITextView *WordTextField;


@property (weak, nonatomic) IBOutlet UILabel *MarkLabel;

@property (weak, nonatomic) IBOutlet UIButton *YTReduceButton;

@property (weak, nonatomic) IBOutlet UIButton *YTAddButton;

@property (weak, nonatomic) IBOutlet UITextField *YTNumberTF;

@property (weak, nonatomic) IBOutlet UILabel *YTLabel;

@property (weak, nonatomic) IBOutlet UILabel *YTPeiSonLabel;


@property(nonatomic,copy) NSString *YTCount;//限购数

@end
