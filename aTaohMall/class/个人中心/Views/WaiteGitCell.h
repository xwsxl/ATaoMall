//
//  WaiteGitCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaiteGitCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *LogoImageView;

@property (weak, nonatomic) IBOutlet UIButton *ShopNameButton;

@property (weak, nonatomic) IBOutlet UILabel *TypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNumberLabel;//商品数量

@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *AccountNumbersLabel;

@property (weak, nonatomic) IBOutlet UILabel *ZongPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *YunFeiLabel;

@property (weak, nonatomic) IBOutlet UIButton *TuiKuanButton;//退款

@property (weak, nonatomic) IBOutlet UIButton *QueRenShouHuoButton;//确认收货

@property (weak, nonatomic) IBOutlet UILabel *GoodsShuXingLabel;


@property (weak, nonatomic) IBOutlet UILabel *YangGoodsLabel;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@end
