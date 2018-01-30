//
//  AirBaoXianView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/1.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirBaoXianView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@implementation AirBaoXianView

-(void)setText:(NSString *)Text
{
    
    _Text = Text;
    
    NSLog(@"====self.Text===%@",self.Text);
    
    
    self.hidden = YES;
    _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
    _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
    [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
    _huiseControl.alpha=0;
    //        self.backgroundColor = [UIColor whiteColor];
    
    
    _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 336)];
    _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 0);
    _shareListView.layer.cornerRadius = 10;
    _shareListView.layer.masksToBounds = YES;
    [self addSubview:_shareListView];
    
    
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 336)];
    selectView.backgroundColor = [UIColor whiteColor];
    [_shareListView addSubview:selectView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, UIBounds.size.width-50, 17)];
    titleLabel.text = @"航空意外险说明";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:18];
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [selectView addSubview:titleLabel];
    
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    CGSize textSize = [self.Text boundingRectWithSize:CGSizeMake(UIBounds.size.width-30-30, 336-50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, UIBounds.size.width-60, 200)];
    label1.text = self.Text;
    label1.numberOfLines=0;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [selectView addSubview:label1];
    
    
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //        self.hidden = YES;
        //        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        //        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        //        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        //        _huiseControl.alpha=0;
        ////        self.backgroundColor = [UIColor whiteColor];
        //
        //
        //        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 336)];
        //        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        //        _shareListView.layer.cornerRadius = 10;
        //        _shareListView.layer.masksToBounds = YES;
        //        [self addSubview:_shareListView];
        //
        //
        //
        //        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 336)];
        //        selectView.backgroundColor = [UIColor whiteColor];
        //        [_shareListView addSubview:selectView];
        //
        //        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, UIBounds.size.width-50, 17)];
        //        titleLabel.text = @"退改签说明";
        //        titleLabel.textAlignment = NSTextAlignmentCenter;
        //        titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:18];
        //        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [selectView addSubview:titleLabel];
        //
        //
        //        NSLog(@"====456===%@",self.Text);
        //
        //        UIFont *font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        CGSize textSize = [self.Text boundingRectWithSize:CGSizeMake(UIBounds.size.width-30-30, 336-50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
        //
        //        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, UIBounds.size.width-30-30, textSize.height)];
        //        label1.text = self.Text;
        //        label1.textAlignment = NSTextAlignmentLeft;
        //        label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [selectView addSubview:label1];
        
        
        //
        //        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 336)];
        //        selectView.backgroundColor = [UIColor whiteColor];
        //        [_shareListView addSubview:selectView];
        //
        //        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, UIBounds.size.width-50, 17)];
        //        titleLabel.text = @"退改签说明";
        //        titleLabel.textAlignment = NSTextAlignmentCenter;
        //        titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:18];
        //        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [selectView addSubview:titleLabel];
        //
        //        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(15, 57, UIBounds.size.width-60, 258)];
        //        //        titleView.backgroundColor = [UIColor orangeColor];
        //        [selectView addSubview:titleView];
        //
        //        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-60, 30)];
        //        view1.backgroundColor = [UIColor whiteColor];
        //        [titleView addSubview:view1];
        //
        //        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(11, (33-12)/2, 80, 12)];
        //        label1.text = @"舱位";
        //        label1.textAlignment = NSTextAlignmentLeft;
        //        label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [view1 addSubview:label1];
        //
        //        UILabel *textlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(90, (33-12)/2, UIBounds.size.width-60-90, 12)];
        //        textlabel1.text = @"经济舱(E1)";
        //        textlabel1.textAlignment = NSTextAlignmentLeft;
        //        textlabel1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        textlabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [view1 addSubview:textlabel1];
        //
        //        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 31, UIBounds.size.width-60, 30)];
        //        view2.backgroundColor = [UIColor whiteColor];
        //        [titleView addSubview:view2];
        //
        //        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(11, (33-12)/2, 80, 12)];
        //        label2.text = @"票面价";
        //        label2.textAlignment = NSTextAlignmentLeft;
        //        label2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [view2 addSubview:label2];
        //
        //        UILabel *textlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(90, (33-12)/2, UIBounds.size.width-60-90, 12)];
        //        textlabel2.text = @"¥600(不含税)";
        //        textlabel2.textAlignment = NSTextAlignmentLeft;
        //        textlabel2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        textlabel2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [view2 addSubview:textlabel2];
        //
        //        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 63, UIBounds.size.width-60, 80)];
        //        view3.backgroundColor = [UIColor whiteColor];
        //        [titleView addSubview:view3];
        //
        //        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(11, (83-12)/2, 80, 12)];
        //        label3.text = @"退票费";
        //        label3.textAlignment = NSTextAlignmentLeft;
        //        label3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        label3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [view3 addSubview:label3];
        //
        //        for (int i =0; i < 3; i++) {
        //
        //            UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(11+80, (33-12)/2+12*i+12*i, 12, 12)];
        //            line1.image = [UIImage imageNamed:@"icon-time-tuigai"];
        //            [view3 addSubview:line1];
        //
        //            UILabel *textlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(110, (33-12)/2+12*i+12*i, UIBounds.size.width-60-100, 12)];
        //            textlabel3.text = @"起飞前72小时前";
        //            textlabel3.textAlignment = NSTextAlignmentLeft;
        //            textlabel3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //            textlabel3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //            [view3 addSubview:textlabel3];
        //
        //            UILabel *textlabel33 = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-60-100, (33-12)/2+12*i+12*i, 90, 12)];
        //            textlabel33.text = @"¥200/人(60%)";
        //            textlabel33.textAlignment = NSTextAlignmentRight;
        //            textlabel33.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //            textlabel33.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //            [view3 addSubview:textlabel33];
        //
        //        }
        //
        //        UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 64+80, UIBounds.size.width-60, 80)];
        //        view4.backgroundColor = [UIColor whiteColor];
        //        [titleView addSubview:view4];
        //
        //        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(11, (83-35)/2, 50, 35)];
        //        label4.text = @"同期改 期费";
        //        label4.textAlignment = NSTextAlignmentLeft;
        //        label4.numberOfLines=2;
        //        label4.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        label4.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [view4 addSubview:label4];
        //
        //        for (int i =0; i < 3; i++) {
        //
        //            UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(11+80, (33-12)/2+12*i+12*i, 12, 12)];
        //            line1.image = [UIImage imageNamed:@"icon-time-tuigai"];
        //            [view4 addSubview:line1];
        //
        //            UILabel *textlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(110, (33-12)/2+12*i+12*i, UIBounds.size.width-60-100, 12)];
        //            textlabel3.text = @"起飞前72小时前";
        //            textlabel3.textAlignment = NSTextAlignmentLeft;
        //            textlabel3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //            textlabel3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //            [view4 addSubview:textlabel3];
        //
        //            UILabel *textlabel33 = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-60-100, (33-12)/2+12*i+12*i, 90, 12)];
        //            textlabel33.text = @"¥200/人(60%)";
        //            textlabel33.textAlignment = NSTextAlignmentRight;
        //            textlabel33.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //            textlabel33.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //            [view4 addSubview:textlabel33];
        //
        //        }
        //
        //
        //        UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, 65+80+80, UIBounds.size.width-60, 30)];
        //        view5.backgroundColor = [UIColor whiteColor];
        //        [titleView addSubview:view5];
        //
        //        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(11, (33-12)/2, 70, 12)];
        //        label5.text = @"转签";
        //        label5.textAlignment = NSTextAlignmentLeft;
        //        label5.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        label5.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [view5 addSubview:label5];
        //
        //        UILabel *textlabel5 = [[UILabel alloc] initWithFrame:CGRectMake(90, (33-12)/2, UIBounds.size.width-60-90, 12)];
        //        textlabel5.text = @"不可转签";
        //        textlabel5.textAlignment = NSTextAlignmentLeft;
        //        textlabel5.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        //        textlabel5.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        //        [view5 addSubview:textlabel5];
        //
        //
        //        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-60, 1)];
        //        line1.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line1];
        //
        //        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 31, UIBounds.size.width-60, 1)];
        //        line2.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line2];
        //
        //        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 62, UIBounds.size.width-60, 1)];
        //        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line3];
        //
        //        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 143, UIBounds.size.width-60, 1)];
        //        line4.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line4];
        //
        //        UIImageView *line5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 224, UIBounds.size.width-60, 1)];
        //        line5.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line5];
        //
        //        UIImageView *line6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 257, UIBounds.size.width-60, 1)];
        //        line6.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line6];
        //
        //        UIImageView *line7 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 258)];
        //        line7.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line7];
        //
        //        UIImageView *line8 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0, 1, 258)];
        //        line8.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line8];
        //
        //        UIImageView *line9 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-60-1, 0, 1, 258)];
        //        line9.image = [UIImage imageNamed:@"分割线-拷贝"];
        //        [titleView addSubview:line9];
        
        
        
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
        self.frame = CGRectMake(15,(UIBounds.size.height - 336)/2, UIBounds.size.width-30, 336);
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
