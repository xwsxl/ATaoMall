//
//  PersonalShoppingRefundFooterView.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLDingDanModel.h"

@protocol PersonalShoppingRefundFooterViewDelegate <NSObject>

-(void)checkDetailInfoWithModel:(XLDingDanModel *)mdoel;


@end

@interface PersonalShoppingRefundFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)XLDingDanModel *dataModel;

@property (nonatomic,weak)id<PersonalShoppingRefundFooterViewDelegate> delegate;

@end
