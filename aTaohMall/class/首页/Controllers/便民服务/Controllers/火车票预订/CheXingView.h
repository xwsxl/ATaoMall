//
//  CheXingView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheXingDelegate <NSObject>

-(void)CheXingString:(NSString *)string;

@end

@interface CheXingView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

@property(nonatomic,copy) NSString *TypeString;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,weak) id <CheXingDelegate> delegate;

@end
