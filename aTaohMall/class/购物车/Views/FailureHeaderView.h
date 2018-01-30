//
//  FailureHeaderView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FailureModel;

@protocol FailureHeaderViewDelegate <NSObject>
/** 全选或者删除按钮点击事件 */
- (void)FailureAllSelect:(UIButton *)sender;

@end


@interface FailureHeaderView : UITableViewHeaderFooterView


@property (nonatomic, weak)  id<FailureHeaderViewDelegate>delegate;


@property (nonatomic, strong) FailureModel *failure;


@property(nonatomic,strong) UILabel *titleLabel;//失效商品

@property(nonatomic,strong) UIButton *deleteButton;//清空失效商品

/** 设置选择按钮的tag */
@property (nonatomic, assign) NSInteger selectBtnTag;

@end
