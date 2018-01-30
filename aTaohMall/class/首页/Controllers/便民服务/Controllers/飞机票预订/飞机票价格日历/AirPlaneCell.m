//
//  AirPlaneCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneCell.h"

@implementation AirPlaneCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    //选中时显示的图片
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width-40)/2, 0, 40, 40)];
    imgview.image = [UIImage imageNamed:@"selected-day"];
    [self addSubview:imgview];
    
    //日期
    day_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, (40-15)/2, self.bounds.size.width, 15)];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.textColor = [UIColor blackColor];
    day_lab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [self addSubview:day_lab];
    

    
    
}


- (void)setModel:(CalendarDayModel *)model
{
    
    
    switch (model.style) {
        case CellDayTypeEmpty://不显示
            [self hidden_YES];
            
            break;
            
        case CellDayTypePast://过去的日期
            [self hidden_NO];
            

            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            if (model.holiday) {
                day_lab.text = model.holiday;
            }
            day_lab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            day_title.hidden=YES;
            imgview.hidden = YES;
            
          //  NSLog(@"====过去的日记====");
            
            break;
            
        case CellDayTypeFutur://将来的日期
            [self hidden_NO];
            
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            if (model.holiday) {
                day_lab.text = model.holiday;
            }
            day_lab.textColor = [UIColor blackColor];
            imgview.hidden = YES;
            
            
            break;
            
        case CellDayTypeWeek://周末
            [self hidden_NO];
            
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            day_lab.textColor = [UIColor blackColor];

            imgview.hidden = YES;
            
            break;
            
//        case CellDayTypeToday://周末
//            [self hidden_NO];
//            
//
//            day_lab.text = @"今天";
//            day_lab.textColor = [UIColor orangeColor];
//            
//            imgview.hidden = YES;
//            
//            break;
            
        case CellDayTypeClick://被点击的日期
            [self hidden_NO];
            
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            day_lab.textColor = [UIColor whiteColor];
            day_title.textColor = [UIColor whiteColor];
            imgview.hidden = NO;
            
            break;
            
        default:
            
            break;
    }
    
    
}



- (void)hidden_YES{
    
    day_lab.hidden = YES;
    day_title.hidden = YES;
    imgview.hidden = YES;
    
}


- (void)hidden_NO{
    
    day_lab.hidden = NO;
    day_title.hidden = NO;
    
}

@end
