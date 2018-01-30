//
//  NSDateFormatter+Category.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/9/1.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NSDateFormatter+Category.h"

static NSDateFormatter *shareFormatter=nil;

@implementation NSDateFormatter (Category)

+(instancetype)shareDateFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareFormatter=[[self alloc]init];
        [shareFormatter setDateFormat:@"yyyy-MM-dd"];
    });
    return shareFormatter;
}
@end
