//
//  PayCardModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/7.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayCardModel : NSObject

@property(nonatomic,copy)NSString *bankcardno;

@property(nonatomic,copy)NSString *bankname;

@property(nonatomic,copy)NSString *bankno;

@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *realname;//真实姓名

@property(nonatomic,copy)NSString *identity;//身份证号

@property(nonatomic,copy)NSString *regdate;

@property(nonatomic,copy)NSString *total_money;

@property(nonatomic,copy)NSString *username;

@end
