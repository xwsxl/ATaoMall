//
//  HomeDPListCell.h
//  aTaohMall
//
//  Created by Hawky on 2017/12/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDPModel.h"
@protocol  HomeDPListCellDelegate<NSObject>

@required
-(void)HomeDpButClickWithModel:(HomeDPModel *)model;
-(void)HomeGoodsButClickWithModel:(AllSingleShoppingModel *)model;

@end




@interface HomeDPListCell : UITableViewCell

@property (nonatomic,strong)UIImageView *TitleIV;
@property (nonatomic,strong)UILabel *DPNameLab;
@property (nonatomic,strong)UIImageView *lineIV;
@property (nonatomic,strong)UIButton *DPBut;

@property (nonatomic,strong)UIImageView *shortLineIV;

@property (nonatomic,strong)UIImageView *good1IV;
@property (nonatomic,strong)UIButton *good1But;

@property (nonatomic,strong)UIImageView *good2IV;
@property (nonatomic,strong)UIButton *good2But;

@property (nonatomic,strong)UIImageView *good3IV;
@property (nonatomic,strong)UIButton *good3But;

@property (nonatomic,weak)id<HomeDPListCellDelegate> delegate;
@property (nonatomic,strong)HomeDPModel *DataModel;
@end
