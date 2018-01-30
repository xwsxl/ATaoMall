//
//  MyPayCardViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPayCardFooter.h"
@interface MyPayCardViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;


@property(nonatomic,copy) NSString *bankcardno;//银行卡号

@property(nonatomic,copy) NSString *bankId;//

@property(nonatomic,strong)MyPayCardFooter *footer;

@end
