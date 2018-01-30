//
//  AirGoBackMingXiView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/5.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirGoBackMingXiView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface AirGoBackMingXiView()
{
    
    UILabel *PiaoJiaLabel;
    UILabel *PiaoJiaNumber;
    UILabel *JiJIanLabel;
    UILabel *JiJIanNumber;
    UILabel *BaiXianLabel;
    UILabel *BaiXianNumber;
    UILabel *InterLabel;
    
    UILabel *PiaoJiaBackLabel;
    UILabel *PiaoJiaBackNumber;
    UILabel *JiJIanBackLabel;
    UILabel *JiJIanBackNumber;
    UILabel *BaiXianBackLabel;
    UILabel *BaiXianBackNumber;
    UILabel *InterBackLabel;
}
@end
@implementation AirGoBackMingXiView


-(void)Price:(NSString *)price JiJian:(NSString *)jijian BaoXian:(NSString *)baoxian DiKoi:(NSString *)dikou Number:(int)number kai1:(BOOL)kai1 kai2:(BOOL)kai2 Price1:(NSString *)price1 JiJian1:(NSString *)jijian1 BaoXian1:(NSString *)baoxian1 DiKoi1:(NSString *)dikou1
{
    
    NSLog(@"====票价===%@",price);
    NSLog(@"====机建===%@",jijian);
    NSLog(@"====保险===%@",baoxian);
    NSLog(@"====抵扣===%@",dikou);
    NSLog(@"====人数===%d",number);
    NSLog(@"===保险=kai1===%d",kai1);
    NSLog(@"===积分=kai2===%d",kai2);
    
    PiaoJiaLabel.text = [NSString stringWithFormat:@"￥%.02f",[price floatValue]];
    PiaoJiaNumber.text = [NSString stringWithFormat:@"x%d人",number];
    JiJIanLabel.text = [NSString stringWithFormat:@"￥%.02f",[jijian1 floatValue]];
    JiJIanNumber.text = [NSString stringWithFormat:@"x%d人",number];
    
    PiaoJiaBackLabel.text = [NSString stringWithFormat:@"￥%.02f",[price1 floatValue]];
    PiaoJiaBackNumber.text = [NSString stringWithFormat:@"x%d人",number];
    JiJIanBackLabel.text = [NSString stringWithFormat:@"￥%.02f",[jijian floatValue]];
    JiJIanBackNumber.text = [NSString stringWithFormat:@"x%d人",number];
    
    if (kai1==0) {
        
        BaiXianLabel.text = [NSString stringWithFormat:@"￥0.00"];
        BaiXianNumber.text = [NSString stringWithFormat:@"x0份"];
        
        BaiXianBackLabel.text = [NSString stringWithFormat:@"￥0.00"];
        BaiXianBackNumber.text = [NSString stringWithFormat:@"x0份"];
        
    }else{
        
        BaiXianLabel.text = [NSString stringWithFormat:@"￥%.02f",[baoxian floatValue]];
        BaiXianNumber.text = [NSString stringWithFormat:@"x%d份",number];
        
        BaiXianBackLabel.text = [NSString stringWithFormat:@"￥%.02f",[baoxian floatValue]];
        BaiXianBackNumber.text = [NSString stringWithFormat:@"x%d份",number];
        
    }
    
    if (kai2==0) {
        
        InterLabel.text = [NSString stringWithFormat:@"-￥0.00"];
        
    }else{
        
        InterLabel.text = [NSString stringWithFormat:@"-￥%.02f",[dikou floatValue]];
    }
    
    
    
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height-50)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        //        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 391)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 391)];
        selectView.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 50)];
        [selectView addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (50-14)/2, UIBounds.size.width, 14)];
        label.text = @"费用明细";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label.font = [UIFont fontWithName:@"PingFang-SC-Light" size:15];
        [view addSubview:label];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, UIBounds.size.width, 1)];
        line1.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view addSubview:line1];
        
        UIView *PriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, UIBounds.size.width, 195)];
        [selectView addSubview:PriceView];
        
        UILabel *GoLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 20, 80, 15)];
        GoLabel.text = @"去程";
        GoLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        GoLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        [PriceView addSubview:GoLabel];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44, UIBounds.size.width-30, 1)];
        line2.image = [UIImage imageNamed:@"分割线-拷贝"];
        [PriceView addSubview:line2];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(23, 63, 80, 14)];
        label1.text = @"票价(不含税)";
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:label1];
        
        PiaoJiaLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 63, UIBounds.size.width-100, 14)];
        PiaoJiaLabel.text = @"";
        PiaoJiaLabel.textAlignment = NSTextAlignmentCenter;
        PiaoJiaLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        PiaoJiaLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [PriceView addSubview:PiaoJiaLabel];
        
        
        PiaoJiaNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23, 63, 80, 14)];
        PiaoJiaNumber.text = @"";
        PiaoJiaNumber.textAlignment = NSTextAlignmentRight;
        PiaoJiaNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        PiaoJiaNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:PiaoJiaNumber];
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(23, 97, 80, 13)];
        label2.text = @"机建+燃油";
        label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:label2];
        
        JiJIanLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 97, UIBounds.size.width-100, 14)];
        JiJIanLabel.text = @"";
        JiJIanLabel.textAlignment = NSTextAlignmentCenter;
        JiJIanLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        JiJIanLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [PriceView addSubview:JiJIanLabel];
        
        
        JiJIanNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23, 97, 80, 14)];
        JiJIanNumber.text = @"";
        JiJIanNumber.textAlignment = NSTextAlignmentRight;
        JiJIanNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        JiJIanNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:JiJIanNumber];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(23, 130, 80, 13)];
        label3.text = @"航空意外险";
        label3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:label3];
        
        BaiXianLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, UIBounds.size.width-100, 14)];
        BaiXianLabel.text = @"";
        BaiXianLabel.textAlignment = NSTextAlignmentCenter;
        BaiXianLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        BaiXianLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [PriceView addSubview:BaiXianLabel];
        
        
        BaiXianNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23, 130, 80, 14)];
        BaiXianNumber.text = @"";
        BaiXianNumber.textAlignment = NSTextAlignmentRight;
        BaiXianNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        BaiXianNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:BaiXianNumber];
        
        
        UILabel *BackLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 214, 80, 15)];
        BackLabel.text = @"返程";
        BackLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        BackLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        [selectView addSubview:BackLabel];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 237, UIBounds.size.width-30, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView addSubview:line3];
        
        
        UILabel *labelBack1 = [[UILabel alloc] initWithFrame:CGRectMake(23, 257, 80, 14)];
        labelBack1.text = @"票价(不含税)";
        labelBack1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        labelBack1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [selectView addSubview:labelBack1];
        
        PiaoJiaBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 257, UIBounds.size.width-100, 14)];
        PiaoJiaBackLabel.text = @"";
        PiaoJiaBackLabel.textAlignment = NSTextAlignmentCenter;
        PiaoJiaBackLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        PiaoJiaBackLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [selectView addSubview:PiaoJiaBackLabel];
        
        
        PiaoJiaBackNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23, 257, 80, 14)];
        PiaoJiaBackNumber.text = @"";
        PiaoJiaBackNumber.textAlignment = NSTextAlignmentRight;
        PiaoJiaBackNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        PiaoJiaBackNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [selectView addSubview:PiaoJiaBackNumber];
        
        
        UILabel *labelBack2 = [[UILabel alloc] initWithFrame:CGRectMake(23, 291, 80, 13)];
        labelBack2.text = @"机建+燃油";
        labelBack2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        labelBack2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [selectView addSubview:labelBack2];
        
        JiJIanBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 291, UIBounds.size.width-100, 14)];
        JiJIanBackLabel.text = @"";
        JiJIanBackLabel.textAlignment = NSTextAlignmentCenter;
        JiJIanBackLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        JiJIanBackLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [selectView addSubview:JiJIanBackLabel];
        
        
        JiJIanBackNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23, 291, 80, 14)];
        JiJIanBackNumber.text = @"";
        JiJIanBackNumber.textAlignment = NSTextAlignmentRight;
        JiJIanBackNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        JiJIanBackNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [selectView addSubview:JiJIanBackNumber];
        
        UILabel *labelBack3 = [[UILabel alloc] initWithFrame:CGRectMake(23, 324, 80, 13)];
        labelBack3.text = @"航空意外险";
        labelBack3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        labelBack3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [selectView addSubview:labelBack3];
        
        BaiXianBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 324, UIBounds.size.width-100, 14)];
        BaiXianBackLabel.text = @"";
        BaiXianBackLabel.textAlignment = NSTextAlignmentCenter;
        BaiXianBackLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        BaiXianBackLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [selectView addSubview:BaiXianBackLabel];
        
        
        BaiXianBackNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23, 324, 80, 14)];
        BaiXianBackNumber.text = @"";
        BaiXianBackNumber.textAlignment = NSTextAlignmentRight;
        BaiXianBackNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        BaiXianBackNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [selectView addSubview:BaiXianBackNumber];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 356.5, UIBounds.size.width-30, 0.5)];
        line4.image = [UIImage imageNamed:@"xuxian"];
        [selectView addSubview:line4];
        
        UIView *InterView = [[UIView alloc] initWithFrame:CGRectMake(0, 357, UIBounds.size.width, 34)];
        [selectView addSubview:InterView];
        
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(23, (34-13)/2, 80, 13)];
        label4.text = @"积分抵扣";
        label4.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label4.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [InterView addSubview:label4];
        
        InterLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, (34-14)/2, UIBounds.size.width-100, 14)];
        InterLabel.text = @"";
        InterLabel.textAlignment = NSTextAlignmentCenter;
        InterLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        InterLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [InterView addSubview:InterLabel];
        
        UIImageView *line5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 33, [UIScreen mainScreen].bounds.size.width, 1)];
        line5.image = [UIImage imageNamed:@"分割线-拷贝"];
        
        [InterView addSubview:line5];
        
    }
    return self;
}


- (void)showInView:(UIView *) view {
    if (self.isHidden) {
        self.hidden = NO;
        if (_huiseControl.superview==nil) {
            [view addSubview:_huiseControl];
        }
        [UIView animateWithDuration:0.2 animations:^{
            _huiseControl.alpha=1;
        }];
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [self.layer addAnimation:animation forKey:@"animation1"];
        self.frame = CGRectMake(0,view.frame.size.height - 391-49, UIBounds.size.width, 391);
        [view addSubview:self];
    }
}


- (void)hideInView {
    
    if (_delegate && [_delegate respondsToSelector:@selector(AirGoBackMingXi)]) {
        
        [_delegate AirGoBackMingXi];
        
    }
    
    if (!self.isHidden) {
        self.hidden = YES;
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [self.layer addAnimation:animation forKey:@"animtion2"];
        [UIView animateWithDuration:0.2 animations:^{
            _huiseControl.alpha=0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}


-(void)huiseControlClick{
    [self hideInView];
}

@end
