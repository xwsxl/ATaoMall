//
//  PersonalShoppingDandetailFooterView.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalShoppingDanDetailModel.h"
@protocol PersonalShoppingDandetailFooterViewDelegate <NSObject>

-(void)refundMoneyWithModel:(PersonalShoppingDanDetailModel *)model;

-(void)continuePayWithModel:(PersonalShoppingDanDetailModel *)model;

-(void)checkLogisticInfoWithModel:(PersonalShoppingDanDetailModel *)mdoel;

-(void)sureReceiveWithModel:(PersonalShoppingDanDetailModel *)model;

@end

@interface PersonalShoppingDandetailFooterView : UITableViewHeaderFooterView

-(void)loadData:(PersonalShoppingDanDetailModel *)model;

@property (nonatomic,weak) id<PersonalShoppingDandetailFooterViewDelegate> delegate;
@end
