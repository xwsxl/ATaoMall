//
//  NSString+Extension.m
//  YFQChildPro
//
//  Created by ab on 2017/4/12.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 Description 计算文本尺寸

 @param font 文本字体
 @param maxSize 限制
 @return <#return value description#>
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName: font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/**
 Description 是否是中文

 @return <#return value description#>
 */
-(BOOL)isChinese {
    
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
    return [predicate evaluateWithObject:self];
}

/**
 *  检查手机号码
 *
 *  @return return Yes or No
 */
- (BOOL)phoneNumberIsCorrect {
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|7[0-9]|8[0-9])[0-9]|3456788)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 Description 检查是否为正确邮箱

 @return <#return value description#>
 */
- (BOOL)validateEmail
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

+(instancetype)stringWithPrice:(id)price andInterger:(id)interger
{

    price=[NSString stringWithFormat:@"%@",price];
    interger=[NSString stringWithFormat:@"%@",interger];

    if (!price||[price containsString:@"null"]||[price isEqualToString:@""]) {
        price=@"0.00";
    }
    if (!interger||[interger containsString:@"null"]||[interger isEqualToString:@""]) {
        interger=@"0.00";
    }

    return [NSString stringWithFormat:@"￥%.2f+%.2f积分",[price floatValue],[interger floatValue]];
}


@end
