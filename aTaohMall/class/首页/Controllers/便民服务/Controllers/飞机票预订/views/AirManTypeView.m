//
//  AirManTypeView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirManTypeView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@implementation AirManTypeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 208)];
        _shareListView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(15, 20, UIBounds.size.width-30, 61)];
        selectView.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 1)];
        line2.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView addSubview:line2];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 61)];
        line4.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView addSubview:line4];
        
        UIImageView *line5 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-30, 0, 1, 61)];
        line5.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView addSubview:line5];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100-30)/2, (61-15)/2, 100, 15)];
        leftLabel.text = @"身份证";
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [selectView addSubview:leftLabel];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, UIBounds.size.width-30, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView addSubview:line3];
        
        
        UIControl *shareControl1 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 61)];
        [selectView addSubview:shareControl1];
        [shareControl1 addTarget:self action:@selector(shareControl1:) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *selectView1 = [[UIView alloc] initWithFrame:CGRectMake(15, 81, UIBounds.size.width-30, 60)];
        selectView1.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView1];
        
//
        UILabel *leftLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100-30)/2, (61-15)/2, 100, 15)];
        leftLabel1.text = @"户口簿";
        leftLabel1.textAlignment = NSTextAlignmentCenter;
        leftLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        leftLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [selectView1 addSubview:leftLabel1];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, UIBounds.size.width-30, 1)];
        line1.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView1 addSubview:line1];
        
        UIImageView *line6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 60)];
        line6.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView1 addSubview:line6];
        
        UIImageView *line7 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-30, 0, 1, 60)];
        line7.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView1 addSubview:line7];
        
        
        UIControl *shareControl3 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 60)];
        [selectView1 addSubview:shareControl3];
        [shareControl3 addTarget:self action:@selector(shareControl3:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *selectView3 = [[UIView alloc] initWithFrame:CGRectMake(15, 151, UIBounds.size.width-30, 37)];
        selectView3.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView3];
        
        UILabel *leftLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100-30)/2, (37-15)/2, 100, 15)];
        leftLabel3.text = @"取消";
        leftLabel3.textColor = [UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0];
        leftLabel3.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        leftLabel3.textAlignment = NSTextAlignmentCenter;
        [selectView3 addSubview:leftLabel3];
        
        
        UIImageView *line8 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-30, 0, 1, 37)];
        line8.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView3 addSubview:line8];
        
        UIImageView *line9 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 37)];
        line9.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView3 addSubview:line9];
        
        UIImageView *line19 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 1)];
        line19.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView3 addSubview:line19];
        
        UIImageView *line17 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36, UIBounds.size.width-30, 1)];
        line17.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView3 addSubview:line17];
        
        
        UIControl *shareControl4 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 37)];
        [selectView3 addSubview:shareControl4];
        [shareControl4 addTarget:self action:@selector(shareControl4:) forControlEvents:UIControlEventTouchUpInside];
        
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
        self.frame = CGRectMake(0,view.frame.size.height - 208, UIBounds.size.width, 208);
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

- (void)shareControl1:(UIControl *)sender
{

    if (_delegate && [_delegate respondsToSelector:@selector(AirManType:)]) {
        
        [_delegate AirManType:@"身份证"];
        
    }
    
    [self hideInView];
    
    
}


- (void)shareControl3:(UIControl *)sender
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(AirManType:)]) {
        
        [_delegate AirManType:@"户口簿"];
        
    }
    
    [self hideInView];
    
}
//添加
- (void)shareControl4:(UIControl *)sender
{
    
    [self hideInView];

}

-(void)huiseControlClick{
    [self hideInView];
}

@end
