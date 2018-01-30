//
//  AirRefundUploadImgVC.h
//  aTaohMall
//
//  Created by DingDing on 2017/8/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirRefundUploadImgDelegate <NSObject>

-(void)uploadImgSuccessWithUploadString:(NSString *)uploadStr;

@end
@interface AirRefundUploadImgVC : UIViewController
@property(nonatomic,copy)NSString *orderno;//订单号
@property(nonatomic,weak)id<AirRefundUploadImgDelegate> delegate;
@end
