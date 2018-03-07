//
//  UILabel+Extension.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/8/8.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

-(void)showTextBadgeWithText:(NSString *)string;
-(void)KSetLabelText:(NSString *)string withFont:(UIFont *)font MaxSize:(CGSize )maxSize;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


@end
