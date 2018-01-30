//
//  DingDanAddressModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/15.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DingDanAddressModel : NSObject

@property(nonatomic,copy)NSString *address;//地址

@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *name;//收货人姓名

@property(nonatomic,copy)NSString *phone;//电话

@property(nonatomic,copy)NSString *defaultstate;
@end
