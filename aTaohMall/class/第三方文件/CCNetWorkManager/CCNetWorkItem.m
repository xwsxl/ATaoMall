//
//  CCNetWorkItem.m
//  CCNetWorkManager
//
//  Created by jack on 16/8/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "CCNetWorkItem.h"
#import "AFNetworking.h"

@implementation CCNetWorkItem

- (CCNetWorkItem *)initWithRequetType:(CCRequestType)requestType
                                  url:(NSString *)url
                               params:(NSDictionary *)params
                              success:(CCReuqestSuccessBlock)success
                              failure:(CCReuqestFailureBlock)failure
{
    if (self = [super init])
    {
        self.requsetType = requestType;
        self.url = url;
        self.params = params;
        self.success = success;
        self.failure = failure;
    }
//    NSLog(@"本次请求地址--%@",url);
//    NSLog(@"本次请求参数--%@",params);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"image/jpeg",@"text/html",@"image/png", nil];
    switch (requestType) {
        case CCGetRequest:
            [self GETSessionWithManager:manager];
            break;
       case CCPostRequest:
            [self POSTSessionWithManager:manager];
            break;
    }
    return self;
}

- (void)GETSessionWithManager:(AFHTTPSessionManager *)manager
{
    __weak typeof (self)weakSelf = self;
    [manager GET:self.url parameters:self.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (weakSelf.success) {
            weakSelf.success (responseObject);
        }
        [self removeItem];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (weakSelf.failure) {
            weakSelf.failure(error);
        }
        [weakSelf removeItem];
    }];
}

- (void)POSTSessionWithManager:(AFHTTPSessionManager *)manager
{
    __weak typeof (self)weakSelf = self;
    [manager POST:self.url parameters:self.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (weakSelf.success) {
            weakSelf.success (responseObject);
        }
        [weakSelf removeItem];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (weakSelf.failure) {
            weakSelf.failure(error);
        }
        [weakSelf removeItem];
    }];
}

- (void)removeItem
{
    __weak typeof (self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkItemWillBeRemove:)]) {
            [weakSelf.delegate netWorkItemWillBeRemove:weakSelf];
        }
    });
}
@end
