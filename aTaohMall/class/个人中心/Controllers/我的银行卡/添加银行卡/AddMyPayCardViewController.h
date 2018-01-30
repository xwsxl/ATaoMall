//
//  AddMyPayCardViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/17.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYKeyboardUtil.h"//键盘自动弹出

@protocol AddBankCardDelegae <NSObject>

-(void)addCard;

@end
@interface AddMyPayCardViewController : UIViewController


@property (nonatomic,copy) NSString *realname;  // 姓名
@property (nonatomic,copy) NSString *identity; // 身份证号

@property (nonatomic,copy) NSString *message;

@property (nonatomic,copy) NSString *bankcardno;//卡号

@property(nonatomic,copy)NSString *sigen;

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;//键盘自动弹出

@property(nonatomic,weak) id <AddBankCardDelegae> delegate;

@end
