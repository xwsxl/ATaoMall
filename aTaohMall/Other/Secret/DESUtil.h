//
//  DESUtil.h
//  TestImageLabel
//
//  Created by 王顺强 on 13-8-21.
//  Copyright (c) 2013年 王顺强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesUtil : NSObject
/**
 DES加密
 */
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

/**
 DES解密
 */
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;


@end

