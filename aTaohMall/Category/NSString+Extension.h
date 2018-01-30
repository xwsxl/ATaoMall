//
//  NSString+Extension.h
//  YFQChildPro
//
//  Created by ab on 2017/4/12.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 Description 是否是中文

 @return <#return value description#>
 */
-(BOOL)isChinese;

/**
 Description 是否是手机号格式

 @return <#return value description#>
 */
- (BOOL)phoneNumberIsCorrect;

/**
 Description 计算文本长度

 @param font 文本字体
 @param maxSize 文本限制尺寸
 @return <#return value description#>
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

+(instancetype)stringWithPrice:(id )price andInterger:(id )interger;
@end
