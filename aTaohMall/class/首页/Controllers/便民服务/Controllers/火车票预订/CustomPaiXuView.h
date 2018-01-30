//
//  CustomPaiXuView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaiXuDelegate <NSObject>

-(void)PaiXuString:(NSString *)string;

@end
@interface CustomPaiXuView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,weak) id <PaiXuDelegate> delegate;

@end
