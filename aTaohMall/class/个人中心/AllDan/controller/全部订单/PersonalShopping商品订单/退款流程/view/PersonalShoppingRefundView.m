//
//  PersonalShoppingRefundView.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingRefundView.h"
@interface PersonalShoppingRefundView ()

@property (nonatomic,strong)UILabel *shoppingNameLab;
@property (nonatomic,strong)UIImageView *shoppingScopimgIV;
@property (nonatomic,strong)UILabel *attributesLab;

@end

@implementation PersonalShoppingRefundView

NSString *shoppingName=@"";
NSString *scopimgNameStr=@"";
NSString *attributesStr=@"";
-(instancetype)initWithFrame:(CGRect )frame AndShoppingName:(NSString *)name scopimgName:(NSString *)scopimgName attributeStr:(NSString *)str
{
    shoppingName=name;
    scopimgNameStr=scopimgName;
    if ([str isEqual:[[NSNull alloc] init] ]||[str containsString:@"null"]) {
        str=@"";
    }
    attributesStr=str;
    return [self initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame
{
   
    if (self=[super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.shoppingScopimgIV=[[UIImageView alloc] init];
    [_shoppingScopimgIV setImage:KImage(scopimgNameStr)];
    [_shoppingScopimgIV sd_setImageWithURL:KNSURL(scopimgNameStr) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
    [self addSubview:self.shoppingScopimgIV];

    self.shoppingNameLab=[[UILabel alloc] init];
    [_shoppingNameLab setFont:KNSFONT(12)];
    [_shoppingNameLab setTextColor:RGB(51, 51, 51)];
    [_shoppingNameLab setText:shoppingName];
    [_shoppingNameLab setNumberOfLines:0];
    [self addSubview:_shoppingNameLab];

    self.attributesLab =[[UILabel alloc] init];
    [_attributesLab setFont:KNSFONT(10)];
    [_attributesLab setTextColor:RGB(153, 153, 153)];
    [_attributesLab setText:attributesStr];
    [self addSubview:_attributesLab];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.shoppingScopimgIV setFrame:CGRectMake(Width(15), Height(15), 70, 70)];
    [self.shoppingNameLab setFrame:CGRectMake(Width(15)+70+Width(10), Height(15), self.frame.size.width-70-Width(45), 34)];
    [self.attributesLab setFrame:CGRectMake(Width(15)+70+Width(10), self.frame.size.height-Height(15)-23, self.frame.size.width-70-Width(45), 13)];
}

@end
