//
//  CoverUtil.h
//  TestImageLabel
//
//  Created by 王顺强 on 13-8-21.
//  Copyright (c) 2013年 王顺强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SKDataUnPackageStateError,      //数据异常
    SKDataUnPackageStateUnReady,    //数据还没准备好，在传输中
    SKDataUnPackageStateSuccess,    //数据可以解压
} SKDataUnPackageState;


@interface ConverUtil : NSObject

/**
 64编码
 */
+(NSString *)base64Encoding:(NSData*) text;

/**
 字节转化为16进制数
 */
+(NSString *) parseByte2HexString:(Byte *) bytes;

/**
 字节数组转化16进制数
 */
+(NSString *) parseByteArray2HexString:(Byte[]) bytes;

/*
 将16进制数据转化成NSData 数组
 */
+(NSData*) parseHexToByteArray:(NSString*) hexString;

/**
 * 将字符串用GBK转换成16进制
 */
+ (NSString *)stringEncode16:(NSString *)string;

/**
 * 数据封装
 * 将数据的长度（转换为4位 byte）拼在数据的前面
 * @param data 需要封装的数据
 */
+ (NSData *)packageData:(NSData *)data;

/**
 * 数据封装
 * 将数据的长度（转换为4位 byte）拼在数据的前面
 * @param string 需要封装的字符串数据
 * @param encoding 字符串编码
 */
+ (NSData *)packageDataWithString:(NSString *)string encoding:(NSStringEncoding)encoding;


//数据解析状态
+ (void)dataUnPackageState:(NSData *)data handler:(void(^)(SKDataUnPackageState state, NSInteger len))handler;

/**
 * 数据解析
 * @param data 需要解析的数据
 * @param encoding 字符串编码
 */
+ (NSString *)unpackageData:(NSData *)data encoding:(NSStringEncoding)encoding;

@end
