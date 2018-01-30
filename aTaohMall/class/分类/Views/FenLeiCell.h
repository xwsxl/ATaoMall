//
//  FenLeiCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FenLeiCell : UITableViewCell

@property(nonatomic,strong) UIImageView *LogoImgView;

@property(nonatomic,strong) UIImageView *NoImgView;

@property(nonatomic,strong) UILabel *NameLabel;

@property(nonatomic,strong) UILabel *StoreLabel;

@property(nonatomic,strong) UILabel *PriceLabel;

@property(nonatomic,strong) UILabel *AmountLabel;

@property(nonatomic,copy) NSString *Status;

@property(nonatomic,copy) NSString *stock;

@property(nonatomic,assign) NSInteger heinht1;

@property(nonatomic,assign) NSInteger heinht2;

-(void)Status:(NSString *)status Stock:(NSString *)stock;

@end
