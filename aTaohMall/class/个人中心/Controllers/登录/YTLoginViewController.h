//
//  YTLoginViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/8.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
//协议实现反向传值
@protocol LoginMessageDelegate <NSObject>

-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6 andUserName:(NSString *)name;

@end
@interface YTLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *YTTF;


@property (weak, nonatomic) IBOutlet UITextField *YTUserNameTF;

@property (weak, nonatomic) IBOutlet UITextField *YTPassWordTF;

@property (weak, nonatomic) IBOutlet UITextField *YTMessageTF;

@property (weak, nonatomic) IBOutlet UIButton *YTLoginButton;

@property (weak, nonatomic) IBOutlet UIImageView *YTImageView;




@property (nonatomic, strong) NSArray *dataArray;//字符素材数组

@property (nonatomic, strong) NSMutableString *authcodeString;//验证码字符串

@property (nonatomic,copy) NSString *again;

@property(nonatomic,copy) NSString *backString;

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *userPassWord;

@property(nonatomic,copy) NSString *cancleString;//取消按钮隐藏
@property(nonatomic,weak)id <LoginMessageDelegate> delegate;//代理对象
@end
