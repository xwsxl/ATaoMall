//
//  SearchManager.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/31.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchManager : NSObject

//缓存搜索的数组
+(void)SearchText :(NSString *)seaTxt;
//清除缓存数组
+(void)removeAllArray;

//缓存订单搜索的数组
+(void)SearchDingDanText :(NSString *)seaTxt;
//清除订单缓存数组
+(void)removeAllDingDanArray;
@end
