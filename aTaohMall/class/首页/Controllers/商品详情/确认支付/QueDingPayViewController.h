
//
//  QueDingPayViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueDingPayViewController : UIViewController

@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *moneyCom;

@property (nonatomic, copy) NSString *clientID;
@property (nonatomic, copy) NSString *appID;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *orderName;
@property (nonatomic, copy) NSString *orderDescription;
@property (nonatomic, copy) NSString *returnurl;
@property (nonatomic, copy) NSString *creditBankJson;
@property (nonatomic, copy) NSString *debitBankJson;

@property (nonatomic, copy) NSString *sigens;

@property (nonatomic, copy) NSString *successurl;

@end
