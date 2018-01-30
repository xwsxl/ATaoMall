//
//  CartDingDanCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CartDingDanCellDelegate <NSObject>
/** 选择配送方式 */

- (void)cellSelectTypeClick:(UIButton *)sender;

@end


@interface CartDingDanCell : UITableViewCell


@property(nonatomic,strong) UIView *GoodsView;

@property(nonatomic,strong) UIImageView *GoodsImg;

@property(nonatomic,strong) UILabel *GoodsNameLab;

@property(nonatomic,strong) UILabel *NewGoodsNameLab;

@property(nonatomic,strong) UILabel *GoodsAttributeLab;

@property(nonatomic,strong) UILabel *GoodsPriceLab;

@property(nonatomic,strong) UILabel *NewGoodsPriceLab;

@property(nonatomic,strong) UILabel *GoodsNumberLab;

@property(nonatomic,strong) UILabel *GoodsType;

@property(nonatomic,strong) UILabel *GoodsKuaiDiLab;

@property(nonatomic,strong) UIImageView *ImgView;

@property(nonatomic,strong) UIButton *SendWayButton;

@property(nonatomic,copy) NSString *Attribute_str;

@property (nonatomic, weak) id<CartDingDanCellDelegate>delegate;

@end
