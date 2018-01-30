//
//  XLTopSelectScroll.h
//  aTaohMall
//
//  Created by Hawky on 2017/12/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLTopSelectScrollDelegate<NSObject>

@required
-(void)DidSelectTopIndex:(NSInteger )index;

@end

@interface XLTopSelectScroll : UIScrollView

@property (nonatomic,weak) id<XLTopSelectScrollDelegate> XLdelegate;

-(instancetype)initWithWith:(CGRect )XLrect AndDataArr:(NSArray *)dataArr AndFont:(UIFont *)font;
-(void)selectedIndexType:(NSInteger )index;


@end
