//
//  CCNetWorkItem.h
//  CCNetWorkManager
//
//  Created by jack on 16/8/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCNetWorkDefine.h"

@interface CCNetWorkItem : NSObject

@property (nonatomic,weak)id<CCNetWorkDelegate> delegate;

@property (nonatomic,assign)CCRequestType requsetType;

@property (nonatomic,strong)NSString *url;

@property (nonatomic,strong)NSDictionary *params;

@property (nonatomic,copy)CCReuqestSuccessBlock success;

@property (nonatomic,copy)CCReuqestFailureBlock failure;

- (CCNetWorkItem *)initWithRequetType:(CCRequestType)requestType
                                  url:(NSString *)url
                               params:(NSDictionary *)params
                              success:(CCReuqestSuccessBlock)success
                              failure:(CCReuqestFailureBlock)failure;
@end
