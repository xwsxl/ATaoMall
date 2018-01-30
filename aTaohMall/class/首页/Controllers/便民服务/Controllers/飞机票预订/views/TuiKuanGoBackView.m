//
//  TuiKuanGoBackView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TuiKuanGoBackView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface TuiKuanGoBackView()
{
    
    
}
@end

@implementation TuiKuanGoBackView

-(void)setText1:(NSString *)Text1
{
    _Text1 = Text1;
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 100)];
    selectView.backgroundColor = [UIColor whiteColor];
    [_shareListView addSubview:selectView];
    

    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    CGSize textSize = [_Text1 boundingRectWithSize:CGSizeMake(UIBounds.size.width-30-30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, textSize.width, textSize.height)];
    label1.text = _Text1;
    label1.numberOfLines=0;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [selectView addSubview:label1];
}

-(void)setText2:(NSString *)Text2
{
    _Text2 = Text2;
    
    UIView *selectView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 100)];
    selectView1.backgroundColor = [UIColor whiteColor];
    [_shareListView1 addSubview:selectView1];
    
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    CGSize textSize = [_Text2 boundingRectWithSize:CGSizeMake(UIBounds.size.width-30-30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, textSize.width, textSize.height)];
    label1.text = _Text2;
    label1.numberOfLines=0;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [selectView1 addSubview:label1];
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        //        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 17)];
        _shareListView2.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        [self addSubview:_shareListView2];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100-30)/2, 0, 100, 17)];
        title.text = @"退票说明";
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        [_shareListView2 addSubview:title];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100-30)/2-60, 8, 50, 1)];
        view1.backgroundColor = [UIColor whiteColor];
        [_shareListView2 addSubview:view1];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100-30)/2+110, 8, 50, 1)];
        view2.backgroundColor = [UIColor whiteColor];
        [_shareListView2 addSubview:view2];
        
        
        _shareListView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, UIBounds.size.width-30, 14)];
        _shareListView3.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        [self addSubview:_shareListView3];
        
        UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
        title3.text = @"去程";
        title3.textColor = [UIColor whiteColor];
        title3.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        [_shareListView3 addSubview:title3];
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, UIBounds.size.width-30, 100)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        _shareListView.layer.cornerRadius = 10;
        _shareListView.layer.masksToBounds = YES;
        [self addSubview:_shareListView];
        
        
        _shareListView4 = [[UIView alloc]initWithFrame:CGRectMake(0, 225, UIBounds.size.width-30, 14)];
        _shareListView4.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        [self addSubview:_shareListView4];
        
        UILabel *title4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
        title4.text = @"回程";
        title4.textColor = [UIColor whiteColor];
        title4.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        [_shareListView4 addSubview:title4];
        
        _shareListView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 245, UIBounds.size.width-30, 100)];
        _shareListView1.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        _shareListView1.layer.cornerRadius = 10;
        _shareListView1.layer.masksToBounds = YES;
        [self addSubview:_shareListView1];
        
        
        
        
        
        
                
    }
    return self;
}


- (void)showInView:(UIView *) view Text:(NSString *)text{
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
        self.frame = CGRectMake(15,100, UIBounds.size.width-30, 300);
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
