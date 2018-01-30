//
//  PersonalShoppingSectionHeaderView.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLDingDanModel.h"
@protocol PersonalShoppingSectionHeaderViewDelegate <NSObject>

-(void)checkStoreDetailWithModel:(XLDingDanModel *)model;

@end
@interface PersonalShoppingSectionHeaderView : UITableViewHeaderFooterView


@property (nonatomic,strong)XLDingDanModel *dataModel;
@property (nonatomic,weak)id<PersonalShoppingSectionHeaderViewDelegate> delegate;

@end
