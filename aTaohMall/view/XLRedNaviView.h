//
//  XLRedNaviView.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XLRedNaviViewDelegate <NSObject>

@required
-(void)QurtBtnClick;
@end
@interface XLRedNaviView : UIView
@property (nonatomic,weak)id<XLRedNaviViewDelegate> delegate;
-(instancetype)initWithMessage:(NSString *)msg ImageName:(NSString *)imgName;
-(instancetype)initWithFrame:(CGRect )frame AndMessage:(NSString *)msg ImageName:(NSString *)imgName;
@end
