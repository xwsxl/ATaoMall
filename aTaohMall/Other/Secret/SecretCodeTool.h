//
//  TestDesCodeTool.h
//  TestImageLabel
//
//  Created by 王顺强 on 13-8-19.
//  Copyright (c) 2013年 王顺强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecretCodeTool : NSObject

+(NSString *)getDesCodeKey:(NSString *)string;
+(NSString *)getReallyDesCodeString:(NSString *)string;

//md5加密
+ (NSString *)encryptUseMd5:(NSString *)str;

@end
