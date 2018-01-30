//
//  PersonalShoppingSectionFooterView.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLDingDanModel.h"
@protocol PersonalShoppingSectionFooterViewDelegate <NSObject>

-(void)refundMoneyWithModel:(XLDingDanModel *)model;

-(void)continuePayWithModel:(XLDingDanModel *)model;

-(void)checkLogisticInfoWithModel:(XLDingDanModel *)mdoel;

-(void)sureReceiveWithModel:(XLDingDanModel *)model;

-(void)deleteDingDanWithModel:(XLDingDanModel *)model;

-(void)checkDanDetailWithModel:(XLDingDanModel *)model;

@end
@interface PersonalShoppingSectionFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)XLDingDanModel *dataModel;

@property (nonatomic,weak)id<PersonalShoppingSectionFooterViewDelegate> delegate;

@end
