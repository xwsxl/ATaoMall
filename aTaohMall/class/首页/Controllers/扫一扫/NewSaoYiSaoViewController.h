//
//  NewSaoYiSaoViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/10.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewHomeViewController.h"
#import "MallBaseNavigationController.h"
#import "MallBaseTabBarController.h"
#import "MallBaseViewController.h"

@interface NewSaoYiSaoViewController : UIViewController

@property(nonatomic,copy)NSString *userid;

@property(nonatomic,copy)NSString *sigen;

@property(nonatomic,strong) UIView *saosaoView;

@property(nonatomic,strong) UIImageView *barImgView;

@property(nonatomic,strong) UIImageView *QRImgView;

@property(nonatomic,strong) UILabel *TwoNumbrerLabel;

@end
