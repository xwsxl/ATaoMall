//
//  XLGoodsCollectionCell.h
//  aTaohMall
//
//  Created by Hawky on 2018/3/9.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllSingleShoppingModel.h"
@interface XLGoodsCollectionCell : UITableViewCell

@property (nonatomic,strong)UIImageView *shopIV;
@property (nonatomic,strong)UIImageView *unusedIV;
@property (nonatomic,strong)UILabel *goodsNameLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)UIButton *selectBut;

@property (nonatomic,strong)AllSingleShoppingModel *dataModel;

@property (nonatomic,assign)BOOL isEdit;

@end
