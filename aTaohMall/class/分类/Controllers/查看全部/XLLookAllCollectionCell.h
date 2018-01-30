//
//  XLLookAllCollectionCell.h
//  aTaohMall
//
//  Created by Hawky on 2018/1/26.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllSingleShoppingModel.h"
@interface XLLookAllCollectionCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *Goods_ImgView;//商品图片

@property(nonatomic,strong) UILabel *Goods_Name;//商品名称

@property(nonatomic,strong) UILabel *Goods_Price;//商品价格

@property(nonatomic,strong) UILabel *Goods_Amount;//商品购买人数

@property(nonatomic,strong) UILabel *Goods_storename;//商品店铺

@property (nonatomic,strong)AllSingleShoppingModel *model;
@end
