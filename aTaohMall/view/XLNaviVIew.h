//
//  XLNaviVIew.h
//  aTaohMall
//
//  Created by Hawky on 2017/12/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLNaviViewDelegate <NSObject>

@required
-(void)QurtBtnClick;
@end

@interface XLNaviView : UIView


@property (nonatomic,weak)id<XLNaviViewDelegate> delegate;
-(instancetype)initWithMessage:(NSString *)msg ImageName:(NSString *)imgName;
-(instancetype)initWithFrame:(CGRect )frame AndMessage:(NSString *)msg ImageName:(NSString *)imgName;

@end
