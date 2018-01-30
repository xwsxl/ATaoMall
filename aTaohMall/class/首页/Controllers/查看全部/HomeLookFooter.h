//
//  HomeLookFooter.h
//  aTaohMall
//
//  Created by JMSHT on 16/7/11.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FooterViewDelegate <NSObject>
@optional
- (void)FooterViewClickedloadMoreData;

@end

@interface HomeLookFooter : UITableViewHeaderFooterView

@property(nonatomic,copy)NSString *totalCount;

@property(nonatomic,copy)NSString *DataCount;

@property (weak, nonatomic) IBOutlet UIButton *loadMoreBtn;

@property (weak, nonatomic) IBOutlet UIView *moreView;

+ (instancetype)footerView;

@property (nonatomic, weak) id<FooterViewDelegate> delegate;

@end
