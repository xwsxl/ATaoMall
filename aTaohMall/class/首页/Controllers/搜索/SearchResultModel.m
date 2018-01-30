//
//  SearchResultModel.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/2.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
       if ([dictionary isKindOfClass:[NSDictionary class]]) {
    
                 if (self = [super init]) {
            
                        [self setValuesForKeysWithDictionary:dictionary];
                    }
            }
    
         return self;
    }

- (void)setValue:(id)value forKey:(NSString *)key {
    
         // ignore null value
         if ([value isKindOfClass:[NSNull class]]) {
        
                 return;
             }
    
         [super setValue:value forKey:key];
     }
@end
