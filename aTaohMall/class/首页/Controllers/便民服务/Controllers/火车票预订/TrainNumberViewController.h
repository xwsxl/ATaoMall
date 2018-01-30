//
//  TrainNumberViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainNumberDelegate <NSObject>

-(void)TrainRecordReloadData;

@end
@interface TrainNumberViewController : UIViewController

@property(nonatomic,copy) NSString *Start;//判断是否为起始城市

@property(nonatomic,copy) NSString *End;//判断是否为起始城市

@property(nonatomic,copy) NSString *Date;//判断是否为起始城市

@property(nonatomic,copy) NSString *Week;//判断是否为起始城市

@property(nonatomic,copy) NSString *train_date;		//发车日期，如：2015-07-01（务必按照此格式）  必传
@property(nonatomic,copy) NSString *from_station;		//出发站简码            有传，没有传空
@property(nonatomic,copy) NSString *from_city;		//出发站城市		必传
@property(nonatomic,copy) NSString *to_station;		//到达站简码		有传，没有传空
@property(nonatomic,copy) NSString *to_city;		//到达站城市		必传
@property(nonatomic,copy) NSString *time_type;		//最晚出发  0  ；最早出发  1  耗时最短  2;  必传   注: 默认为最早出发 time_type=1
@property(nonatomic,copy) NSString *che_type;		//车型	高铁动车 0； 特快直达  1：其他 2    必传   默认为 2

// 注：一下几个参数没选时，均没有

//出发站筛选(多选  逗号隔开)
@property(nonatomic,copy) NSString *from_station_names;		//出发站集合    例（深圳东,深圳北,...）

//到达站筛选(多选  逗号隔开)
@property(nonatomic,copy) NSString *to_station_names;		//到达站集合	 例（深圳东,深圳北,...）

//座位类型筛选(多选  逗号隔开)
@property(nonatomic,copy) NSString *seats;//座位类型集合	例（wz_price,yz_price,...）

@property(nonatomic,weak) id <TrainNumberDelegate> delegate;

@end
