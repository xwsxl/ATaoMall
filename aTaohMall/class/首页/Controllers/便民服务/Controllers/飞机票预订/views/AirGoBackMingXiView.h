//
//  AirGoBackMingXiView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/5.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirGoBackMingXiDelegate <NSObject>

-(void)AirGoBackMingXi;

@end
@interface AirGoBackMingXiView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,copy) NSString *Text;

@property(nonatomic,weak) id <AirGoBackMingXiDelegate> delegate;

-(void)Price:(NSString *)price JiJian:(NSString *)jijian BaoXian:(NSString *)baoxian DiKoi:(NSString *)dikou Number:(int)number kai1:(BOOL)kai1 kai2:(BOOL)kai2 Price1:(NSString *)price1 JiJian1:(NSString *)jijian1 BaoXian1:(NSString *)baoxian1 DiKoi1:(NSString *)dikou1;
@end
