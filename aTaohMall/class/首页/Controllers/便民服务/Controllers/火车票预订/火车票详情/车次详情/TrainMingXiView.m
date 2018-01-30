//
//  TrainMingXiView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/7/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainMingXiView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface TrainMingXiView()
{
    
    UILabel *PiaoJiaLabel;
    UILabel *PiaoJiaNumber;
    UILabel *JiJIanLabel;
    UILabel *JiJIanNumber;
    UILabel *BaiXianLabel;
    UILabel *BaiXianNumber;
    UILabel *InterLabel;
}
@end
@implementation TrainMingXiView


-(void)Price:(NSString *)price JiJian:(NSString *)fei BaoXian:(NSString *)interger
{
    PiaoJiaNumber.text = [NSString stringWithFormat:@"￥%@",price];
    JiJIanNumber.text = [NSString stringWithFormat:@"￥%@",fei];
    InterLabel.text = [NSString stringWithFormat:@"-￥%@",interger];
        
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
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 187)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 187)];
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
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-30, 1)];
        line1.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view addSubview:line1];
        
    
        UIView *PriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, UIBounds.size.width, 120)];
        [selectView addSubview:PriceView];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(23, 10, UIBounds.size.width-46, 13)];
        label3.text = @"*儿童票暂按成人票价收取，出票后将按实际价格返还差额。";
        label3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        
        if ([UIScreen mainScreen].bounds.size.width > 320) {
            
            label3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:13];
            
        }else{
            
            label3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:10];
        }
        
        NSLog(@"===label3==%@",label3.font);
        
        [PriceView addSubview:label3];
        
        NSString *stringForColor = [NSString stringWithFormat:@"*"];
        
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:label3.text];
        //
        NSRange range = [label3.text rangeOfString:stringForColor];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
        label3.attributedText=mAttStri;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(23, 40, 80, 14)];
        label1.text = @"票价";
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:label1];
        
        
        PiaoJiaNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23, 40, 80, 14)];
        PiaoJiaNumber.text = @"";
        PiaoJiaNumber.textAlignment = NSTextAlignmentRight;
        PiaoJiaNumber.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        PiaoJiaNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:PiaoJiaNumber];
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(23, 80, 80, 13)];
        label2.text = @"服务费";
        label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:label2];
        
        JiJIanNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23, 80, 80, 14)];
        JiJIanNumber.text = @"";
        JiJIanNumber.textAlignment = NSTextAlignmentRight;
        JiJIanNumber.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        JiJIanNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:JiJIanNumber];
        
        
        UIView *InterView = [[UIView alloc] initWithFrame:CGRectMake(0, 187-34, UIBounds.size.width, 34)];
        [selectView addSubview:InterView];
        
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(23, (34-13)/2, 80, 13)];
        label4.text = @"积分抵扣";
        label4.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label4.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [InterView addSubview:label4];
        
        InterLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-100-23, (34-14)/2, 100, 14)];
        InterLabel.text = @"";
        InterLabel.textAlignment = NSTextAlignmentRight;
        InterLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        InterLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [InterView addSubview:InterLabel];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 33, [UIScreen mainScreen].bounds.size.width, 1)];
        line4.image = [UIImage imageNamed:@"分割线-拷贝"];
        
        [InterView addSubview:line4];
        
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
        self.frame = CGRectMake(0,view.frame.size.height - 187-49, UIBounds.size.width, 187);
        [view addSubview:self];
    }
}


- (void)hideInView {
    
    if (_delegate && [_delegate respondsToSelector:@selector(TrainmingXi)]) {
        
        [_delegate TrainmingXi];
        
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
