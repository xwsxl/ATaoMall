//
//  CountMessageViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/17.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChangHeaderImageDelegate <NSObject>

-(void)changeImageWithHeader:(NSString *)img;

@end

@interface CountMessageViewController : UIViewController

@property(nonatomic,copy)NSString *getString;//接收反向传值

@property(nonatomic,copy)NSString *sigens;//验签值

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) UILabel *showLabel; //显示出生日期的label
@property (nonatomic, strong) UIView *backgroundView; //日期选择的background
@property (nonatomic, strong) UIDatePicker *birthPicker;
@property (nonatomic, strong) NSString *findate;

@property(nonatomic,strong)UIButton *cancleButton;//取消按钮

@property(nonatomic,copy)UIButton *okButton;//确定按钮

@property(nonatomic,copy)NSString *BirthString;//修改生日

@property(nonatomic,copy)NSString *SexString;//修改性别

@property(nonatomic,copy)NSString *QQString;//QQ

@property(nonatomic,copy)NSString *EmailString;//邮箱

@property(nonatomic,copy)NSString *PhoneString;//手机号

@property(nonatomic,copy)NSString *userID;//id

@property(nonatomic,copy)NSString *headerImage;//反向传值 头像路径

@property(nonatomic,weak) id <ChangHeaderImageDelegate> delegate;

@end
