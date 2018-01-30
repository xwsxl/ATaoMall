//
//  BusinessQurtModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/19.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "JSONModel.h"

@interface BusinessQurtModel : JSONModel

@property(nonatomic,copy)NSString *click_volume;//进店逛过

@property(nonatomic,copy)NSString *id;//商户id

@property(nonatomic,copy)NSString *logo;//商户图片

@property(nonatomic,copy)NSString *storename;//商户名称

@end
