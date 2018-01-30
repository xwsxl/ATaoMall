//
//  FailureAttributeCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/2/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "FailureAttributeCell.h"

#import "UIImageView+WebCache.h"

#import "ShopModel.h"

#define CellHeight [[UIScreen mainScreen] bounds].size.height*0.1799

#define CellWidth [UIScreen mainScreen].bounds.size.width*0.1733

@implementation FailureAttributeCell

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
    
    self.SelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SelectButton.frame=CGRectMake(17, (CellHeight-14)/2, 27, 14);
    self.SelectButton.userInteractionEnabled=NO;
    [self.SelectButton setBackgroundImage:[UIImage imageNamed:@"失效"] forState:UIControlStateNormal];
    
    [self addSubview:self.SelectButton];
    
    
    self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, (CellHeight-CellHeight*0.8333)/2, CellHeight*0.8333, CellHeight*0.8333)];
    
    self.LogoImgView.image = [UIImage imageNamed:@"BGYT"];
    
    self.LogoImgView.alpha = 0.5;
    
    [self addSubview:self.LogoImgView];
    
    
    
    //商品名称
    self.GoodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, 10, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60, 40)];
    self.GoodsNameLabel.numberOfLines=2;
    self.GoodsNameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.5];
    self.GoodsNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self addSubview:self.GoodsNameLabel];
    
    
    //商品属性
    self.AttributeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, 50, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60, 30)];
    self.AttributeLabel.numberOfLines=2;
    self.AttributeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:9];
    self.AttributeLabel.text=@"颜色：褐色；尺寸：均码；面料：棉";
    self.AttributeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.5];
    [self addSubview:self.AttributeLabel];
    
    
    //无属性商品价格
    self.NewPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, CellHeight*0.5833, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-90, 20)];
    self.NewPriceLabel.text=@"￥86.00+23.00积分";
    self.NewPriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.NewPriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:0.5];
    [self addSubview:self.NewPriceLabel];
    //    self.NewPriceLabel.hidden=YES;
    
    //商品数量
    self.NewNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, CellHeight*0.5833, 60, 20)];
    
    self.NewNumberLabel.text=@"x2";
    self.NewNumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.NewNumberLabel.textAlignment=NSTextAlignmentRight;
    self.NewNumberLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.5];
    [self addSubview:self.NewNumberLabel];
    
    //有属性价格
    self.PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, CellHeight*0.75, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60, 20)];
    self.PriceLabel.text=@"￥86.00+23.00积分";
    self.PriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.PriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:0.5];
    [self addSubview:self.PriceLabel];
    
    //商品数量
    self.NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, CellHeight*0.75, 60, 20)];
    
    self.NumberLabel.text=@"x2";
    self.NumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.NumberLabel.textAlignment=NSTextAlignmentRight;
    self.NumberLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.5];
    [self addSubview:self.NumberLabel];
    
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(45, CellHeight-0.5, [UIScreen mainScreen].bounds.size.width-45, 0.5)];
    
    self.line.image = [UIImage imageNamed:@"分割线e2"];
    
    [self.contentView addSubview:self.line];
    
    
}

@end
