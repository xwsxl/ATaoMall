//
//  TrainSelectStationViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainSelectStationDelegate <NSObject>

-(void)TrainSelectStation:(NSString *)name Type:(NSString *)type Code:(NSString *)code;

@end
@interface TrainSelectStationViewController : UIViewController

@property(nonatomic,copy) NSString *Type;//判断是否为起始城市

@property(nonatomic,weak) id <TrainSelectStationDelegate> delegate;

@end
