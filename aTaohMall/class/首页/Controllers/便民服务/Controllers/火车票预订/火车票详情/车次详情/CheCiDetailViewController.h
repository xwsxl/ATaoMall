//
//  CheCiDetailViewController.h
//  火车票
//
//  Created by 阳涛 on 17/5/13.
//  Copyright © 2017年 yangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheCiDetailViewController : UIViewController

@property(nonatomic,copy)NSString *DateString;//日期

@property(nonatomic,copy)NSString *train_date;			//发车日期，如：2017-07-01（务必按照此格式）
@property(nonatomic,copy)NSString *from_station;		//出发站简码
@property(nonatomic,copy)NSString *to_station;			//到达站简码
@property(nonatomic,copy)NSString *train_code;			//车次       如：K507
@property(nonatomic,copy)NSString *start_time;			//出发时刻       (格式   12:00)

@property(nonatomic,copy) NSString *LoginBack;//判断返回界面
@property(nonatomic,copy)NSString *StartTime;
@property(nonatomic,copy)NSString *ArriveTime;
@property(nonatomic,copy)NSString *RunTime;
@property(nonatomic,copy)NSString *CheCi;
@property(nonatomic,copy)NSString *StartCity;
@property(nonatomic,copy)NSString *ArriveCity;

@property(nonatomic,copy)NSString *Week;

@property(nonatomic,copy)NSString *Date;

@property(nonatomic,copy)NSString *sigen;

@property(nonatomic,copy)NSString *run_time;
@property(nonatomic,copy)NSString *che_type;

@end
