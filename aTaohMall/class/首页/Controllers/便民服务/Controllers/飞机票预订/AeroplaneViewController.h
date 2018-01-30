//
//  AeroplaneViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AeroplaneViewController : UIViewController

@property(nonatomic,copy) NSString *TypeString;

@property(nonatomic,copy) NSString *StartTimeString;//出发时间

@property(nonatomic,copy) NSString *StartTimeLabelStr;

@property(nonatomic,copy) NSString *BackDate;//返程日期

@property(nonatomic,copy) NSString *ManOrKidString;//判断选择的是成人还是儿童

@property(nonatomic,assign) int Index;

@property(nonatomic,copy) NSString *CityString;

@property(nonatomic,copy) NSString *arrive_city;

@property(nonatomic,copy) NSString *start_city;

@property(nonatomic,copy) NSString *Date;//判断是否为起始城市

@property(nonatomic,copy) NSString *Week;//判断是否为起始城市

@property(nonatomic,copy) NSString *BackString;

@end
