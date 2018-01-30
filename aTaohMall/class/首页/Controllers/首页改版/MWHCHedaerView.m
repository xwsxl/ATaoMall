//
//  MWHCHedaerView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MWHCHedaerView.h"
#import "DPModel.h"
@implementation MWHCHedaerView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self == [super initWithFrame:frame]) {
        
        [self initUI];
        
    }
    
    return self;
}

-(void)initUI
{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *SelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 83)];
    [self addSubview:SelectView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 82, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"fengexian"];
    [SelectView addSubview:line];
    
    UIView *One = [[UIView alloc] initWithFrame:CGRectMake(10, 10, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    [SelectView addSubview:One];
    
    
    
    self.OneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    self.OneImgView.image = [UIImage imageNamed:@"BGYT"];
    [One addSubview:self.OneImgView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.5;
    [One addSubview:view1];
    
    self.OneTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    self.OneTitle.backgroundColor = [UIColor clearColor];
//    self.OneTitle.alpha = 0.5;
    self.OneTitle.textColor=[UIColor whiteColor];
    self.OneTitle.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    self.OneTitle.textAlignment = NSTextAlignmentCenter;
//    self.OneTitle.text = @"粮食生鲜";
    [One addSubview:self.OneTitle];
    
    self.OneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.OneButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63);
    [One addSubview:self.OneButton];
    
    UIView *Two = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50)/4+20, 10, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    [SelectView addSubview:Two];
    
    
    
    self.TwoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    self.TwoImgView.image = [UIImage imageNamed:@"BGYT"];
    [Two addSubview:self.TwoImgView];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.5;
    [Two addSubview:view2];
    
    self.TwoTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    self.TwoTitle.textColor=[UIColor whiteColor];
    self.TwoTitle.backgroundColor = [UIColor clearColor];
//    self.TwoTitle.alpha = 0.5;
    self.TwoTitle.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    self.TwoTitle.textAlignment = NSTextAlignmentCenter;
//    self.TwoTitle.text = @"休闲食品";
    [Two addSubview:self.TwoTitle];
    
    self.TwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.TwoButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63);
    [Two addSubview:self.TwoButton];
    
    UIView *Three = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50)/4*2+30, 10, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    [SelectView addSubview:Three];
    
    
    
    self.ThreeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    self.ThreeImgView.image = [UIImage imageNamed:@"BGYT"];
    [Three addSubview:self.ThreeImgView];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    view3.backgroundColor = [UIColor blackColor];
    view3.alpha = 0.5;
    [Three addSubview:view3];
    
    self.ThreeTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    self.ThreeTitle.textColor=[UIColor whiteColor];
    self.ThreeTitle.backgroundColor  =[UIColor clearColor];
//    self.ThreeTitle.alpha = 0.5;
    self.ThreeTitle.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    self.ThreeTitle.textAlignment = NSTextAlignmentCenter;
//    self.ThreeTitle.text = @"营养滋补";
    [Three addSubview:self.ThreeTitle];
    
    self.ThreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ThreeButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63);
    [Three addSubview:self.ThreeButton];
    
    UIView *Four = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50)/4*3+40, 10, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    [SelectView addSubview:Four];
    
    
    
    self.FourImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    self.FourImgView.image = [UIImage imageNamed:@"BGYT"];
    [Four addSubview:self.FourImgView];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    view4.backgroundColor = [UIColor blackColor];
    view4.alpha = 0.5;
    [Four addSubview:view4];
    
    self.FourTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63)];
    self.FourTitle.backgroundColor  =[UIColor clearColor];
//    self.FourTitle.alpha = 0.5;
    self.FourTitle.textColor=[UIColor whiteColor];
    self.FourTitle.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    self.FourTitle.textAlignment = NSTextAlignmentCenter;
//    self.FourTitle.text = @"热销名酒";
    [Four addSubview:self.FourTitle];
    
    self.FourButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.FourButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-50)/4, 63);
    [Four addSubview:self.FourButton];
    
}

-(void)setArray:(NSArray *)Array
{
    
    _Array = Array;
    
    for (int i = 0; i < _Array.count; i++) {
        
        DPModel *model = _Array[i];
        
        if (i==0) {
            
            self.OneTitle.text = model.small_name;
            self.OneTitle.tag = [model.small_id integerValue]+100;
            self.OneButton.tag = [model.small_id integerValue];
            
        }else if(i==1){
            
            self.TwoTitle.text = model.small_name;
            self.TwoTitle.tag = [model.small_id integerValue]+100;
            self.TwoButton.tag = [model.small_id integerValue];
        }else if (i==2){
            
            self.ThreeTitle.text = model.small_name;
            self.ThreeTitle.tag = [model.small_id integerValue]+100;
            self.ThreeButton.tag = [model.small_id integerValue];
        }else if(i==3){
            
            self.FourTitle.text = model.small_name;
            self.FourTitle.tag = [model.small_id integerValue]+100;
            self.FourButton.tag = [model.small_id integerValue];
        }
    }
    
}
@end
