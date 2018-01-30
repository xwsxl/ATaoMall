//
//  MerchantDetailHeader.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantDetailHeader.h"

@implementation MerchantDetailHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self= [super initWithFrame:frame]) {
        [self loadMyCell];
    }
    return self;
}

-(void)loadMyCell
{
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 130)];
    
    self.bgImgView.image = [UIImage imageNamed:@"banner"];
    
    [self addSubview:self.bgImgView];
    
    
    self.logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-80)/2, 100, 80, 80)];
    
//    self.logoImgView.image = [UIImage imageNamed:@"BGYT"];
    
    
    self.logoImgView.layer.cornerRadius = 40.0;//（该值到一定的程度，就为圆形了。）

    self.logoImgView.layer.borderWidth = 1;
    
    self.logoImgView.layer.borderColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    
    self.logoImgView.clipsToBounds = TRUE;//去除边界
    
 //   self.logoImgView.hidden=YES;
    
    
    [self addSubview:self.logoImgView];
    
    self.ShopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, [UIScreen mainScreen].bounds.size.width-40, 20)];
    
    self.ShopNameLabel.text = @"";
    
    self.ShopNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.ShopNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    
    self.ShopNameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.ShopNameLabel];
    
    
    self.ShopIntroduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width-40, 35)];
    
    self.ShopIntroduceLabel.text = @"";
    self.ShopIntroduceLabel.numberOfLines = 2;
    
    self.ShopIntroduceLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.ShopIntroduceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    
    self.ShopIntroduceLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.ShopIntroduceLabel];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 244, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line];
    
    
}

-(void)setLogoString:(NSString *)logoString
{
    
//    self.logoImgView.hidden=NO;
}
@end
