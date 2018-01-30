//
//  AirPlaneSelectCityViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirPlaneSelectStationDelegate <NSObject>

-(void)AirPlaneSelectStation:(NSString *)name City_Code:(NSString *)code Type:(NSString *)type;

@end

@interface AirPlaneSelectCityViewController : UIViewController

@property(nonatomic,copy) NSString *Type;//判断是否为起始城市

@property(nonatomic,weak) id <AirPlaneSelectStationDelegate> delegate;

@end
