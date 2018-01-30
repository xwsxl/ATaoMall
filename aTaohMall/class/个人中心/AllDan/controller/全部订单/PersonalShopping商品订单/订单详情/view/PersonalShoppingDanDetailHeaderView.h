//
//  PersonalShoppingDanDetailHeaderView.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PersonalShoppingDanDetailModel.h"
#import "PersonalShoppingSectionHeaderView.h"
#import "PersonalShoppingSectionHeaderView.h"
#import "XLDingDanModel.h"
@protocol PersonalShoppingDanDetailHeaderViewDelegate<NSObject>

-(void)checkStoreDetailWithModel:(PersonalShoppingDanDetailModel *)model;

-(void)checkLogisticsInfoWithModel:(PersonalShoppingDanDetailModel *)model;

@end
@interface PersonalShoppingDanDetailHeaderView : UITableViewHeaderFooterView

@property (nonatomic,weak)id<PersonalShoppingDanDetailHeaderViewDelegate> delegate;
-(void)loadData:(PersonalShoppingDanDetailModel *)model;

@end
