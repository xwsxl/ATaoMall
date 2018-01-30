//
//  AirPlaneBackViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPlaneBackViewController : UIViewController

@property(nonatomic,copy) NSString *TypeString;

@property(nonatomic,strong) NSArray *DateArray;

@property(nonatomic,strong) NSMutableArray *DateArrM;

@property(nonatomic,copy) NSString *StartCity;
@property(nonatomic,copy) NSString *ArriveCity;

@property(nonatomic,copy) NSString *DateWeek;

@property(nonatomic,copy) NSString *ManOrKidString;//判断选择的是成人还是儿童

@property(nonatomic,copy) NSString *Type;//判断是否返程

@property(nonatomic,copy) NSString *BackDate;//返程日期

@property(nonatomic,copy) NSString *Back;//返程日期

@property(nonatomic,assign) int Index;

@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *start_city;
@property(nonatomic,copy) NSString *arrive_city;
@property(nonatomic,copy) NSString *start_code;
@property(nonatomic,copy) NSString *arrive_code;

@property(nonatomic,copy) NSString *airline_airway;
@property(nonatomic,copy) NSString *shipping_space;
@property(nonatomic,copy) NSString *plane_type;
@property(nonatomic,copy) NSString *price_high_low;
@property(nonatomic,copy) NSString *time_long_short;

@end
