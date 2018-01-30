//
//  NineFooterView.h
//  aTaohMall
//
//  Created by JMSHT on 16/7/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FooterViewDelegate <NSObject>
@optional
- (void)FooterViewClickedloadMoreData;

@end

@interface NineFooterView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *loadMoreBtn;

@property (weak, nonatomic) IBOutlet UIView *moreView;

+ (instancetype)footerView;

@property (nonatomic, weak) id<FooterViewDelegate> delegate;

@end
