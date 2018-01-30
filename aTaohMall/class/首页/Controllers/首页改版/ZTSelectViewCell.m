//
//  ZTSelectViewCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ZTSelectViewCell.h"

#define WWW ([UIScreen mainScreen].bounds.size.width-18)/2
#define HHH ([UIScreen mainScreen].bounds.size.height)/2.8

@implementation ZTSelectViewCell

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
    
    self.GoodsImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WWW, WWW)];
    self.GoodsImageView.image = [UIImage imageNamed:@"BGYT"];
    [self addSubview:self.GoodsImageView];
    
    
    self.GoodsNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, WWW+5, WWW-20, 39)];
    self.GoodsNameLabel.textColor=[UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0];
    self.GoodsNameLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:13];
    self.GoodsNameLabel.numberOfLines=2;
    self.GoodsNameLabel.text = @"MADNESS PRINT 东京ATEE T恤 黄色";
    [self addSubview:self.GoodsNameLabel];
    
    self.StrorenameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, WWW+5+29.5+7+7, WWW-20, 11.5)];
    self.StrorenameLabel.textColor=[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    self.StrorenameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.StrorenameLabel.text = @"安淘惠商城";
    [self addSubview:self.StrorenameLabel];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, WWW+5+29.5+7+11.5+9.5+7, WWW-20, 0.5)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:line];
    
    self.GoodsPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, WWW+5+29.5+7+11.5+9.5+0.5+9+7, WWW-20, 12)];
    self.GoodsPriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
    self.GoodsPriceLabel.font=[UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    self.GoodsPriceLabel.text = @"￥150.00+20.00积分";
    [self addSubview:self.GoodsPriceLabel];
    
    
    
    self.view = [[UIImageView alloc] initWithFrame:CGRectMake((WWW-60)/2, (WWW-60)/2, 60, 60)];
    self.view.image = [UIImage imageNamed:@"已售完new"];
    [self addSubview:self.view];
    
    self.view.hidden = YES;
    
}

-(void)StatusString:(NSString *)status Type:(NSString *)stock
{
    
        
    if ([stock isEqualToString:@"0"]) {
            
        self.view.hidden=NO;
        
    }else{
            
        self.view.hidden = YES;
    }
}


@end
