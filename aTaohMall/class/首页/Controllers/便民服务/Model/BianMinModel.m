//
//  BianMinModel.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/26.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "BianMinModel.h"

@implementation BianMinModel

-(NSMutableArray *)childArr
{
    if (!_childArr) {
        _childArr=[[NSMutableArray alloc]init];
    }
    return _childArr;
}
@end
