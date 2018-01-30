//
//  PersonalBMDanCell.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/29.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMDanModel.h"

@protocol PersonalBMDanCellDelegate<NSObject>

-(void)CheckMerchantDetailWithModel:(BMDanModel *)model;

-(void)CheckBMDanDetailWithModel:(BMDanModel *)model;

-(void)ContinuePayWithModel:(BMDanModel *)model;

-(void)RefundMoneyWithModel:(BMDanModel *)model;

@end

@interface PersonalBMDanCell : UITableViewCell


@property (nonatomic,weak)id<PersonalBMDanCellDelegate> delegate;

-(void)loadDataWithModel:(BMDanModel *)model;

@end
