//
//  CCNetWorkDefine.h
//  CCNetWorkManager
//
//  Created by jack on 16/8/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#ifndef CCNetWorkDefine_h
#define CCNetWorkDefine_h

#define CCRequest_TIME_OUT 20

@class CCNetWorkItem;
@protocol CCNetWorkDelegate <NSObject>

@optional

- (void)netWorkItemWillBeRemove:(CCNetWorkItem *)item;

@end

typedef enum {

   CCGetRequest = 1,
   CCPostRequest
    
}CCRequestType;


typedef void (^CCStartReuqestBlock)();

typedef void (^CCReuqestSuccessBlock)(NSDictionary *responseData);

typedef void (^CCReuqestFailureBlock)(NSError *requestError);

typedef void (^CCProgressBlock)(NSProgress *progress);

#endif