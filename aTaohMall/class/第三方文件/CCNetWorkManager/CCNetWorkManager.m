//
//  CCNetWorkManager.m
//  CCNetWorkManager
//
//  Created by jack on 16/8/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "CCNetWorkManager.h"

@implementation CCNetWorkManager

+ (instancetype)sharedInstance
{
    static CCNetWorkManager *manager;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        manager = [[CCNetWorkManager alloc]init];
    });
    return manager;
}

//Get
+ (void)GETRequestWithUrl:(NSString *)url
                   params:(NSDictionary *)params
                  success:(CCReuqestSuccessBlock)successBlock
                  failure:(CCReuqestFailureBlock)failureBlock
{
    [[CCNetWorkHandler shardInstance]requestUrl:url requestType:CCGetRequest params:params success:successBlock failure:failureBlock];
}

//Post
+ (void)POSTRequestWithUrl:(NSString *)url
                    params:(NSDictionary *)params
                   success:(CCReuqestSuccessBlock)successBlock
                   failure:(CCReuqestFailureBlock)failureBlock
{
    [[CCNetWorkHandler shardInstance]requestUrl:url requestType:CCPostRequest params:params success:successBlock failure:failureBlock];
}

//Upload
+ (void)UpLoadFileWithUrl:(NSString *)url
                   params:(NSDictionary *)params
              upLoadModel:(CCUploadModel *)upLoadModel
            progressBlock:(CCProgressBlock)progressBlock
             successBlock:(CCReuqestSuccessBlock)successBlock
             failureBlock:(CCReuqestFailureBlock)failureBlock

{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:upLoadModel.data name:upLoadModel.name fileName:upLoadModel.fileName mimeType:upLoadModel.mimeType];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
@end
