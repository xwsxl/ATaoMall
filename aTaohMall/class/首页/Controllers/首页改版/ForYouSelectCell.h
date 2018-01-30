//
//  ForYouSelectCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForYouSelectCell : UITableViewCell

@property(nonatomic,strong) UIImageView *GoodsImgView;

@property(nonatomic,strong) UILabel *GoodsNameLabel;

@property(nonatomic,strong) UILabel *GoodsPriceLabel;

@property(nonatomic,strong) UILabel *GoodsStoreNameLabel;

@property(nonatomic,strong) UILabel *GoodsAmountLabel;

@property(nonatomic,copy) NSString *amount;

@property(nonatomic,copy) NSString *Price;

@property(nonatomic,strong) UIImageView *view;

-(void)StatusString:(NSString *)status Type:(NSString *)type;

@end
