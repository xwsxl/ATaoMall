//
//  DESUtil.m
//  TestImageLabel
//
//  Created by 王顺强 on 13-8-21.
//  Copyright (c) 2013年 王顺强. All rights reserved.
//

#define CYLog(x, ...) NSLog(x, ## __VA_ARGS__);

#import "DesUtil.h"
#import <CommonCrypto/CommonCryptor.h>
#import "ConverUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import "SecretCodeTool.h"

@implementation DesUtil


static Byte iv[] = {1,2,3,4,5,6,7,8};




/*
 DES加密
 */
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes]	, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        CYLog(@"DES加密成功");
        
        char *ch = (char *)buffer;
        NSMutableString *mString = [NSMutableString stringWithCapacity:strlen(ch) * 2];
        for (int i=0; i < numBytesEncrypted; i++) {
            
            NSString *hexByte = [NSString stringWithFormat:@"%x",buffer[i] & 0xff];///16进制数
            
            if([hexByte length]==1)
                [mString appendFormat:@"0%@", hexByte];
            else
                [mString appendFormat:@"%@", hexByte];
        }

        return mString;
    }else{
        CYLog(@"DES加密失败");
    }
    
    return nil;
}

/**
 DES解密
 */
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key
{
    if (plainText && plainText) {
        NSString *cleartext = nil;
        NSData *textData = [ConverUtil parseHexToByteArray:plainText];
        
        if (textData) {
            NSUInteger dataLength = [textData length];
            unsigned char buffer[dataLength];
            memset(buffer, 0, sizeof(char));
            size_t numBytesEncrypted = 0;
            
            
            CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                                  kCCOptionPKCS7Padding|kCCOptionECBMode,
                                                  [key UTF8String], kCCKeySizeDES,
                                                  iv,
                                                  [textData bytes]	, dataLength,
                                                  buffer, dataLength,
                                                  &numBytesEncrypted);
            if (cryptStatus == kCCSuccess) {
                //CYLog(@"DES解密成功");
                
                NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
                
                //GBK编码
                //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                
                
                cleartext = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
            }else{
                CYLog(@"DES解密失败");
            }
            
            return cleartext;
        }
    }
    
    return nil;
}

+(NSString *) hawkyUseDesDecryptString:(NSString *)string
{
    NSString *codeKey=[SecretCodeTool getDesCodeKey:string];
    NSString *content=[SecretCodeTool getReallyDesCodeString:string];
    if (codeKey&&content) {
        return [DesUtil decryptUseDES:content key:codeKey];
    }
    else
    {
        return @"";
    }
}





@end
