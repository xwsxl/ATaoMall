//
//  YTAddressViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/11.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTDelwgate <NSObject>

-(void)YTData;

-(void)reshData;


-(void)setUserName:(NSString *)name andPhone:(NSString *)phone andDetailAddress:(NSString *)address andType:(NSString *)type andID:(NSString *)addressID andAddressReload:(NSString *)reload;

@end
@interface YTAddressViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *YTUserNameTF;


@property (weak, nonatomic) IBOutlet UITextField *YTUSerPhoneTF;


@property (weak, nonatomic) IBOutlet UILabel *YTAddressLabel;


@property (weak, nonatomic) IBOutlet UITextField *YTDeatilTF;


@property (weak, nonatomic) IBOutlet UISwitch *YTSwitch;


@property(nonatomic,copy)NSString *sigens;

@property(nonatomic,copy)NSString *province;//省

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString *defaultstate;

@property(nonatomic,copy)NSString *YTString;//判断是否为第一次

@property(nonatomic,weak)id <YTDelwgate> delegate;//代理对象
@end
