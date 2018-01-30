//
//  NewHomeHeaderView.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+ImageTitleSpacing.h"
#import "ImageScale.h"
@interface NewHomeHeaderView : UITableViewHeaderFooterView<UIScrollViewDelegate>

@property (copy, nonatomic)  UIButton *hkButton;//香港购物佳
@property (copy, nonatomic)  UIButton *ninenineButton;//九块九包邮
@property (copy, nonatomic)  UIButton *scoreStoreButton;//纯积分商城
@property (copy, nonatomic)  UIButton *yuyuanButton;//一元夺宝
//传入的头部数据的数组
@property(nonatomic, strong)NSArray *headerDatas;//图片

@property(nonatomic, strong)NSArray *dataArrM;//id

@property(nonatomic, strong)NSArray *dataArrM2;//attribute

@property(nonatomic,assign) NSInteger Count;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
@end
