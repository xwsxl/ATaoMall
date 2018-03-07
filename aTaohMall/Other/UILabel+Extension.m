//
//  UILabel+Extension.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/8/8.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

-(void)showTextBadgeWithText:(NSString *)string
{
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    lab.textColor=[UIColor redColor];
    lab.text=@"*";
    lab.font=KNSFONT(9);
    [self addSubview:lab];
}

-(void)KSetLabelText:(NSString *)string withFont:(UIFont *)font MaxSize:(CGSize )maxSize
{
    CGRect rect=self.frame;
    CGSize size=[string sizeWithFont:font maxSize:maxSize];
    self.frame=CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
    self.text=string;
    self.font=font;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}
@end
