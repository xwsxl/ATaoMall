//
//  ChangeMesssage2ViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/3.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ChangePhoneDelegate <NSObject>

-(void)setPhoneWithString:(NSString *)string;

-(void)setDataReload;

@end


@interface ChangeMesssage2ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *ChangePhoneTF;//修改手机

@property(nonatomic,copy)NSString *sigens;


@property(nonatomic,copy)NSString *backString;

@property(nonatomic,copy)NSString *ChangeString;//上级页面传的信息

@property(nonatomic,weak) id <ChangePhoneDelegate> delegate;

@end
