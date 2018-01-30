//
//  PeccancecyInfoCell.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PeccancecyInfoCell.h"

@implementation PeccancecyInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setMainView];
}

-(instancetype)init
{
    if ([super init]) {
        [self setMainView];
    }
    return self;
}

-(void)setMainView
{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 5)];
    view.backgroundColor=RGB(244, 244, 244);
    [self addSubview:view];
    
    self.markAndFineLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 25, 100, 12)];
    self.markAndFineLab.font=KNSFONT(12);
    self.markAndFineLab.textColor=RGB(51, 51, 51);
    self.markAndFineLab.text=@"扣0分 罚500元";
    [self addSubview:self.markAndFineLab];
    
    self.updateTimeLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-15-200, 20, 200, 12)];
    self.updateTimeLab.textAlignment=NSTextAlignmentRight;
    self.updateTimeLab.font=KNSFONT(11);
    self.updateTimeLab.textColor=RGB(51, 51, 51);
    self.updateTimeLab.text=@"2017-05-24 16:54:15";
    [self addSubview:self.updateTimeLab];
    
    UILabel *type=[[UILabel alloc]initWithFrame:CGRectMake(15, 57, 35, 13)];
    type.text=@"类型";
    type.textColor=RGB(51, 51, 51);
    type.font=KNSFONT(13);
    [self addSubview:type];
    
    CGSize size=[self.typeLab.text sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-30-45, 50)];
    
    self.typeLab=[[UILabel alloc]initWithFrame:CGRectMake(60, 57, size.width, size.height)];
    self.typeLab.font=KNSFONT(13);
    self.typeLab.numberOfLines=0;
    self.typeLab.textColor=RGB(51, 51, 51);
    [self addSubview:self.typeLab];
    
    UILabel *place=[[UILabel alloc]initWithFrame:CGRectMake(15, 57+40, 35, 13)];
    place.font=KNSFONT(13);
    place.textColor=RGB(51, 51, 51);
    place.text=@"地点";
    [self addSubview:place];
    
    CGSize size2=[self.placeLab.text sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-30-45, 50)];
    
    self.placeLab=[[UILabel alloc]initWithFrame:CGRectMake(60, 57+size.height+20, size2.width, size2.height)];
    self.placeLab.font=KNSFONT(13);
    self.placeLab.numberOfLines=0;
    self.placeLab.textColor=RGB(51, 51, 51);
    [self addSubview:self.placeLab];
    
}

-(void)changeFrame
{
    CGSize size=[self.typeLab.text sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-30-45, 50)];
    
    self.typeLab.frame=CGRectMake(60, 57-2, size.width, size.height);
    
    
    CGSize size2=[self.placeLab.text sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-30-45, 50)];

    self.placeLab.frame=CGRectMake(60, 57+38, size2.width, size2.height);
    
}
-(void)setStatesWithCanHandle:(NSString *)canHandle andType:(NSString *)type
{
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(120, 25, 60, 13)];
    lab.textColor=[UIColor whiteColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=KNSFONT(12);
    if ([canHandle isEqualToString:@"false"]) {
        //lab.backgroundColor=RGB(63, 139, 253);
      //  lab.text=@"不能处理";
    }else
    {
         if ([type isEqualToString:@"1"])
        {
            lab.backgroundColor=RGB(63, 139, 253);
            lab.text=@"处理中";
        }else if ([type isEqualToString:@"2"])
        {
            lab.backgroundColor=RGB(253, 63, 63);
            lab.text=@"已处理";
        }else
        {
            
        }
        
    }
    [self addSubview:lab];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
