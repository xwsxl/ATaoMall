//
//  CustomPaiXuView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CustomPaiXuView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface CustomPaiXuView ()
{
    UIImageView *Wanimg;
    UIImageView *Duanimg;
    UIImageView *zaoimg;
    
}
@end
@implementation CustomPaiXuView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 200)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        [self addSubview:_shareListView];
        
        
        UIView *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 50)];
        [_shareListView addSubview:title];
        
//        UIButton *titleButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//        titleButton.frame = CGRectMake(0, 0, UIBounds.size.width, 50);
//        [titleButton addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [title addSubview:titleButton];
        
        UIControl *shareControl1 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 50)];
        shareControl1.tag = 1;
        [_shareListView addSubview:shareControl1];
        [shareControl1 addTarget:self action:@selector(shareControl1:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 60, 14)];
        leftLabel.text = @"排序";
        leftLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [title addSubview:leftLabel];
        
        UIImageView *xiala = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, (50-10)/2, 16, 10)];
        xiala.image = [UIImage imageNamed:@"下拉"];
        [title addSubview:xiala];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [title addSubview:line];
        
        UIView *Zao = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, UIBounds.size.width, 50)];
        [_shareListView addSubview:Zao];
        
       
        
//        UIButton *ZaoButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//        ZaoButton.userInteractionEnabled=YES;
//        ZaoButton.frame = CGRectMake(0, 0, UIBounds.size.width, 50);
//        [ZaoButton addTarget:self action:@selector(ZaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [Zao addSubview:ZaoButton];
        
        UIControl *shareControl2 = [[UIControl alloc]initWithFrame:CGRectMake(0, 50, UIBounds.size.width, 50)];
        shareControl2.tag = 2;
        [_shareListView addSubview:shareControl2];
        [shareControl2 addTarget:self action:@selector(shareControl2:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *ZaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
        ZaoLabel.text = @"最早出发";
        ZaoLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ZaoLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        [Zao addSubview:ZaoLabel];
        
        zaoimg = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, (50-10)/2, 14, 10)];
        zaoimg.image = [UIImage imageNamed:@"勾选"];
        [Zao addSubview:zaoimg];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        line1.image = [UIImage imageNamed:@"分割线-拷贝"];
        [Zao addSubview:line1];
        
        UIView *Wan = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, UIBounds.size.width, 50)];
        [_shareListView addSubview:Wan];
        
//        UIButton *WanButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//        WanButton.frame = CGRectMake(0, 0, UIBounds.size.width, 50);
//        [WanButton addTarget:self action:@selector(WanBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [Wan addSubview:WanButton];
        
        UIControl *shareControl3 = [[UIControl alloc]initWithFrame:CGRectMake(0, 100, UIBounds.size.width, 50)];
        shareControl3.tag = 3;
        [_shareListView addSubview:shareControl3];
        [shareControl3 addTarget:self action:@selector(shareControl3:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *WanLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
        WanLabel.text = @"最晚出发";
        WanLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        WanLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        [Wan addSubview:WanLabel];
        
        Wanimg = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, (50-10)/2, 14, 10)];
        Wanimg.image = [UIImage imageNamed:@""];
        [Wan addSubview:Wanimg];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [Wan addSubview:line3];
        
        UIView *Duan = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, UIBounds.size.width, 50)];
        [_shareListView addSubview:Duan];
        
        UILabel *DuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
        DuanLabel.text = @"耗时最短";
        DuanLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        DuanLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        [Duan addSubview:DuanLabel];
        
        Duanimg = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, (50-10)/2, 14, 10)];
        Duanimg.image = [UIImage imageNamed:@""];
        [Duan addSubview:Duanimg];
        
//        UIButton *DuanButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//        DuanButton.frame = CGRectMake(0, 0, UIBounds.size.width, 50);
//        [DuanButton addTarget:self action:@selector(DuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [Duan addSubview:DuanButton];
        
        UIControl *shareControl4 = [[UIControl alloc]initWithFrame:CGRectMake(0, 150, UIBounds.size.width, 50)];
        shareControl4.tag = 4;
        [_shareListView addSubview:shareControl4];
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
        self.frame = CGRectMake(0,view.frame.size.height - 200, UIBounds.size.width, 200);
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
    
    [self hideInView];
}

- (void)shareControl2:(UIControl *)sender
{
    

    zaoimg.image = [UIImage imageNamed:@"勾选"];
    Wanimg.image = [UIImage imageNamed:@""];
    Duanimg.image = [UIImage imageNamed:@""];
    
    if (_delegate && [_delegate respondsToSelector:@selector(PaiXuString:)]) {
        
        [_delegate PaiXuString:@"1"];
        
    }
    [self hideInView];
}

- (void)shareControl3:(UIControl *)sender
{
    

    zaoimg.image = [UIImage imageNamed:@""];
    Wanimg.image = [UIImage imageNamed:@"勾选"];
    Duanimg.image = [UIImage imageNamed:@""];
    
    if (_delegate && [_delegate respondsToSelector:@selector(PaiXuString:)]) {
        
        [_delegate PaiXuString:@"0"];
        
    }
    
    [self hideInView];
}

- (void)shareControl4:(UIControl *)sender
{
    

    zaoimg.image = [UIImage imageNamed:@""];
    Wanimg.image = [UIImage imageNamed:@""];
    Duanimg.image = [UIImage imageNamed:@"勾选"];
    
    if (_delegate && [_delegate respondsToSelector:@selector(PaiXuString:)]) {
        
        [_delegate PaiXuString:@"2"];
        
    }
    
    [self hideInView];
}

- (void)shareControl:(UIControl *)sender
{
    
    NSLog(@"点击的第%ld个",(long)sender.tag);
    
}

-(void)titleBtnClick
{
    
    
}

-(void)ZaoBtnClick
{
    NSLog(@"666");
    zaoimg.image = [UIImage imageNamed:@"勾选"];
    Wanimg.image = [UIImage imageNamed:@""];
    Duanimg.image = [UIImage imageNamed:@""];
    
}

-(void)WanBtnClick
{
    
    zaoimg.image = [UIImage imageNamed:@""];
    Wanimg.image = [UIImage imageNamed:@"勾选"];
    Duanimg.image = [UIImage imageNamed:@""];
}

-(void)DuanBtnClick
{
    zaoimg.image = [UIImage imageNamed:@""];
    Wanimg.image = [UIImage imageNamed:@""];
    Duanimg.image = [UIImage imageNamed:@"勾选"];
    
}
-(void)huiseControlClick{
    [self hideInView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
