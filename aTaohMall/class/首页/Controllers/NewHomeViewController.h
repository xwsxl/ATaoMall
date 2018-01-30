//
//  NewHomeViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewHomeViewController : UIViewController
{
    NSMutableArray *_headerArrM;//存储头部数据
    NSMutableArray *_attibuteArm;//存储头部数据
}

@property(nonatomic,copy)NSString * sigens;//登录

@property(nonatomic,copy)NSString *userid;//用户id

@property(nonatomic,copy)NSString *sigen;//判断是否登录

@property(nonatomic,copy)NSString *status;//登录状态

@property(nonatomic,copy)NSString *integral;//积分

@property(nonatomic,copy)NSString *phone;//我的手机

@property(nonatomic,copy)NSString *UserName;//用户名

@property(nonatomic,copy)NSString *portrait;//用户头像

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@end
