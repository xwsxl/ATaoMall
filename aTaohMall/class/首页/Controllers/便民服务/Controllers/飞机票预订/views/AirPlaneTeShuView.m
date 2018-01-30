//
//  AirPlaneTeShuView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneTeShuView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@implementation AirPlaneTeShuView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        //        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 351)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        _shareListView.layer.cornerRadius = 10;
        _shareListView.layer.masksToBounds = YES;
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 351)];
        selectView.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, UIBounds.size.width-50, 17)];
        titleLabel.text = @"特殊乘客购票须知";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:18];
        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [selectView addSubview:titleLabel];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(15, 57, UIBounds.size.width-60, 144)];
        //        titleView.backgroundColor = [UIColor orangeColor];
        [selectView addSubview:titleView];
        
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(11, 11, UIBounds.size.width-60-20, 46)];
        label1.text = @"1. 婴儿票（14天-2岁），暂不提供婴儿票购买服务，请直接前往机场柜台购买。但每个航班可守婴儿票数量有限，如有需请及时联系航空公司购买。";
        label1.textAlignment = NSTextAlignmentLeft;
        label1.numberOfLines=0;
        label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:label1];
        
        UILabel *textlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(11, 58, UIBounds.size.width-60-20, 70)];
        textlabel1.text = @"2. 儿童(2岁-12岁，按乘机当天的实际年龄计算)2岁(含)-12岁(不含)请购买儿童票，票价为全价票的50%，不收取机场建设费，燃油收取成人票价的50%，购买时需要同时购买成人票，一个成人最多携带两名儿童。";
        textlabel1.textAlignment = NSTextAlignmentLeft;
        textlabel1.numberOfLines=0;
        textlabel1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        textlabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:textlabel1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(11, 135, UIBounds.size.width-80, 46)];
        label2.text = @"3. 2岁(含)-16岁(不含)儿童无身份证、证件类型可选择户口本，证件号码栏请填写儿童在户口本上的身份证件号码。";
        label2.textAlignment = NSTextAlignmentLeft;
        label2.numberOfLines=0;
        label2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(11, 180, UIBounds.size.width-80, 12)];
        label3.text = @"4. 12（含）-18岁（不含）购票价格已成人票一致。";
        label3.textAlignment = NSTextAlignmentLeft;
        label3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        label3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(11, 200, UIBounds.size.width-80, 60)];
        label4.text = @"5. 重要旅客(VIP)、婴儿、无成人陪伴儿童、孕妇、病残旅客、革命伤残军人和因公致残人民警察等待殊旅客购票，请提前向航空公司申 请并妥善安排行程。";
        label4.numberOfLines=0;
        label4.textAlignment = NSTextAlignmentLeft;
        label4.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        label4.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:label4];
        
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-60, 1)];
        line1.image = [UIImage imageNamed:@"分割线-拷贝"];
        [titleView addSubview:line1];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 275, UIBounds.size.width-60, 1)];
        line2.image = [UIImage imageNamed:@"分割线-拷贝"];
        [titleView addSubview:line2];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 276)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [titleView addSubview:line3];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-60, 0, 1, 276)];
        line4.image = [UIImage imageNamed:@"分割线-拷贝"];
        [titleView addSubview:line4];
        
        
        
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
        self.frame = CGRectMake(15,(UIBounds.size.height - 351)/2, UIBounds.size.width-30, 315);
        [view addSubview:self];
    }
}


- (void)hideInView {
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
