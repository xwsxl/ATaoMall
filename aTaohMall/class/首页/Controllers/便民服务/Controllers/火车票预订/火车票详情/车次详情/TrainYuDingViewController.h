//
//  TrainYuDingViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/15.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainYuDingViewController : UIViewController

@property(nonatomic,copy) NSString *phone;

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

@property(nonatomic,copy)NSString *zwcode;
@property(nonatomic,copy)NSString *run_time;
@property(nonatomic,copy)NSString *che_type;
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *total_number;
@property(nonatomic,copy)NSString *is_accept_standing;
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *Price;
@property(nonatomic,strong)NSArray *PriceArray;
@property(nonatomic,copy)NSString *TypeString;
@property(nonatomic,copy) NSString *TicketCount;
@end
