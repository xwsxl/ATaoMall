//
//  XLDateTools.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/9/1.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMSHT_NSENUM.h"
@interface XLDateTools : NSObject
#define CompareDate(A,B,Formatter) [XLDateTools compareDate:A AndDate:B WithDateFormatter:Formatter]

+(XLComparedResult)compareDate:(NSString *)dateStr1 AndDate:(NSString *)dateStr2 WithDateFormatter:(NSDateFormatter *)formatter;

+(XLComparedResult)compareDate:(NSString *)dateStr1 AndDate:(NSString *)dateStr2;

@end
