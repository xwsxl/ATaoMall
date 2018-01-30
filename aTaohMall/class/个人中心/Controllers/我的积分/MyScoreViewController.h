//
//  MyScoreViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *XiaoFeiButton;//消费明细

@property (weak, nonatomic) IBOutlet UIButton *HuoDeButton;//获得明细

@property (weak, nonatomic) IBOutlet UIImageView *xiaofeiImageView;//消费下划线

@property (weak, nonatomic) IBOutlet UIImageView *huodeImageView;//获得下划线

@property(nonatomic,copy)NSString *sigen;//个人信息验签值

@property(nonatomic,copy)NSString *flag;

@property (weak, nonatomic) IBOutlet UILabel *MyScoreLabel;//总积分
@property(nonatomic,copy)NSString *status;//判断数据是否加载完
@end
