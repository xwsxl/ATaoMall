//
//  NowGoingViewController.h
//  aTaohMall
//
//  Created by 阳涛 on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NowGoingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *AnRenQiButton;

@property (weak, nonatomic) IBOutlet UIButton *AnJiaGeButton;

@property (weak, nonatomic) IBOutlet UIButton *RenQiUpButton;

@property (weak, nonatomic) IBOutlet UIButton *RenQiDownButton;

@property (weak, nonatomic) IBOutlet UIButton *JiaGeUpButton;

@property (weak, nonatomic) IBOutlet UIButton *JiaGeDownButton;

@property (weak, nonatomic) IBOutlet UILabel *AnRenQiLabel;

@property (weak, nonatomic) IBOutlet UILabel *AnJiaGeLabel;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *PanDuan;//判断是否回到顶部

@end
