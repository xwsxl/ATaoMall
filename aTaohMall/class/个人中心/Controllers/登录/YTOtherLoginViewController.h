//
//  YTOtherLoginViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/8.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"//网络请求

//加密
#import "DESUtil.h"
#import "ConverUtil.h"
#import "SecretCodeTool.h"

#import "MallModel.h"//数据模型

#import "UIImageView+WebCache.h"//异步加载图片


#import "NewLoginViewController.h"//新注册

#import "MBProgressHUD.h"



#import "AppDelegate.h"

//协议实现反向传值
@protocol LoginMessageDelegate <NSObject>

-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6 andUserName:(NSString *)name;

@end


@interface YTOtherLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *CancleButton;

@property (weak, nonatomic) IBOutlet UITextField *UserNameTF;

@property (weak, nonatomic) IBOutlet UITextField *PassWordTF;

@property (weak, nonatomic) IBOutlet UIButton *YTButton;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@property (weak, nonatomic) IBOutlet UIImageView *YTImageView;

@property (nonatomic,copy) NSString *again;

@property(nonatomic,copy) NSString *backString;

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *userPassWord;

@property(nonatomic,copy) NSString *cancleString;//取消按钮隐藏
@property(nonatomic,weak)id <LoginMessageDelegate> delegate;//代理对象


//方法


@end
