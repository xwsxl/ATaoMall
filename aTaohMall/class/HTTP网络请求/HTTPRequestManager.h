//
//  HTTPRequestManager.h
//  aTaohMall
//
//  Created by JMSHT on 2016/12/20.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResultBlock)(id responseObj,NSError *error);


//请求数据成功的Block
typedef void(^SuccessBlock)(id responseObj);

//请求失败的Block
typedef void(^FailureBlock)(NSError *error);

@interface HTTPRequestManager : NSObject


//单例
+(HTTPRequestManager *)sharedManager;


-(void)DataWithURL:(NSString *)interface Success:(SuccessBlock)success failure:(FailureBlock)failure;


+ (void)POST:(NSString *)interface NSDictWithString:(NSDictionary *)string parameters:(id)parameters result:(ResultBlock)result;





@end
