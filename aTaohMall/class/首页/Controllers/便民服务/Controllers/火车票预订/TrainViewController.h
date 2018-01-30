//
//  TrainViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainViewController : UIViewController

@property(nonatomic,copy) NSString *Type;//判断是否为起始城市

@property(nonatomic,copy) NSString *Date;//判断是否为起始城市

@property(nonatomic,copy) NSString *Week;//判断是否为起始城市

@property(nonatomic,copy) NSString *GoDateString;//出发日期


@property(nonatomic,copy) NSString *train_date;		//发车日期，如：2015-07-01（务必按照此格式）  必传
@property(nonatomic,copy) NSString *from_station;		//出发站简码            有传，没有传空
@property(nonatomic,copy) NSString *from_city;		//出发站城市		必传
@property(nonatomic,copy) NSString *to_station;		//到达站简码		有传，没有传空
@property(nonatomic,copy) NSString *to_city;		//到达站城市		必传


@end
