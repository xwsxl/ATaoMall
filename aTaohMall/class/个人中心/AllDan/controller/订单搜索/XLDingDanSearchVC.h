//
//  XLDingDanSearchVC.h
//  aTaohMall
//
//  Created by Hawky on 2018/3/14.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XLDingDanSearchVCDelegate<NSObject>

-(void)searchText:(NSString *)str;

@end

@interface XLDingDanSearchVC : UIViewController
@property (nonatomic,weak)id<XLDingDanSearchVCDelegate> delegate;
@end
