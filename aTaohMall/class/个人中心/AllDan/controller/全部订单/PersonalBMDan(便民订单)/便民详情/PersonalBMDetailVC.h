//
//  PersonalBMDetailVC.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/29.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalBMDetailVCDelegate<NSObject>

-(void)BMDetailSelectIndexType:(NSInteger )index;

@end


@interface PersonalBMDetailVC : UIViewController
@property(nonatomic,weak)id<PersonalBMDetailVCDelegate> delegate;
-(instancetype)initWithOrderBatchid:(NSString *)orderBatchid AndOrderType:(NSString *)orderType;

@end
