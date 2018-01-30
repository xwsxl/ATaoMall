//
//  PersonalLogisticModel.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalLogisticModel.h"

@implementation PersonalLogisticModel

-(NSMutableArray *)remark_list
{
    
    if (!_remark_list) {
        _remark_list=[NSMutableArray new];
    }
    return _remark_list;
}

-(void)remarkListForArray:(NSArray *)arr
{
    [_remark_list removeAllObjects];
    if ([arr isEqual:[[NSNull alloc] init] ]) {
        return;
    }
    for (NSDictionary *dic in arr) {
        PersonalLogisticsDetailModel *model=[[PersonalLogisticsDetailModel alloc] init];
        model.status=[NSString stringWithFormat:@"%@",dic[@"remark"]];
        model.time=[NSString stringWithFormat:@"%@",dic[@"datetime"]];
        [_remark_list addObject:model];
    }
}

@end
