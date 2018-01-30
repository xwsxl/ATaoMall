//
//  CartAddressModel.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartAddressModel : NSObject

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *phone;

@property(nonatomic,copy) NSString *province;

@property(nonatomic,copy) NSString *county;

@property(nonatomic,copy) NSString *city;

@property(nonatomic,copy) NSString *address;

@property(nonatomic,copy) NSString *defaultstate;

@property(nonatomic,copy) NSString *addressId;

@end
