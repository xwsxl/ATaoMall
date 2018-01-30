//
//  ClassifyControllectionCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyControllectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;//商品图片

@property (weak, nonatomic) IBOutlet UILabel *goodsLabel;//商品介绍

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;//价格

@property (weak, nonatomic) IBOutlet UILabel *payLabel;//付款人数

@property (weak, nonatomic) IBOutlet UILabel *StroenameLabel;


@end
