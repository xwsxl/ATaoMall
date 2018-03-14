//
//  XLPersonalDingDanVC.h
//  aTaohMall
//
//  Created by Hawky on 2018/2/27.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XLPersonalDingDanVCDelegate<NSObject>

-(void)refrshDataBecuseDeleteDingDan;

@end


@interface XLPersonalDingDanVC : UIViewController

@property (nonatomic,strong)NSString *ISKindOfShop;
@property (nonatomic,strong)NSString *searchStr;
@property (nonatomic,weak)id<XLPersonalDingDanVCDelegate> delegate;
@end
