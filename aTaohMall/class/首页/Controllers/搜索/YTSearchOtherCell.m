//
//  YTSearchOtherCell.m
//  aTaohMall
//
//  Created by JMSHT on 2016/11/28.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTSearchOtherCell.h"


#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TimeModel.h"
#define YTScreen ((kScreenHeight==812)?667:kScreenHeight)/3.5

#define YTScreen1 [UIScreen mainScreen].bounds.size.width/2.5+12

#define YTScreen2 [UIScreen mainScreen].bounds.size.width/2.5+30

@implementation YTSearchOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadMyCell];
    }
    return self;
}

-(void)loadMyCell
{
    
    UIImageView *fenge1=[[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 1, YTScreen-18)];
    fenge1.image=[UIImage imageNamed:@"分割线YT"];
    [self addSubview:fenge1];
    
    
    UIImageView *fenge2=[[UIImageView alloc] initWithFrame:CGRectMake(9, 9, [UIScreen mainScreen].bounds.size.width/2.5+2, 1)];
    fenge2.image=[UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:fenge2];
    
    UIImageView *fenge3=[[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+10, 9, 1, YTScreen-18)];
    fenge3.image=[UIImage imageNamed:@"分割线YT"];
    [self addSubview:fenge3];
    
    UIImageView *fenge4=[[UIImageView alloc] initWithFrame:CGRectMake(9, YTScreen-10, [UIScreen mainScreen].bounds.size.width/2.5+2, 1)];
    fenge4.image=[UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:fenge4];
    
    self.GoodsImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width/2.5, YTScreen-20)];
    [self addSubview:self.GoodsImageView];
    
    
    self.GoodsNameLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 20, [UIScreen mainScreen].bounds.size.width/2-20, 45)];
    self.GoodsNameLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.GoodsNameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.GoodsNameLabel.numberOfLines=2;
    [self addSubview:self.GoodsNameLabel];
    
    self.StorenameLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 65, [UIScreen mainScreen].bounds.size.width/2-20, 20)];
    self.StorenameLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.StorenameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
//    self.StorenameLabel.text = @"林家集团";
    [self addSubview:self.StorenameLabel];
    
    self.GoodsPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 95, [UIScreen mainScreen].bounds.size.width/2-20, 20)];
    self.GoodsPriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.GoodsPriceLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    //    self.GoodsPriceLabel.numberOfLines=2;
    [self addSubview:self.GoodsPriceLabel];
    
    
    self.GoodsAmountLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 125, [UIScreen mainScreen].bounds.size.width/2-20, 17)];
    self.GoodsAmountLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.GoodsAmountLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self addSubview:self.GoodsAmountLabel];
    
    
    UIImageView *line3=[[UIImageView alloc] initWithFrame:CGRectMake(YTScreen1, YTScreen-1, [UIScreen mainScreen].bounds.size.width-YTScreen1, 1)];
    
    line3.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line3];
     
}

-(void)setModel:(SearchResultModel *)model
{
    _model=model;
    
    //赋值
    
    NSNull *null=[[NSNull alloc] init];
    
    if (![_model.scopeimg isEqual:null]) {
        
        [self.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:_model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        
        
    }
    self.GoodsNameLabel.text=_model.name;
    
    self.StorenameLabel.text = _model.storename;
    
    if ([_model.pay_integer isEqual:null] || [_model.pay_integer isEqualToString:@""] || [_model.pay_integer isEqualToString:@"0"] || [_model.pay_integer isEqualToString:@"0.00"]) {
        
        self.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f",[_model.pay_maney floatValue]];
        
    }else if ([_model.pay_maney isEqual:null] || [_model.pay_maney isEqualToString:@""] || [_model.pay_maney isEqualToString:@"0"] || [_model.pay_maney isEqualToString:@"0.00"]){
        
        self.GoodsPriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[_model.pay_integer floatValue]];
        
    }else{
        
        
        self.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[_model.pay_maney floatValue],[_model.pay_integer floatValue]];
        
    }
    
    self.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",_model.amount];
    
    
}


@end
