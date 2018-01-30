//
//  AirPlaneEditManViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirPlaneEditManViewDelegate <NSObject>

-(void)AirPlaneEditManReload;

@end
@interface AirPlaneEditManViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,copy) NSString *ManId;

@property(nonatomic,copy) NSString *ManUid;

@property(nonatomic,copy) NSString *passenger_name;

@property(nonatomic,copy) NSString *certificate_type;

@property(nonatomic,copy) NSString *certificate_number;

@property(nonatomic,copy) NSString *passenger_phone;

@property(nonatomic,weak) id <AirPlaneEditManViewDelegate> delegate;
@end
