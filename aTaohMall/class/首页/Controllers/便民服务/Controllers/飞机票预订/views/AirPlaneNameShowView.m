//
//  AirPlaneNameShowView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneNameShowView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@implementation AirPlaneNameShowView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        //        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 221)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        _shareListView.layer.cornerRadius = 10;
        _shareListView.layer.masksToBounds = YES;
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 221)];
        selectView.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, UIBounds.size.width-50, 17)];
        titleLabel.text = @"姓名填写说明";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:18];
        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [selectView addSubview:titleLabel];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(15, 57, UIBounds.size.width-60, 144)];
        //        titleView.backgroundColor = [UIColor orangeColor];
        [selectView addSubview:titleView];


        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(11, 11, UIBounds.size.width-60-20, 12)];
        label1.text = @"1. 姓名需与所持证件的姓名一致。";
        label1.textAlignment = NSTextAlignmentLeft;
        label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:label1];
        
        UILabel *textlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(11, 28, UIBounds.size.width-60-20, 55)];
        textlabel1.text = @"2. 中文姓名 \n*生僻词可用拼音代替，拼音之后不可在输入汉字，需用拼音代替。例如：“祝畯”可输入为“祝jun”";
        textlabel1.textAlignment = NSTextAlignmentLeft;
        textlabel1.numberOfLines=0;
        textlabel1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        textlabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:textlabel1];
        
        NSString *stringForColor = @"*";
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:textlabel1.text];
        //
        NSRange range = [textlabel1.text rangeOfString:stringForColor];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
        textlabel1.attributedText=mAttStri;
        
        
        UILabel *textlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(11, 84, UIBounds.size.width-60-20, 35)];
        textlabel2.text = @"*姓名中有特殊如号“.”“-”等，可不用输入，例如“汉祖然.买买提”可输入为“汉祖然买买提”";
        textlabel2.textAlignment = NSTextAlignmentLeft;
        textlabel2.numberOfLines=0;
        textlabel2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        textlabel2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:textlabel2];
        
        NSString *stringForColor1 = @"*";
        NSMutableAttributedString *mAttStri2 = [[NSMutableAttributedString alloc] initWithString:textlabel2.text];
        NSRange range1 = [textlabel2.text rangeOfString:stringForColor1];
        [mAttStri2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
        textlabel2.attributedText=mAttStri2;
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(11, 122, UIBounds.size.width-80, 12)];
        label2.text = @"3. 暂只支持大陆地区身份证以及国内航班。";
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [titleView addSubview:label2];
        
        

        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-60, 1)];
        line1.image = [UIImage imageNamed:@"分割线-拷贝"];
        [titleView addSubview:line1];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 143, UIBounds.size.width-60, 1)];
        line2.image = [UIImage imageNamed:@"分割线-拷贝"];
        [titleView addSubview:line2];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 144)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [titleView addSubview:line3];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-60, 0, 1, 144)];
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
        self.frame = CGRectMake(15,(UIBounds.size.height - 221)/2, UIBounds.size.width-30, 221);
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
