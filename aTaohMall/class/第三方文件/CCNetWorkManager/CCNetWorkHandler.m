//
//  CCNetWorkHandler.m
//  CCNetWorkManager
//
//  Created by jack on 16/8/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "CCNetWorkHandler.h"
#import "AFNetworking.h"

@implementation CCNetWorkHandler
+ (CCNetWorkHandler *)shardInstance
{
    static CCNetWorkHandler *handler;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        handler = [[CCNetWorkHandler alloc]init];
    });
    return handler;
}

//创建网络请求
- (CCNetWorkItem *)requestUrl:(NSString *)url
                  requestType:(CCRequestType)type
                       params:(NSDictionary *)params
                      success:(CCReuqestSuccessBlock)success
                      failure:(CCReuqestFailureBlock)failure
{
    if (self.NetWorkError) {
        if (failure) {
            failure(nil);
        }
        return nil;
    }
    self.item = [[CCNetWorkItem alloc]initWithRequetType:type url:url params:params success:success failure:failure];
    [self.items addObject:self.item];
    return self.item;
 }

//监听网络状态
- (void)startMonitorNetWorkstatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                [CCNetWorkHandler shardInstance].NetWorkError = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                [CCNetWorkHandler shardInstance].NetWorkError = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [CCNetWorkHandler shardInstance].NetWorkError = NO;
                NSLog(@"WIFI");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [CCNetWorkHandler shardInstance].NetWorkError = NO;
                NSLog(@"WAN网络");
                break;
        }
    }];
    [manager startMonitoring];
}

//取消所有任务
+ (void)cancelAllRequestItem
{
    CCNetWorkHandler *handler = [CCNetWorkHandler shardInstance];
    [handler.items removeAllObjects];
    handler.item = nil;
}

//移除单个任务
- (void)netWorkItemWillBeRemove:(CCNetWorkItem *)item
{
    [self.items removeObject:item];
    self.item = nil;
}

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end
