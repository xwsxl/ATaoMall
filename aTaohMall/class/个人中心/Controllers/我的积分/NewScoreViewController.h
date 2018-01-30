//
//  NewScoreViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/12/5.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewScoreViewController : UIViewController

@property(nonatomic,copy)NSString *sigen;//个人信息验签值

@property(nonatomic,copy)NSString *YTString;

@property(nonatomic,copy)NSString *flag;

@property(nonatomic,copy)NSString *type;


@property(nonatomic,copy)NSString *Score;


@property(nonatomic,copy)NSString *status;//判断数据是否加载完

@property(nonatomic,copy)NSString *PanDuan;//判断是否回到顶部


@end
