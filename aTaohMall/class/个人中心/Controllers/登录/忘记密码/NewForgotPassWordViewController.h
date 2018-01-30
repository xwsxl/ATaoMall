//
//  NewForgotPassWordViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewLoginViewController.h"//注册


@interface NewForgotPassWordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *UserNameTextField;//用户名

@property (weak, nonatomic) IBOutlet UITextField *PhoneNumberTF;//手机号码

@property (weak, nonatomic) IBOutlet UITextField *YanZhenTF;//短信验证码
@property (weak, nonatomic) IBOutlet UIButton *YanZhenButton;//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *clearBut;
@property (weak, nonatomic) IBOutlet UIButton *sureBut;

@end
