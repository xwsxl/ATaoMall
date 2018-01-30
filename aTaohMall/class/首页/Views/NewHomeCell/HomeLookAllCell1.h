//
//  HomeLookAllCell1.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/15.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLookAllCell1 : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *StorenameLabel;

@property(nonatomic,copy) NSString *status;

@end
