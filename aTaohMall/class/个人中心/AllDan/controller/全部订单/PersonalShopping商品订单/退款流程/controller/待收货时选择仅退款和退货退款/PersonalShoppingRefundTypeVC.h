//
//  PersonalShoppingRefundTypeVC.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XLShoppingModel.h"

@interface PersonalShoppingRefundTypeVC : UIViewController
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)XLShoppingModel *dataModel;
@property (nonatomic,assign)NSInteger RefundTotalTime;
@property (nonatomic,assign)BOOL QurtAllDan;

@end
