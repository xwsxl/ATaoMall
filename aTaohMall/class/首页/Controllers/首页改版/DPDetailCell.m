//
//  DPDetailCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "DPDetailCell.h"

#define WWW ([UIScreen mainScreen].bounds.size.width-2)/2
#define HHH ([UIScreen mainScreen].bounds.size.height)/2.8

@implementation DPDetailCell

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self= [super initWithFrame:frame]) {
        [self loadMyCell];
        
    }
    return self;
}

-(void)loadMyCell
{
    
    self.backgroundColor=[UIColor whiteColor];
    
    self.GoodsImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WWW, HHH-110)];
    self.GoodsImageView.image = [UIImage imageNamed:@"BGYT"];
    [self addSubview:self.GoodsImageView];
    
    
    self.GoodsNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, HHH-110, WWW-20, 45)];
    self.GoodsNameLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.GoodsNameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.GoodsNameLabel.numberOfLines=2;
    self.GoodsNameLabel.text = @"kmfkgmfkkbhkmbfkmbkfbmdfm";
    [self addSubview:self.GoodsNameLabel];
    
    self.StrorenameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, HHH-65, WWW-20, 20)];
    self.StrorenameLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.StrorenameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.StrorenameLabel.text = @"店铺名称";
    [self addSubview:self.StrorenameLabel];
    
    self.GoodsPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, HHH-45, WWW-20, 20)];
    self.GoodsPriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.GoodsPriceLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.GoodsPriceLabel.text = @"￥150.00+20.00积分";
    [self addSubview:self.GoodsPriceLabel];
    
    
//    
//    self.view = [[UIImageView alloc] initWithFrame:CGRectMake((WWW-60)/2, (HHH-110-60)/2, 60, 60)];
//    self.view.image = [UIImage imageNamed:@"已售完new"];
//    [self addSubview:self.view];
    
}

@end
