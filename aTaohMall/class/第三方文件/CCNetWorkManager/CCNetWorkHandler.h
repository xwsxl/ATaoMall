//
//  CCNetWorkHandler.h
//  CCNetWorkManager
//
//  Created by jack on 16/8/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCNetWorkItem.h"
#import "CCNetWorkDefine.h"

@interface CCNetWorkHandler : NSObject<CCNetWorkDelegate>

+ (CCNetWorkHandler *)shardInstance;

@property (nonatomic,strong)NSMutableArray *items;

@property (nonatomic,strong)CCNetWorkItem *item;

@property (nonatomic,assign)BOOL NetWorkError;


- (void)startMonitorNetWorkstatus;

+ (void)cancelAllRequestItem;

- (CCNetWorkItem *)requestUrl:(NSString *)url
                  requestType:(CCRequestType)type
                       params:(NSDictionary *)params
                      success:(CCReuqestSuccessBlock)success
                      failure:(CCReuqestFailureBlock)failure;
@end
