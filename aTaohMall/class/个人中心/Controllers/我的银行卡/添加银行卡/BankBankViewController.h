//
//  BankBankViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/7.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BankNameDelegate <NSObject>

-(void)setBankNameWithString:(NSString *)name andBankNumberWithString:(NSString *)number;

@end
@interface BankBankViewController : UIViewController

@property(nonatomic,strong)id <BankNameDelegate> delegate;
@end
