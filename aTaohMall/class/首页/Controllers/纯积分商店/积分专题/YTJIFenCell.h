//
//  YTJIFenCell.h
//  aTaohMall
//
//  Created by JMSHT on 2016/11/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTJIFenCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *GoosImageView;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *AmountLabel;

//@property (weak, nonatomic) IBOutlet UIImageView *NoBuyImageView;

@property(strong,nonatomic)UIImageView *NoBuyImageView;

@property (weak, nonatomic) IBOutlet UILabel *StorenameLabel;

@end
