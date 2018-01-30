//
//  ForYouSelectCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ForYouSelectCell.h"

@implementation ForYouSelectCell

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
    
    self.GoodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 104, 104)];
    self.GoodsImgView.image = [UIImage imageNamed:@"BGYT"];
    [self addSubview:self.GoodsImgView];
    
    self.view = [[UIImageView alloc] initWithFrame:CGRectMake((104-60)/2+15, (104-60)/2+8, 60, 60)];
    self.view.image = [UIImage imageNamed:@"已售完new"];
    [self addSubview:self.view];
    
    self.view.hidden = YES;
    
    
    self.GoodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(134.5, 8.5, [UIScreen mainScreen].bounds.size.width-134.5-24, 39.5)];
    self.GoodsNameLabel.text = @"Apple Watch Series 2苹果智能手表 iWatch watch2运动型手环";
    self.GoodsNameLabel.numberOfLines = 2;
    self.GoodsNameLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0];
    self.GoodsNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [self addSubview:self.GoodsNameLabel];
    
//    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
//    CGSize textSize = [self.GoodsNameLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-134.5-24, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
//    
//    NSLog(@"======%f",textSize.height);
    
    self.GoodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(134.5, 60, [UIScreen mainScreen].bounds.size.width-134.5, 14)];
    self.GoodsPriceLabel.text = @"￥86.00+23.00积分";
    self.GoodsPriceLabel.textColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
    self.GoodsPriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
    [self addSubview:self.GoodsPriceLabel];
    
    NSString *stringForColor4 = @"积分";
    // 创建对象.
    NSMutableAttributedString *mAttStri4 = [[NSMutableAttributedString alloc] initWithString:self.GoodsPriceLabel.text];
    //
    NSRange range4 = [self.GoodsPriceLabel.text rangeOfString:stringForColor4];
    [mAttStri4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14] range:range4];
    self.GoodsPriceLabel.attributedText=mAttStri4;
    
    
    self.GoodsStoreNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(134.5, 99.5, [UIScreen mainScreen].bounds.size.width-160, 12.5)];
    self.GoodsStoreNameLabel.text = @"安淘惠商城";
    self.GoodsStoreNameLabel.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    self.GoodsStoreNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [self addSubview:self.GoodsStoreNameLabel];
    
    self.GoodsAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-155, 99.5, 140, 12.5)];
    self.GoodsAmountLabel.text = @"3人付款";
    self.GoodsAmountLabel.textAlignment = NSTextAlignmentRight;
    self.GoodsAmountLabel.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    self.GoodsAmountLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [self addSubview:self.GoodsAmountLabel];
    
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 119, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line.image = [UIImage imageNamed:@"fengexian"];
    
    [self addSubview:line];
    
    
}

-(void)StatusString:(NSString *)status Type:(NSString *)type
{
    
        
        if ([type isEqualToString:@"0"]) {
            
            self.view.hidden=NO;
            
        }else{
            
            self.view.hidden = YES;
        }

}

-(void)setPrice:(NSString *)Price
{
    _Price = Price;
    
    self.GoodsPriceLabel.text = _Price;
    
    NSString *stringForColor4 = @"积分";
    // 创建对象.
    NSMutableAttributedString *mAttStri4 = [[NSMutableAttributedString alloc] initWithString:self.GoodsPriceLabel.text];
    //
    NSRange range4 = [self.GoodsPriceLabel.text rangeOfString:stringForColor4];
    [mAttStri4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14] range:range4];
    self.GoodsPriceLabel.attributedText=mAttStri4;
    
}

-(void)setAmount:(NSString *)amount
{
    _amount = amount;
    
    self.GoodsAmountLabel.text = [NSString stringWithFormat:@"%@人付款",_amount];
    
    NSString *stringForColor3 = _amount;
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.GoodsAmountLabel.text];
    //
    NSRange range3 = [self.GoodsAmountLabel.text rangeOfString:stringForColor3];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:82/255.0 blue:82/255.0 alpha:1.0] range:range3];
    self.GoodsAmountLabel.attributedText=mAttStri;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
