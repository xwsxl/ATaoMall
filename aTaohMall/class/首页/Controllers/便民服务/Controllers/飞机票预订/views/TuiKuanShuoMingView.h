//
//  TuiKuanShuoMingView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/19.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuiKuanShuoMingView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view Text:(NSString *)text;
- (void)hideInView;

@property(nonatomic,copy) NSString *Text;
@end
