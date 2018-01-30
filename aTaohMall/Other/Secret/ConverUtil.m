//
//  CoverUtil.m
//  TestImageLabel
//
//  Created by 王顺强 on 13-8-21.
//  Copyright (c) 2013年 王顺强. All rights reserved.
//

#import "ConverUtil.h"

@implementation ConverUtil
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

/**
 64编码
 */
+(NSString *)base64Encoding:(NSData*) text
{
    if (text.length == 0)
        return @"";
    
    char *characters = malloc(text.length*3/2);
    
    if (characters == NULL)
        return @"";
    
    NSInteger end = text.length - 3;
    int index = 0;
    int charCount = 0;
    int n = 0;
    
    while (index <= end) {
        int d = (((int)(((char *)[text bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[text bytes])[index + 1]) & 0x0ff) << 8)
        | ((int)(((char *)[text bytes])[index + 2]) & 0x0ff);
        
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = encodingTable[d & 63];
        
        index += 3;
        
        if(n++ >= 14)
        {
            n = 0;
            characters[charCount++] = ' ';
        }
    }
    
    if(index == text.length - 2)
    {
        int d = (((int)(((char *)[text bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[text bytes])[index + 1]) & 255) << 8);
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = '=';
    }
    else if(index == text.length - 1)
    {
        int d = ((int)(((char *)[text bytes])[index]) & 0x0ff) << 16;
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = '=';
        characters[charCount++] = '=';
    }
    NSString * rtnStr = [[NSString alloc] initWithBytesNoCopy:characters length:charCount encoding:NSUTF8StringEncoding freeWhenDone:YES];
    return rtnStr;
}

/**
 字节转化为16进制数
 */
+(NSString *) parseByte2HexString:(Byte *) bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes)
    {
        while (bytes[i] != '\0')
        {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            
            i++;
        }
    }
    
    return hexStr;
}

/**
 * 将字符串用GBK转换成16进制
 */
+ (NSString *)stringEncode16:(NSString *)string
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    Byte *bytes = (Byte *)[string cStringUsingEncoding:enc];
    return [ConverUtil parseByte2HexString:bytes];
}

/**
 字节数组转化16进制数
 */
+(NSString *) parseByteArray2HexString:(Byte[]) bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc] init];
    
    for (int i = 0; i < strlen((const char *)bytes); i++) {
        
        NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
        
        if([hexByte length]==1)
            [hexStr appendFormat:@"0%@", hexByte];
        else
            [hexStr appendFormat:@"%@", hexByte];        
    }
    
    return hexStr;
}

+(int)charToInt:(char)theChar
{
    int b = 0;
    if(theChar>='a'&&theChar<='f')b=theChar-'a'+10;
    if(theChar>='A'&&theChar<='F')b=theChar-'A'+10;
    if(theChar>='0'&&theChar<='9')b=theChar-'0';
    
    return b;
}

/*
 将16进制数据转化成NSData 数组
 */
+(NSData*) parseHexToByteArray:(NSString *) hexString
{
//     NSLog(@"hexstring小罗%@",hexString);
    
    if (hexString && hexString.length > 0) {
        int j=0;
        Byte bytes[hexString.length/2];
        for(int i=0;i<[hexString length];i++)
        {
            int int_ch;  /// 两位16进制数转化后的10进制数
            
            unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
            int int_ch1 = [ConverUtil charToInt:hex_char1] * 16;
            
            i++;
            
            unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
            int int_ch2 = [ConverUtil charToInt:hex_char2];
            
            int_ch = int_ch1+int_ch2;
            
            bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
            j++;
           
        }
        
        NSData *newData = [[NSData alloc] initWithBytes:bytes length:hexString.length/2];
        
        return newData;
    }
    
    return nil;
}


/**
 * 数据封装
 * 将数据的长度（转换为4位 byte）拼在数据的前面
 * @param data 需要封装的数据
 */
+ (NSData *)packageData:(NSData *)data
{
    if (data && data.length > 0) {
        
        //将int转换成byte
        NSUInteger len = data.length;
        char byte[4];
        
        for(int i=0;i<4;i++){
            byte[i] = (char)(len>>8*(3-i) & 0xFF);
        }
        
        NSMutableData *retData = [NSMutableData dataWithBytes:byte length:4];
        [retData appendData:data];
        
        return retData;
    }
    
    return nil;
}

/**
 * 数据封装
 * 将数据的长度（转换为4位 byte）拼在数据的前面
 * @param string 需要封装的字符串数据
 * @param encoding 字符串编码
 */
+ (NSData *)packageDataWithString:(NSString *)string encoding:(NSStringEncoding)encoding
{
    if (string && string.length > 0) {
        NSData *data = [string dataUsingEncoding:encoding];
        return [ConverUtil packageData:data];
    }
    
    return nil;
}


//数据解析状态
+ (void)dataUnPackageState:(NSData *)data handler:(void(^)(SKDataUnPackageState state, NSInteger len))handler
{
    if (data && data.length > 0) {
        
        //byte 转换成 int
        int lenValue = 0;
        char byte[4];
        [data getBytes:byte length:4];
        
        for(int i=0;i<4;i++){
            lenValue += (byte[i] & 0xFF)<<(8*(3-i));
        }
        
        if (lenValue < 0) {
            if (handler) {
                handler(SKDataUnPackageStateError,lenValue);
            }
        }
        else if (lenValue > data.length - 4) {
            // 数据没有准备好
			handler(SKDataUnPackageStateUnReady,lenValue);
        }
        else{
            handler(SKDataUnPackageStateSuccess,lenValue);
        }
    }
    else{
        handler(SKDataUnPackageStateError,0);
    }
}

/**
 * 数据解析
 * @param data 需要解析的数据
 * @param encoding 字符串编码
 */
+ (NSString *)unpackageData:(NSData *)data encoding:(NSStringEncoding)encoding
{
    if (data && data.length > 4) {
        NSData *subData = [data subdataWithRange:NSMakeRange(4, data.length-4)];
        NSString *retStr = [[NSString alloc] initWithData:subData encoding:encoding];
        return retStr;
    }
    
    return nil;
}

@end
