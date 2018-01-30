//
//  AgainPassWordViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/19.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "NewLoginViewController.h"//登录界面

@interface AgainPassWordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *PassWordTF;//账户密码

@property (weak, nonatomic) IBOutlet UITextField *AgainPassWord;//确认密码
@property (weak, nonatomic) IBOutlet UIButton *PassWordBut;
@property (weak, nonatomic) IBOutlet UIButton *AgainPassWordBut;
@property (weak, nonatomic) IBOutlet UIButton *sureBut;

@property (nonatomic,strong) NSString *sigens;

@property (nonatomic,strong) NSString *userName;
@end
