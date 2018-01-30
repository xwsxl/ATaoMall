//
//  PeccDataModel.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/31.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PeccancecyBaseModel.h"
#import "PeccProvinceModel.h"
@interface PeccDataModel : PeccancecyBaseModel
@property(nonatomic,strong)NSMutableArray *cityListArr;
@property(nonatomic,strong)PeccProvinceModel *model;
@end
