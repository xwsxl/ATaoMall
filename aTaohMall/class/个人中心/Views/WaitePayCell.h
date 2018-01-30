//
//  WaitePayCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitePayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *LogoImageView;//

@property (weak, nonatomic) IBOutlet UIButton *ShopNameButton;//

@property (weak, nonatomic) IBOutlet UILabel *TypeLabel;//

@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;//商品图片

@property (weak, nonatomic) IBOutlet UILabel *GoodsNAmeLabel;//商品名称

@property (weak, nonatomic) IBOutlet UILabel *GoodsNumberLabel;//商品数量

@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;//商品价格

@property (weak, nonatomic) IBOutlet UILabel *AccountNumbersLabel;//账号号码

@property (weak, nonatomic) IBOutlet UILabel *ZongPriceLabel;//总金额

@property (weak, nonatomic) IBOutlet UILabel *YunFeiLabel;//运费

@property (weak, nonatomic) IBOutlet UIButton *ContinuePayButton;//继续付款

@property (weak, nonatomic) IBOutlet UILabel *GoodsShuXingLabel;

@property (weak, nonatomic) IBOutlet UILabel *YangGoodsLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@end
