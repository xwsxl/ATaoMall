//
//  BusinessQurtModel.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/19.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "BusinessQurtModel.h"

@implementation BusinessQurtModel

//更改变量名
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"uid"}];
}
@end
