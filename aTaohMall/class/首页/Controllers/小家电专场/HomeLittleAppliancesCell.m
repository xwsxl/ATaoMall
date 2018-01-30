//
//  HomeLittleAppliancesCell.m
//  aTaohMall
//
//  Created by DingDing on 2017/10/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeLittleAppliancesCell.h"
#define WWW ([UIScreen mainScreen].bounds.size.width-2)/2
#define HHH ([UIScreen mainScreen].bounds.size.height)/2.7
@implementation HomeLittleAppliancesCell

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
    
    self.GoodsImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WWW-4, HHH-120)];
    [self addSubview:self.GoodsImageView];
    
    
    self.GoodsNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, HHH-120, WWW-20, 45)];
    self.GoodsNameLabel.textColor=[UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0];
    self.GoodsNameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.GoodsNameLabel.numberOfLines=2;
    [self addSubview:self.GoodsNameLabel];
    
    self.StrorenameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, HHH-75, WWW-20, 20)];
    self.StrorenameLabel.textColor=[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    self.StrorenameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self addSubview:self.StrorenameLabel];
    
    UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(5, HHH-50, WWW-10-4, 1)];
    IV.image=KImage(@"分割线-拷贝");
    [self addSubview:IV];
    
    self.GoodsPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, HHH-45, WWW-20, 20)];
    self.GoodsPriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
    self.GoodsPriceLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    //    self.GoodsPriceLabel.numberOfLines=2;
    [self addSubview:self.GoodsPriceLabel];
    
    self.GoodsAmountLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, HHH-25, WWW-20, 17)];
    self.GoodsAmountLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.GoodsAmountLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.GoodsAmountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.GoodsAmountLabel];
    
}

-(void)setStock:(NSString *)stock
{
    
    _stock =stock;
    
  //  NSLog(@"=====_stock==%@==_status=%@",_stock,_status);

}
-(void)setStatus:(NSString *)status
{
    _status = status;

}

@end
