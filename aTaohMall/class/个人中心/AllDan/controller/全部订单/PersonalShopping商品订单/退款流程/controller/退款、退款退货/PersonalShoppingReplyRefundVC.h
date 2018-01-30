//
//  PersonalShoppingReplyRefundVC.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLShoppingModel.h"

@interface PersonalShoppingReplyRefundVC : UIViewController

@property (nonatomic,strong)XLShoppingModel *dataModel;
@property (nonatomic,strong)UITapGestureRecognizer *tap;
//refundOnly,refundShopAndMoney
@property (nonatomic,strong)NSString *refundType;

@property (nonatomic,assign)BOOL QurtAllDan;

-(void)setDataModel:(XLShoppingModel *)dataModel AndRefundType:(NSString *)refundType andRefundTime:(NSInteger )refundTotalTime andQurtAllDan:(BOOL)qurtAllDan;

@end
