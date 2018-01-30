//
//  DPOtherHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "DPOtherHeaderView.h"

#import "DPModel.h"
@implementation DPOtherHeaderView

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
    
    UIView *SelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [self addSubview:SelectView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"fengexian"];
    [SelectView addSubview:line];
    
    UIView *One = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, 63)];
    [SelectView addSubview:One];
    
    self.OneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.OneButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, 63);
    [One addSubview:self.OneButton];
    
    self.OneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4.5, [UIScreen mainScreen].bounds.size.width/4, 33)];
    self.OneImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.OneImgView.image = [UIImage imageNamed:@"icon-dianshi"];
    [One addSubview:self.OneImgView];
    
    self.OneTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, [UIScreen mainScreen].bounds.size.width/4, 11.5)];
    self.OneTitle.textColor=[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    self.OneTitle.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    self.OneTitle.textAlignment = NSTextAlignmentCenter;
//    self.OneTitle.text = @"大家电";
    [One addSubview:self.OneTitle];
    
    UIView *Two = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4, 0, [UIScreen mainScreen].bounds.size.width/4, 63)];
    [SelectView addSubview:Two];
    
    self.TwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.TwoButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, 63);
    [Two addSubview:self.TwoButton];
    
    self.TwoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4.5, [UIScreen mainScreen].bounds.size.width/4, 33)];
    self.TwoImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.TwoImgView.image = [UIImage imageNamed:@"icon-fengshan"];
    [Two addSubview:self.TwoImgView];
    
    self.TwoTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, [UIScreen mainScreen].bounds.size.width/4, 11.5)];
    self.TwoTitle.textColor=[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    self.TwoTitle.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    self.TwoTitle.textAlignment = NSTextAlignmentCenter;
//    self.TwoTitle.text = @"生活电器";
    [Two addSubview:self.TwoTitle];
    
    UIView *Three = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*2, 0, [UIScreen mainScreen].bounds.size.width/4, 63)];
    [SelectView addSubview:Three];
    
    self.ThreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ThreeButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, 63);
    [Three addSubview:self.ThreeButton];
    
    self.ThreeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4.5, [UIScreen mainScreen].bounds.size.width/4, 33)];
    self.ThreeImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.ThreeImgView.image = [UIImage imageNamed:@"icon-chufang"];
    [Three addSubview:self.ThreeImgView];
    
    self.ThreeTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, [UIScreen mainScreen].bounds.size.width/4, 11.5)];
    self.ThreeTitle.textColor=[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    self.ThreeTitle.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    self.ThreeTitle.textAlignment = NSTextAlignmentCenter;
//    self.ThreeTitle.text = @"厨房电器";
    [Three addSubview:self.ThreeTitle];
    
    UIView *Four = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*3, 0, [UIScreen mainScreen].bounds.size.width/4, 63)];
    [SelectView addSubview:Four];
    
    self.FourButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.FourButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, 63);
    [Four addSubview:self.FourButton];
    
    self.FourImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4.5, [UIScreen mainScreen].bounds.size.width/4, 33)];
    self.FourImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.FourImgView.image = [UIImage imageNamed:@"icon-dian-chui-feng"];
    [Four addSubview:self.FourImgView];
    
    self.FourTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, [UIScreen mainScreen].bounds.size.width/4, 11.5)];
    self.FourTitle.textColor=[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    self.FourTitle.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    self.FourTitle.textAlignment = NSTextAlignmentCenter;
//    self.FourTitle.text = @"个人健康";
    [Four addSubview:self.FourTitle];
    
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
