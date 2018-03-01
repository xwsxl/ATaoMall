//
//  PersonaViewController.h
//  ATAoHuiMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 yt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MallModel.h"//数据模型

#import "AppDelegate.h"

@interface PersonaViewController : UIViewController

@property (nonatomic,copy) NSString *again;

@property(nonatomic,copy)NSString *sigen;//判断是否登录

@property(nonatomic,copy)NSString *status;//登录状态

@property(nonatomic,copy)NSString *integral;//积分

@property(nonatomic,copy)NSString *phone;//我的手机

@property(nonatomic,copy)NSString *UserName;//用户名

@property(nonatomic,copy)NSString *portrait;//用户头像

@property(nonatomic,copy)NSString *userID;

@property(nonatomic,copy)NSString *CartString;

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property(nonatomic,assign)NSInteger tag; //订单按钮的tag值

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property (nonatomic,strong)NSString *healthyInteger;

@end
