//
//  CarInfoModel.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CarInfoModel.h"

@implementation CarInfoModel
-(NSMutableArray *)PendingPeccancecyArr
{
    if (!_PendingPeccancecyArr) {
        _PendingPeccancecyArr=[[NSMutableArray alloc]init];
    }
    return _PendingPeccancecyArr;
}


@end
