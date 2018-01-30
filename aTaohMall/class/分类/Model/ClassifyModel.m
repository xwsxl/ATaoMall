//
//  ClassifyModel.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/30.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ClassifyModel.h"

@implementation ClassifyModel
-(NSArray *)goodsList
{
    if (!_goodsList) {
        _goodsList=[[NSArray alloc] init];
    }
    return _goodsList;
}
-(NSArray *)SelectedBrand_list
{
    if (!_SelectedBrand_list) {
        _SelectedBrand_list=[[NSArray alloc] init];
    }
    return _SelectedBrand_list;
}
-(NSArray *)SmallClass_list
{
    if (!_SmallClass_list) {
        _SmallClass_list=[[NSArray alloc] init];
    }
    return _SmallClass_list;
}

@end
