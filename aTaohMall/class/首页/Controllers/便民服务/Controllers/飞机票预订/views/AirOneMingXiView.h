//
//  AirOneMingXiView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/1.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirOneMingXiDelegate <NSObject>

-(void)AirOneMingXi;

@end
@interface AirOneMingXiView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,copy) NSString *Text;

@property(nonatomic,weak) id <AirOneMingXiDelegate> delegate;

-(void)Price:(NSString *)price JiJian:(NSString *)jijian BaoXian:(NSString *)baoxian DiKoi:(NSString *)dikou Number:(int)number kai1:(BOOL)kai1 kai2:(BOOL)kai2;
@end
