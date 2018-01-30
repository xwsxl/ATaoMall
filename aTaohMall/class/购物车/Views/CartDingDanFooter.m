//
//  CartDingDanFooter.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CartDingDanFooter.h"

#import "CartGoodsModel.h"

@interface CartDingDanFooter ()<UITextFieldDelegate>

@end
@implementation CartDingDanFooter

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
    
    
    NSLog(@"&&&&&&&&&&&=买家留言");
    
    self.WordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 105)];
    
    self.WordView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.WordView];
    
    
    self.WordLab = [[UILabel alloc] initWithFrame:CGRectMake(15, (105-20)/2, 60, 20)];
    
    self.WordLab.text = @"买家留言：";
    
    self.WordLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.WordLab.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [self.WordView addSubview:self.WordLab];
    
    
    self.WordTF = [[UITextView alloc] initWithFrame:CGRectMake(85, (105-30)/2, [UIScreen mainScreen].bounds.size.width-105, 50)];
    
    self.WordTF.text=@"选填，有什么小要求在这里提醒买家";
    
    self.WordTF.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    self.WordTF.font= [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    
    [self.WordView addSubview:self.WordTF];
    
    
    self.Line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, 1)];
    
    self.Line.image = [UIImage imageNamed:@"分割线YT"];
    
    [self.WordView addSubview:self.Line];
    
    self.HejiView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, [UIScreen mainScreen].bounds.size.width, 65)];
    
    
    self.HejiView.backgroundColor = [UIColor whiteColor];
    
    
    [self addSubview:self.HejiView];
    
    
    self.HeJiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width-20, 20)];
    
    self.HeJiLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.HeJiLabel.textAlignment = NSTextAlignmentRight;
    
    self.HeJiLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
//    self.HeJiLabel.text = @"共1件商品 合计：￥620.00";
    
    NSString *string = @"共1件商品 合计：￥620.00";
    
    NSString *stringForColor = @"￥620.00";
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    //
    NSRange range = [string rangeOfString:stringForColor];
    
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
    
    self.HeJiLabel.attributedText=mAttStri;
    
    [self.HejiView addSubview:self.HeJiLabel];
    
    
    self.DuiHuanLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 35, [UIScreen mainScreen].bounds.size.width-120, 20)];
    
    self.DuiHuanLab.textAlignment=NSTextAlignmentRight;
    
    self.DuiHuanLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    self.DuiHuanLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.DuiHuanLab.text  = @"(可用积分兑换，1积分=￥1.00)";
    
    [self.HejiView addSubview:self.DuiHuanLab];
    
    
    UIImageView *ImgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 1)];
    
    ImgLine.image=[UIImage imageNamed:@"分割线YT"];
    
    [self.HejiView addSubview:ImgLine];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, [UIScreen mainScreen].bounds.size.width, 10)];
    lineView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:lineView];
    
    
    //反向传值
    
    if (_delegate && [_delegate performSelector:@selector(footerCountMoney:)]) {
        
        [_delegate footerCountMoney:self.HeJiLabel];
        
    }
    
}


-(void)setGoods:(CartGoodsModel *)goods
{
    
    _goods = goods;
    
    
}

-(void)setGoodsArray:(NSArray *)goodsArray{
    
    
    _goodsArray = goodsArray;
    

}
@end
