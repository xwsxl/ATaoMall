//
//  CartDingDanCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CartDingDanCell.h"

@implementation CartDingDanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    
    NSLog(@"&&&&&&&&&&&=商品详情");
    
    self.GoodsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    
    self.GoodsView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:self.GoodsView];
    
    self.GoodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 80, 80)];
    
    self.GoodsImg.image = [UIImage imageNamed:@"BGYT"];
    
    [self.GoodsView addSubview:self.GoodsImg];
    
    
    self.GoodsNameLab = [[UILabel alloc] initWithFrame:CGRectMake(105, 10, [UIScreen mainScreen].bounds.size.width-125, 40)];
    
    self.GoodsNameLab.numberOfLines=2;
    
    self.GoodsNameLab.text = @"就忍忍吧就DVD是那就DVD九点四十吃饭的的巨大";
    
    self.GoodsNameLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.GoodsNameLab.textAlignment = NSTextAlignmentLeft;
    
    self.GoodsNameLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [self.GoodsView addSubview:self.GoodsNameLab];
    
    //===================================
    
    self.NewGoodsNameLab = [[UILabel alloc] initWithFrame:CGRectMake(105, 20, [UIScreen mainScreen].bounds.size.width-125, 40)];
    
    self.NewGoodsNameLab.numberOfLines=2;
    
    self.NewGoodsNameLab.text = @"就忍忍吧就DVD是那就DVD九点四十吃饭的的巨大";
    
    self.NewGoodsNameLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.NewGoodsNameLab.textAlignment = NSTextAlignmentLeft;
    
    self.NewGoodsNameLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [self.GoodsView addSubview:self.NewGoodsNameLab];
    
    self.NewGoodsNameLab.hidden=YES;
    
    //===================================
    
    self.GoodsAttributeLab = [[UILabel alloc] initWithFrame:CGRectMake(105, 60, [UIScreen mainScreen].bounds.size.width-125, 20)];
    
    self.GoodsAttributeLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    self.GoodsAttributeLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:9];
    
    self.GoodsAttributeLab.text = @"颜色：黑色 尺码：均码 面料：织物";
    
    [self.GoodsView addSubview:self.GoodsAttributeLab];
    
    
    self.GoodsPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(105, 89, [UIScreen mainScreen].bounds.size.width-125, 20)];
    
    self.GoodsPriceLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.GoodsPriceLab.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
    self.GoodsPriceLab.text = @"￥200.00+100.00积分";
    
    [self.GoodsView addSubview:self.GoodsPriceLab];
    
    //=============================
    
    self.NewGoodsPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(105, 65, [UIScreen mainScreen].bounds.size.width-125, 20)];
    
    self.NewGoodsPriceLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.NewGoodsPriceLab.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
    self.NewGoodsPriceLab.text = @"￥200.00+100.00积分";
    
    [self.GoodsView addSubview:self.NewGoodsPriceLab];
    
    self.NewGoodsPriceLab.hidden=YES;
    
    //=============================
    
    self.GoodsNumberLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 80, 60, 20)];
    
    self.GoodsNumberLab.text = @"x1";
    
    self.GoodsNumberLab.textAlignment = NSTextAlignmentRight;
    
    self.GoodsNumberLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.GoodsNumberLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    [self.GoodsView addSubview:self.GoodsNumberLab];
    
    
    self.GoodsType = [[UILabel alloc] initWithFrame:CGRectMake(15, 135, 80, 20)];
    
    self.GoodsType.textColor= [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.GoodsType.text = @"配送方式";
    
    self.GoodsType.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    [self addSubview:self.GoodsType];
    
    
    self.GoodsKuaiDiLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, 135, 100, 20)];
    self.GoodsKuaiDiLab.text = @"快递邮寄 ￥10.00";
    
    self.GoodsKuaiDiLab.textAlignment= NSTextAlignmentRight;
    
    self.GoodsKuaiDiLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.GoodsKuaiDiLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    [self addSubview:self.GoodsKuaiDiLab];
    
    self.ImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-26, 143, 8, 8)];
    
    self.ImgView.image = [UIImage imageNamed:@"iconfont-enter111"];
    
    [self addSubview:self.ImgView];
    
    
    self.SendWayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.SendWayButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-120, 120, 120, 49);
    
    [self addSubview:self.SendWayButton];
    
    [self.SendWayButton addTarget:self action:@selector(SendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 169, [UIScreen mainScreen].bounds.size.width, 1)];
    
    fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:fenge];
    
    
    
}

-(void)setAttribute_str:(NSString *)Attribute_str
{
    
    _Attribute_str = Attribute_str;
    
    if ([_Attribute_str isEqualToString:@""]) {
        
        
        self.NewGoodsPriceLab.hidden=NO;
        
        self.GoodsPriceLab.hidden=YES;
        
        self.NewGoodsNameLab.hidden=NO;
        
        self.GoodsNameLab.hidden=YES;
        
        
    }else{
        
        self.NewGoodsPriceLab.hidden=YES;
        
        self.GoodsPriceLab.hidden=NO;
        
        self.NewGoodsNameLab.hidden=YES;
        
        self.GoodsNameLab.hidden=NO;
        
        
    }
}


-(void)SendBtnClick:(UIButton *)sender
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(cellSelectTypeClick:)]) {
        
        [_delegate cellSelectTypeClick:sender];
        
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
