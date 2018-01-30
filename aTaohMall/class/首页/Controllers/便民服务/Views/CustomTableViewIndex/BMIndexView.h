//
//  BMIndexView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BMIndexViewDelegate <NSObject>

- (NSArray *)getTableViewIndexList;
- (void)selectedIndex:(NSInteger)index sectionTitle:(NSString *)title;
- (void)tableViewIndexTouchEnd;

@end

@interface BMIndexView : UIView

@property (nonatomic, weak) id<BMIndexViewDelegate> cusIndexViewDelegate;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) UIFont  *textFont;
@property(nonatomic,strong) NSArray *GameArrM;

@end
