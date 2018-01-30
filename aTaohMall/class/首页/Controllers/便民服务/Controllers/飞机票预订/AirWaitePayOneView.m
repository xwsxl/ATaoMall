//
//  AirWaitePayOneView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/5.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirWaitePayOneView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface AirWaitePayOneView()
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

@implementation AirWaitePayOneView


-(void)Price:(NSString *)price Inter:(NSString *)inter fuel_oil_airrax:(NSString *)fuel_oil_airrax aviation_accident_insurance_price:(NSString *)aviation_accident_insurance_price Number:(int)number is_aviation_accident_insurance:(NSString *)is_aviation_accident_insurance
{
    PiaoJiaLabel.text = [NSString stringWithFormat:@"￥%.02f",[price floatValue]];
    PiaoJiaNumber.text = [NSString stringWithFormat:@"x%d人",number];
    
    JiJIanLabel.text = [NSString stringWithFormat:@"￥%.02f",[fuel_oil_airrax floatValue]];
    JiJIanNumber.text = [NSString stringWithFormat:@"x%d人",number];
    
    BaiXianLabel.text = [NSString stringWithFormat:@"￥%.02f",[aviation_accident_insurance_price floatValue]];
    
    if ([is_aviation_accident_insurance isEqualToString:@"0"]) {
        
        BaiXianNumber.text = [NSString stringWithFormat:@"x0份"];
        
    }else{
        
        
        BaiXianNumber.text = [NSString stringWithFormat:@"x%d份",number];
    }
    
    
    InterLabel.text = [NSString stringWithFormat:@"-￥%.02f",[inter floatValue]];
    
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
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, UIBounds.size.width-30, 220)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        _shareListView.layer.cornerRadius = 10;
        _shareListView.layer.masksToBounds = YES;
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 220)];
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
        
        UIView *PriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, UIBounds.size.width, 120)];
        [selectView addSubview:PriceView];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(23, 20, 80, 14)];
        label1.text = @"票价(不含税)";
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:label1];
        
        PiaoJiaLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, UIBounds.size.width-100, 14)];
        PiaoJiaLabel.text = @"";
        PiaoJiaLabel.textAlignment = NSTextAlignmentCenter;
        PiaoJiaLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        PiaoJiaLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [PriceView addSubview:PiaoJiaLabel];
        
        
        PiaoJiaNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23-30, 20, 80, 14)];
        PiaoJiaNumber.text = @"";
        PiaoJiaNumber.textAlignment = NSTextAlignmentRight;
        PiaoJiaNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        PiaoJiaNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:PiaoJiaNumber];
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(23, 54, 80, 13)];
        label2.text = @"机建+燃油";
        label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label2.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:label2];
        
        JiJIanLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 54, UIBounds.size.width-100, 14)];
        JiJIanLabel.text = @"";
        JiJIanLabel.textAlignment = NSTextAlignmentCenter;
        JiJIanLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        JiJIanLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [PriceView addSubview:JiJIanLabel];
        
        
        JiJIanNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23-30, 54, 80, 14)];
        JiJIanNumber.text = @"";
        JiJIanNumber.textAlignment = NSTextAlignmentRight;
        JiJIanNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        JiJIanNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:JiJIanNumber];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(23, 87, 80, 13)];
        label3.text = @"航空意外险";
        label3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label3.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:label3];
        
        BaiXianLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 87, UIBounds.size.width-100, 14)];
        BaiXianLabel.text = @"";
        BaiXianLabel.textAlignment = NSTextAlignmentCenter;
        BaiXianLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        BaiXianLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [PriceView addSubview:BaiXianLabel];
        
        
        BaiXianNumber = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-23-30, 87, 80, 14)];
        BaiXianNumber.text = @"";
        BaiXianNumber.textAlignment = NSTextAlignmentRight;
        BaiXianNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        BaiXianNumber.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [PriceView addSubview:BaiXianNumber];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 119.5, UIBounds.size.width-30, 0.5)];
        line2.image = [UIImage imageNamed:@"xuxian"];
        [PriceView addSubview:line2];
        
        UIView *InterView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, UIBounds.size.width, 34)];
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
        self.frame = CGRectMake(0,(view.frame.size.height - 220)/2, UIBounds.size.width, 220);
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
