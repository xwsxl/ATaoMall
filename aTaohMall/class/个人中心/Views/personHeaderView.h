//
//  personHeaderView.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/11.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIButton *loginButton;//登录按钮

@property (weak, nonatomic) IBOutlet UIButton *GoAllDingDanButton;//全部订单

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;//用户头像

@property (weak, nonatomic) IBOutlet UILabel *UserNameLabel;//用户名

@property (weak, nonatomic) IBOutlet UILabel *UserScoreLabel;//用户总积分

@property (weak, nonatomic) IBOutlet UIButton *SettingButton;//设置按钮

@property (weak, nonatomic) IBOutlet UIButton *DaiFuKuanButton;//待付款

@property (weak, nonatomic) IBOutlet UIButton *DaiFaHuoButton;//待发货
@property (weak, nonatomic) IBOutlet UIButton *UserMessageBut;

@property (weak, nonatomic) IBOutlet UIButton *DaiShouHuoButton;//待收货

@property (weak, nonatomic) IBOutlet UIButton *JiaoYiWanChengButton;//交易完成

@property (weak, nonatomic) IBOutlet UIButton *TuiHuoDanButton;//退货单

@property (weak, nonatomic) IBOutlet UILabel *DengLuLAbel;

@property (weak, nonatomic) IBOutlet UILabel *UserHeathyLab;

@end
