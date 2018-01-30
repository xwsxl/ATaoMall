//
//  CalendarDayCell.m
//  tttttt
//
//  Created by 张凡 on 14-8-20.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarDayCell.h"

@implementation CalendarDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
//    self.backgroundColor=[UIColor orangeColor];
    
//    NSLog(@"====self.bounds.size.width====%f==",self.bounds.size.width);
    
    //选中时显示的图片
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width-30)/2, 0, 30, 30)];
    imgview.image = [UIImage imageNamed:@"selected-day"];
    [self addSubview:imgview];
    
    //日期
    day_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self addSubview:day_lab];
    
//    Fenge = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, self.bounds.size.width, 1)];
//    Fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
//    [self addSubview:Fenge];
    
//    //农历
//    day_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-15, self.bounds.size.width, 13)];
//    day_title.textColor = [UIColor lightGrayColor];
//    day_title.font = [UIFont boldSystemFontOfSize:10];
//    day_title.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:day_title];
    

}


- (void)setModel:(CalendarDayModel *)model
{


    switch (model.style) {
        case CellDayTypeEmpty://不显示
            [self hidden_YES];
            
         //   [self hidden_NO];
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            day_lab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            Fenge.hidden = YES;
            break;
            
        case CellDayTypePast://过去的日期
            [self hidden_NO];
            
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            
            day_lab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            if([[NSString stringWithFormat:@"%d",model.day] intValue] >=25){
                
                Fenge.hidden = NO;
            }else{
                
                Fenge.hidden = YES;
            }
            break;
            
        case CellDayTypeFutur://将来的日期
            [self hidden_NO];
            
            if (model.holiday) {
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor blackColor];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%d",model.day];
                day_lab.textColor = [UIColor blackColor];
            }
            
           if([[NSString stringWithFormat:@"%d",model.day] intValue] >=25){
               
               Fenge.hidden = NO;
           }else{
               
               Fenge.hidden = YES;
           }
            
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
            
        case CellDayTypeWeek://周末
            [self hidden_NO];
            
            if (model.holiday) {
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor orangeColor];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%d",model.day];
                day_lab.textColor = [UIColor blackColor];
            }
            
            if([[NSString stringWithFormat:@"%d",model.day] intValue] >=25){
                
                Fenge.hidden = NO;
            }else{
                
                Fenge.hidden = YES;
            }
            
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
            
        case CellDayTypeClick://被点击的日期
            [self hidden_NO];
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            day_lab.textColor = [UIColor whiteColor];
            day_title.text = model.Chinese_calendar;
            imgview.hidden = NO;
            
            if([[NSString stringWithFormat:@"%d",model.day] intValue] >=25){
                
                Fenge.hidden = NO;
            }else{
                
                Fenge.hidden = YES;
            }
            break;
            
        default:
            
            break;
    }


}



- (void)hidden_YES{
    
    day_lab.hidden = YES;
    day_title.hidden = YES;
    imgview.hidden = YES;
    Fenge.hidden = YES;
}


- (void)hidden_NO{
    
    day_lab.hidden = NO;
    day_title.hidden = NO;
    
}


@end
