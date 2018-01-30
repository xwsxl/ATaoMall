//
//  NewZhuCeViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NameAndPassWordDelegate <NSObject>

-(void)setUserName:(NSString *)name andPassWord:(NSString *)password;

@end

@interface NewZhuCeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;//用户名

@property (weak, nonatomic) IBOutlet UITextField *userPassWordTF;//登录密码

@property (weak, nonatomic) IBOutlet UITextField *againUserPassWordTF;//重新输入密码

@property (weak, nonatomic) IBOutlet UITextField *userPhoneTF;//用户手机号

@property (weak, nonatomic) IBOutlet UITextField *userMessageTF;//验证码

@property (weak, nonatomic) IBOutlet UITextField *userTGTF;//推广码
@property (weak, nonatomic) IBOutlet UIImageView *agreeImageView;//同意图片

@property (weak, nonatomic) IBOutlet UIButton *GetMessage;//获取验证码

@property (weak, nonatomic) IBOutlet UIButton *SureButton;//确定


@property (weak, nonatomic) IBOutlet UIButton *AggreeButton;//统一按钮

@property(nonatomic,copy) NSString *agreeString;

@property(nonatomic,copy) NSString *code;//验证码

@property(nonatomic,weak)id <NameAndPassWordDelegate> delegate;//代理对象
@end
