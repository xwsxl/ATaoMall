//
//  CCNetWorkManager.h
//  CCNetWorkManager
//
//  Created by jack on 16/8/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCNetWorkDefine.h"
#import "AFNetworking.h"
#import "CCUploadModel.h"
#import "CCNetWorkHandler.h"

@interface CCNetWorkManager : NSObject

+ (instancetype)sharedInstance;

+ (void)GETRequestWithUrl:(NSString *)url
                   params:(NSDictionary *)params
                  success:(CCReuqestSuccessBlock)successBlock
                  failure:(CCReuqestFailureBlock)failureBlock;

+ (void)POSTRequestWithUrl:(NSString *)url
                   params:(NSDictionary *)params
                  success:(CCReuqestSuccessBlock)successBlock
                   failure:(CCReuqestFailureBlock)failureBlock;

+ (void)UpLoadFileWithUrl:(NSString *)url
                   params:(NSDictionary *)params
              upLoadModel:(CCUploadModel *)upLoadModel
            progressBlock:(CCProgressBlock)progressBlock
             successBlock:(CCReuqestSuccessBlock)successBlock
             failureBlock:(CCReuqestFailureBlock)failureBlock;
@end
