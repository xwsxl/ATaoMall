//
//  PeccDataModel.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/31.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PeccDataModel.h"

@implementation PeccDataModel
-(NSMutableArray *)cityListArr
{
    if (!_cityListArr) {
        _cityListArr=[[NSMutableArray alloc]init];
    }
    return _cityListArr;
}
-(PeccProvinceModel *)model
{
    if (!_model) {
        _model=[[PeccProvinceModel alloc]init];
    }
    return _model;
}
@end
