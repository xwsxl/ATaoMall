//
//  HomeDPModel.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeDPModel.h"

@implementation HomeDPModel

-(void)goodListWithArray:(NSArray *)arr
{

    NSMutableArray *temp=[[NSMutableArray alloc] init];
    for (NSDictionary *dic in arr) {
        AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];
        model.gid=dic[@"gid"];
        model.scopeimg=dic[@"scopeimg"];
        [temp addObject:model];
    }
    self.good_list=[temp copy];
}


-(CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight=80*(kScreenWidth-Width(10))/365+15+Height(10)+Height(10)+1;

        if (_good_list.count>0) {
            _cellHeight+=Height(10)+80+Height(10);
        }
    }

    return _cellHeight;
}


@end
