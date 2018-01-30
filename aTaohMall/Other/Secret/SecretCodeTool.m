//
//  TestDesCodeTool.m
//  TestImageLabel
//
//  Created by 王顺强 on 13-8-19.
//  Copyright (c) 2013年 王顺强. All rights reserved.
//

#import "SecretCodeTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SecretCodeTool

+ (NSString *)getDesCodeKey:(NSString *)string
{
    //不合法
    if (!string || [string isEqualToString:@""] || string.length < 20) {
        return nil;
    }
    
    
    
//    NSInteger preLen = [[string substringToIndex:2] integerValue];
//    NSInteger middelLen = [[string substringWithRange:NSMakeRange(2, 2)] integerValue];
//    NSInteger lastLen = [[string substringWithRange:NSMakeRange(4, 2)] integerValue];
//    
//    
//    NSString *subStr = [string substringFromIndex:6];
    
//    CYLog(@"获得DES密码钥匙:%ld,%ld,%ld",(long)preLen,(long)middelLen,(long)lastLen);
    
    
    
    if (string.length >= 30) {
        NSString *reallyStr = [string substringWithRange:NSMakeRange(10, 10)];
        return reallyStr;
    }else{
        return nil;
    }
//    if (subStr.length > preLen && subStr.length >= middelLen) {
//        NSString *reallyStr = [subStr substringWithRange:NSMakeRange(preLen, middelLen)];
//        return reallyStr;
//    }
//    else
//        return nil;
    
}

+ (NSString *)getReallyDesCodeString:(NSString *)string
{
    //不合法
    if (!string || [string isEqualToString:@""] || string.length < 35) {
        return nil;
    }
    
    
    
//    NSInteger preLen = [[string substringToIndex:2] integerValue];
//    NSInteger middelLen = [[string substringWithRange:NSMakeRange(2, 2)] integerValue];
//    NSInteger lastLen = [[string substringWithRange:NSMakeRange(4, 2)] integerValue];
//    
//    NSString *subStr = [string substringFromIndex:6];
    
//    CYLog(@"拿到DES密码钥匙字符串:%ld,%ld,%ld",(long)preLen,(long)middelLen,(long)lastLen);
    
//    NSInteger loc = preLen + middelLen;
//    NSInteger len = subStr.length - preLen - middelLen - lastLen;
//    
    NSRange range = NSMakeRange(20, string.length - 15 -20);
    
    
    if (string.length >= 35) {
        NSString *reallyStr = [string substringWithRange:range];
        //NSLog(@"reallyStr ==%@",reallyStr);
        return reallyStr;
    }else{
        return nil;
    }
    
    
    
//    if (subStr.length > loc && subStr.length >= len) {
//        NSString *reallyStr = [subStr substringWithRange:NSMakeRange(loc, len)];
//        return reallyStr;
//    }
//    else
//        return nil;
}
/**
 *  md5加密
 *
 *  @param str 需要加密的字符串
 *
 *  @return 密文
 *
 *  szd1111 -> f1eb7e28fe796143a7842c9edac45c19
 */
+ (NSString *)encryptUseMd5:(NSString *)str
{
    if (str) {
        const char *cStr = [str UTF8String];
        unsigned char result[16];
        CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
        return [NSString stringWithFormat:
                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ];
    }
    
    return nil;
}

@end
