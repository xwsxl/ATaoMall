//
//  CartDingDanFooter.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CartGoodsModel.h"
@class CartGoodsModel;

@protocol CartDingDanFooterDelegate <NSObject>

/** footer合计金额计算 */
- (void)footerCountMoney:(UILabel *)Money;


/*   买家留言  */

-(void)UserShoppingWords:(UITextView *)Word;

@end


@interface CartDingDanFooter : UITableViewHeaderFooterView


@property (nonatomic,strong) UIView *WordView;

@property(nonatomic,strong) UILabel *WordLab;

@property(nonatomic,strong) UITextView *WordTF;

@property(nonatomic,strong) UIImageView *Line;

@property(nonatomic,strong) UIView *HejiView;

@property(nonatomic,strong) UILabel *HeJiLabel;

@property(nonatomic,strong) UILabel *DuiHuanLab;

@property(nonatomic,strong) CartGoodsModel *goods;

@property(nonatomic,strong) NSArray *goodsArray;

/** 设置选择按钮的tag */
@property (nonatomic, assign) NSInteger footViewTag;


@property (nonatomic, weak)  id<CartDingDanFooterDelegate>delegate;

@end
