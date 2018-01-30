//
//  NewScoreHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/5.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NewScoreHeaderView.h"
#import "UILabel+LSLabelSize.h"
@implementation NewScoreHeaderView

{
    
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
}



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self awakeFromNib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self awakeFromNib];
    }
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"888888");
    
    
    //要悬浮的地方
    
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 55, [UIScreen mainScreen].bounds.size.width, 40)];
    
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    
    label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40)];
    label1.text=@"全部";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    label1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:16];
    
    [view addSubview:label1];
    
    button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40);
    
    [view addSubview:button1];
    
    [button1 addTarget:self action:@selector(BtnClick1) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIImageView *line1=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/3, 6, 1, 28)];
    line1.image=[UIImage imageNamed:@"分割线YT"];
    
    [view addSubview:line1];
    
    
    label2=[[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/3+1, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40)];
    label2.text=@"收入";
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:16];
    
    [view addSubview:label2];
    
    
    button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/3+1, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40);
    
    [view addSubview:button2];
    
    [button2 addTarget:self action:@selector(BtnClick2) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *line2=[[UIImageView alloc] initWithFrame:CGRectMake(2*(([UIScreen mainScreen].bounds.size.width-2)/3)+1, 6, 1, 28)];
    line2.image=[UIImage imageNamed:@"分割线YT"];
    
    [view addSubview:line2];
    
    
    label3=[[UILabel alloc] initWithFrame:CGRectMake(2*(([UIScreen mainScreen].bounds.size.width-2)/3)+2, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40)];
    label3.text=@"支出";
    label3.textAlignment=NSTextAlignmentCenter;
    label3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label3.font=[UIFont fontWithName:@"PingFangSC-Regular" size:16];
    
    [view addSubview:label3];
    
    
    button3=[UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame=CGRectMake(2*(([UIScreen mainScreen].bounds.size.width-2)/3)+2, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40);
    
    [view addSubview:button3];

    UIImageView *line4=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, kScreen_Width, 1)];
    line4.image=[UIImage imageNamed:@"分割线YT"];

    [view addSubview:line4];

    [button3 addTarget:self action:@selector(BtnClick3) forControlEvents:UIControlEventTouchUpInside];
    

    UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 80)];
    [IV setImage:[self.BackImage getSubImage:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, 80)]];
    [_RedView addSubview:IV];
    

}
-(void)layoutSubviews
{
    [super layoutSubviews];

    _lineIV.frame=CGRectMake(0, 118, kScreen_Width, 1);
}

-(void)setScore:(NSString *)Score
{
    
    _Score=Score;
    
    NSLog(@"===用户积分===%@",_Score);
    
    [self.JiFenLabel removeFromSuperview];
    
    if (_Score.length>0) {
        
        
        self.JiFenLabel=[[UILabel alloc] init];
        self.JiFenLabel.numberOfLines = 1;
        
        CGFloat heighth = 40;
        
        self.JiFenLabel.font=[UIFont fontWithName:@"PingFangSC-Semibold" size:30];
        
        self.JiFenLabel.textColor=[UIColor whiteColor];
        
        self.JiFenLabel.textAlignment=NSTextAlignmentCenter;
        
        self.JiFenLabel.text=[NSString stringWithFormat:@"%.02f积分",[_Score floatValue]];
        NSString *stringForColor = @"积分";
        
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.JiFenLabel.text];
        //
        NSRange range = [self.JiFenLabel.text rangeOfString:stringForColor];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
        
        self.JiFenLabel.attributedText=mAttStri;
        
        self.JiFenLabel.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-80-[UILabel widthOfLabelWithString:self.JiFenLabel.text sizeOfFont:30 height:40])/2+70, 20, [UILabel widthOfLabelWithString:self.JiFenLabel.text sizeOfFont:30 height:40], 40);
        
        [self.RedView addSubview:self.JiFenLabel];
        
        
        
        UIImageView *MonimgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-80-[UILabel widthOfLabelWithString:self.JiFenLabel.text sizeOfFont:30 height:40])/2+10, 0, 80, 80)];
        
        //    MonimgView.backgroundColor=[UIColor orangeColor];
        
        MonimgView.image=[UIImage imageNamed:@"积分yt"];
        
        [self.RedView addSubview:MonimgView];
        
    }
    
    
}

-(void)BtnClick1
{
    label1.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    if (_delegate&&[_delegate respondsToSelector:@selector(AllScoreButClick:)]) {
        [_delegate AllScoreButClick:nil];
    }
    
}

-(void)BtnClick2
{
    
    label1.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label2.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    label3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
   
    
    if (_delegate&&[_delegate respondsToSelector:@selector(ShouRuScoreButClick:)]) {
        [_delegate ShouRuScoreButClick:nil];
    }
    
}

-(void)BtnClick3
{
    
    label1.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label3.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
    
    
    if (_delegate&&[_delegate respondsToSelector:@selector(ZhiChuScoreButClick:)]) {
        [_delegate ZhiChuScoreButClick:nil];
    }
    
}

-(void)setText:(NSString *)text
{
    _text = text;
    
    ((UILabel *)self.subviews[0]).text = text;
}
-(UIImage *)BackImage
{
    if (!_BackImage) {
        _BackImage=[UIImage imageWithImageView:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight+80) StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, KSafeAreaTopNaviHeight+80)];
    }
    return _BackImage;
}
@end
