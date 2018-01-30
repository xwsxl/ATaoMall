//
//  PecOrderModel.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/8/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PeccancecyBaseModel.h"

@interface PecOrderModel : PeccancecyBaseModel
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,copy)NSString *userIntegral;
@property(nonatomic,copy)NSString *deductionIntegral;
@property(nonatomic,copy)NSString *fineMoney;
@property(nonatomic,copy)NSString *lateMoney;
@property(nonatomic,copy)NSString *serviceFee;
@end
