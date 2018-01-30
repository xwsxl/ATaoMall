//
//  NowBuyingViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/6.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NowBuyingViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *AnRenQiButton;

@property (weak, nonatomic) IBOutlet UIButton *AnJiaGeButton;

@property (weak, nonatomic) IBOutlet UIButton *RenQiUpButton;

@property (weak, nonatomic) IBOutlet UIButton *RenQiDownButton;

@property (weak, nonatomic) IBOutlet UIButton *JiaGeUpButton;

@property (weak, nonatomic) IBOutlet UIButton *JisGeDownButton;

@property (weak, nonatomic) IBOutlet UILabel *AnRenQiLabel;

@property (weak, nonatomic) IBOutlet UILabel *AnJiaGeLabel;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *type;


@property(nonatomic,copy)NSString *PanDuan;//判断是否回到顶部

@end
