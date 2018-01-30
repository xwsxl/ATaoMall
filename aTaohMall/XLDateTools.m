//
//  XLDateTools.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/9/1.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "XLDateTools.h"
#import "NSDateFormatter+Category.h"
@implementation XLDateTools

+(XLComparedResult)compareDate:(NSString *)dateStr1 AndDate:(NSString *)dateStr2 WithDateFormatter:(NSDateFormatter *)formatter
{
   
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [formatter dateFromString:dateStr1];
    dtb = [formatter dateFromString:dateStr2];
    NSComparisonResult result = [dta compare:dtb];
    
    if (result==NSOrderedSame)
    {
        //        相等  aa=0
        return XLComparedResult_Same;
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        return XLComparedResult_Ascending;
    }else
    {
         // (result==NSOrderedDescending)
        return XLComparedResult_Descending;
    }
    
}
+(XLComparedResult)compareDate:(NSString *)dateStr1 AndDate:(NSString *)dateStr2
{
    
   return  [XLDateTools compareDate:dateStr1 AndDate:dateStr2 WithDateFormatter:[NSDateFormatter shareDateFormatter]];

}

@end
