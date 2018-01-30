//
//  CollectionFooterView.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionFooterView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *AddMoreButton;//点击加载更多

@property (weak, nonatomic) IBOutlet UIView *loadMoreView;

@end
