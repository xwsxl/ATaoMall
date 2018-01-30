//
//  PersonalShoppingDanCell.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLShoppingModel.h"
@protocol PersonalShoppingDanCellDelegat<NSObject>

-(void)refundSingleShoppingWithModel:(XLShoppingModel *)model Cell:(UITableViewCell *)cell;

@end

@interface PersonalShoppingDanCell : UITableViewCell

@property (nonatomic,strong)UIImageView *storeIV;

@property (nonatomic,strong)UILabel *goodsNameLab;

@property (nonatomic,strong)UILabel *attrbuteLab;

@property (nonatomic,strong)UILabel *priceLab;

@property (nonatomic,strong)UILabel *goodsNumberLab;

@property (nonatomic,strong)UIView *backGroudView;

@property (nonatomic,strong)UIButton *singleRefundBut;

@property (nonatomic,strong)UIImageView *ActivityIV;

@property (nonatomic,strong)UIImageView *refundIV;

@property (nonatomic,strong)UILabel *refundDescLab;

@property (nonatomic,strong)UILabel *totalPriceLab;


@property (nonatomic,strong)XLShoppingModel *DataModel;


@property (nonatomic,weak)id<PersonalShoppingDanCellDelegat> delegate;
-(void)loadData:(XLShoppingModel *)model;


@property (nonatomic,strong)NSString *RefundStr;

@end
