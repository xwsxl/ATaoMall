//
//  CartDingDanHeader.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CartDingDanHeader.h"

@implementation CartDingDanHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        [self setUI];
        
    }
    return self;
}


-(void)setUI{
    
    
    NSLog(@"&&&&&&&&&&&=店铺");
    
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    self.ShopImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 15, 14)];
    
    self.ShopImg.image=[UIImage imageNamed:@"店铺111"];
    
    [self.contentView addSubview:self.ShopImg];
    
    
    self.ShopLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, [UIScreen mainScreen].bounds.size.width-54, 27)];
    
    self.ShopLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.ShopLab.textAlignment = NSTextAlignmentLeft;
    
    self.ShopLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    
    self.ShopLab.text = @"charlekeith箱包旗舰店";
    
    [self.contentView addSubview:self.ShopLab];
    
    
    self.ShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.ShopButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    
    [self.ShopButton addTarget:self action:@selector(GoToBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.ShopButton];
    
    
    
}


-(void)setCarModel:(CartStoreModel *)carModel
{
    
    _carModel = carModel;
    
}
-(void)GoToBtnClick:(UIButton *)sender
{
    
    NSLog(@"===mid===%@",_carModel.mid);
    
    if (_delegate && [_delegate respondsToSelector:@selector(GoToLookShopStore:)]) {
        
        [_delegate GoToLookShopStore:_carModel.mid];
        
        
    }
    
}
@end
