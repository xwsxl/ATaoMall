//
//  CheCiChangeView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/15.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CheCiChangeView.h"
#import "BianMinModel.h"
#import "TrainToast.h"
#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface CheCiChangeView ()
{
    UIImageView *Wanimg;
    UIImageView *Duanimg;
    UIImageView *zaoimg;
    
}
@end

@implementation CheCiChangeView


-(void)setArray:(NSArray *)Array
{
    
    _Array = Array;
    
    //清空视图
    
    for (UIView *view in _shareListView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
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
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    leftLabel.text = @"坐席类型";
    leftLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
    [title addSubview:leftLabel];
    
    UIImageView *xiala = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, (50-10)/2, 16, 10)];
    xiala.image = [UIImage imageNamed:@"下拉"];
    [title addSubview:xiala];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [title addSubview:line];
    
    
    UIView *RightView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 250)];
    RightView.backgroundColor = [UIColor whiteColor];
    [_shareListView addSubview:RightView];
    
    for (int i=0; i < _Array.count; i++) {
        
        BianMinModel *model = _Array[i];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, [UIScreen mainScreen].bounds.size.width, 50)];
        [RightView addSubview:view1];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view1 addSubview:line3];
        
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        shareLabel.text = model.Detail_name;
        shareLabel.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:shareLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, (50-13)/2, [UIScreen mainScreen].bounds.size.width-200, 13)];
        priceLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        priceLabel.text = [NSString stringWithFormat:@"￥%@",model.Detail_price];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:priceLabel];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-14-16, (50-10)/2, 14, 10)];
        if ([model.Detail_select isEqualToString:@"1"]) {
            
            line4.image = [UIImage imageNamed:@"勾选"];
        }else{
            
            line4.image = [UIImage imageNamed:@""];
        }
        
        line4.tag=i+21;
        
        [view1 addSubview:line4];
        
        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        shareControl.tag = i+10;
        [view1 addSubview:shareControl];
        [shareControl addTarget:self action:@selector(shareControl2:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 300)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        [self addSubview:_shareListView];
        
        
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
        self.frame = CGRectMake(0,view.frame.size.height - 300, UIBounds.size.width, 300);
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
    for (int i = 0; i < _Array.count; i++) {
        
        BianMinModel *model = _Array[i];
        model.Detail_select = @"";
        
    }
    
    BianMinModel *model = _Array[sender.tag-10];
    
    
    NSLog(@"===model.Detail_num===%@",model.Detail_num);
    
    if ([model.Detail_num isEqualToString:@"0"]) {
        
        [TrainToast showWithText:@"该座次票已售完！" duration:2.0f];
        
    }else{
        
        model.Detail_select = @"1";
        
        UIImageView *imgView = (UIImageView *)[self viewWithTag:sender.tag+11];
        imgView.image = [UIImage imageNamed:@"勾选"];
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(Price:ZW:Array:Is_accept_standing:)]) {
            
            [_delegate Price:[NSString stringWithFormat:@"%@￥%@",model.Detail_name,model.Detail_price] ZW:model.zwcode Array:_Array Is_accept_standing:model.is_accept_standing];
            
        }
        [self hideInView];
        
    }
    
}

-(void)huiseControlClick{
    [self hideInView];
}

@end
