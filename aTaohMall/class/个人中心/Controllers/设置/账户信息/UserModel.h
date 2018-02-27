//
//  UserModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/4.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic,copy)NSString *address;//收货地址

@property(nonatomic,copy)NSString *id;//id

@property(nonatomic,copy)NSString *name;//收货人

@property(nonatomic,copy)NSString *phone;//电话

@property(nonatomic,copy)NSString *uid;

@property(nonatomic,copy)NSString *defaultstate;//默认地址

@property(nonatomic,copy)NSString *detailaddress;//详细地址
@end
