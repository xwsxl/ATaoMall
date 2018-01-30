//
//  FristHomeCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/19.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "FristHomeCell.h"

#define WWW (([UIScreen mainScreen].bounds.size.width-2)/2.0)
#define HHH (WWW+110)

@implementation FristHomeCell


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
    [self addSubview:self.GoodsImageView];
    
    
    self.GoodsNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(Width(9), WWW+9, WWW-Width(18), 45)];
    self.GoodsNameLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.GoodsNameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.GoodsNameLabel.numberOfLines=2;
    [self addSubview:self.GoodsNameLabel];

    self.GoodsPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(Width(9), WWW+9+45+4, WWW-Width(18), 20)];
    self.GoodsPriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.GoodsPriceLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self addSubview:self.GoodsPriceLabel];


    self.StrorenameLabel=[[UILabel alloc] initWithFrame:CGRectMake(Width(9), HHH-27, WWW/2-Width(9)-3, 17)];
    self.StrorenameLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.StrorenameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self addSubview:self.StrorenameLabel];

    self.GoodsAmountLabel=[[UILabel alloc] initWithFrame:CGRectMake(WWW/2+3, HHH-27, WWW/2-Width(9)-3, 17)];
    self.GoodsAmountLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.GoodsAmountLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.GoodsAmountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.GoodsAmountLabel];
    
    self.view = [[UIImageView alloc] initWithFrame:CGRectMake((WWW-60)/2, (HHH-110-60)/2, 60, 60)];
    self.view.image = [UIImage imageNamed:@"已售完new"];
    [self addSubview:self.view];
    
}

-(void)setStock:(NSString *)stock
{
    
    _stock =stock;
    
    NSLog(@"=====_stock==%@==_status=%@",_stock,_status);

}
-(void)setStatus:(NSString *)status
{
    //    NSLog(@"===333===%f",self.GoodsImageView.frame.size.height);
    _status = status;
    if ([_stock isEqualToString:@"1"]) {

        self.view.hidden=NO;
    }else{

        self.view.hidden=YES;

    }
    
}


@end
