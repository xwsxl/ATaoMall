//
//  XLHomeTopBangModel.m
//  aTaohMall
//
//  Created by Hawky on 2018/1/17.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLHomeTopBangModel.h"

@implementation XLHomeTopBangModel

-(NSMutableArray *)good_list
{

    if (!_good_list) {
        _good_list=[[NSMutableArray alloc] init];
    }
    return _good_list;
}

@end
