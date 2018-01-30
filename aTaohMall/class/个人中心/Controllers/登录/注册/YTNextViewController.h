//
//  YTNextViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/8.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NameAndPassWordDelegate <NSObject>

-(void)setUserName:(NSString *)name andPassWord:(NSString *)password;

@end
@interface YTNextViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *YTUserNameTF;

@property (weak, nonatomic) IBOutlet UITextField *YTUserMessageTF;

@property (weak, nonatomic) IBOutlet UIButton *MessageButton;

@property (weak, nonatomic) IBOutlet UIView *YTView;

@property(nonatomic,copy) NSString *mid;

@property(nonatomic,copy) NSString *uid;

@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *userPassWord;

@property (weak, nonatomic) IBOutlet UITextView *YTTextView;
@property(nonatomic,copy) NSString *code;//验证码


@property (weak, nonatomic) IBOutlet UILabel *XieYiLabel;

@property(nonatomic,weak)id <NameAndPassWordDelegate> delegate;//代理对象
@end
