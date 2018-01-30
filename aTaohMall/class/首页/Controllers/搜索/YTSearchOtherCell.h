//
//  YTSearchOtherCell.h
//  aTaohMall
//
//  Created by JMSHT on 2016/11/28.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchResultModel.h"

@interface YTSearchOtherCell : UITableViewCell


@property(nonatomic,strong)SearchResultModel *model;

@property(strong,nonatomic)UIImageView *GoodsImageView;

@property(strong,nonatomic)UILabel *GoodsNameLabel;

@property(strong,nonatomic)UILabel *GoodsPriceLabel;

@property(strong,nonatomic)UILabel *GoodsAmountLabel;

@property(strong,nonatomic)UILabel *StorenameLabel;

@end
