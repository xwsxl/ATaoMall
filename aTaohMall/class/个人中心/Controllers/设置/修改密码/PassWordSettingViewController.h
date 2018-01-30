//
//  PassWordSettingViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassWordSettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *OldPassWordTF;//旧密码

@property (weak, nonatomic) IBOutlet UITextField *NewPassWordTF;//新密码

@property (weak, nonatomic) IBOutlet UITextField *AgainPassWordTF;//重新输入密码
@property (weak, nonatomic) IBOutlet UIButton *oldPasswordBut;

@property (weak, nonatomic) IBOutlet UIButton *NewPasswordBut;
@property (weak, nonatomic) IBOutlet UIButton *SurePassWordBut;

@property (nonatomic,strong) NSString *sigens;
@property (nonatomic,strong) NSString *phoneNumbers;
@property (nonatomic,strong) NSString *passwords;


@property (nonatomic,strong) NSString *userName;
@property (weak, nonatomic) IBOutlet UIButton *sureBut;

@end
