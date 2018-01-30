//
//  CartHeaderView.h
//  aTaohMall
//
//  Created by JMSHT on 2016/12/29.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreModel;

@protocol ShopCarTableViewHeaderViewDelegate <NSObject>
/** 全选或者删除按钮点击事件 */
- (void)selectOrEditGoods:(UIButton *)sender;

//编辑
- (void)EditGoods:(UIButton *)sender;

/** 进入商店 */
- (void)enterShopStore:(NSString *)mid;

@end


@interface CartHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *text;

@property(nonatomic, strong) UIButton *GoToStoreButton;//进入店铺

@property (nonatomic, strong) UIButton *edit;//编辑

@property (nonatomic, strong) UIImageView *gogo;

@property (nonatomic, strong) UIImageView *ImgView;//店铺图片

@property (nonatomic, strong) UIImageView *line1;//头部分割线

@property (nonatomic, strong) UIImageView *SelectImgView;//选中图片

@property (nonatomic, strong) UIButton *ImgButton;//头部勾选

@property (nonatomic, strong) StoreModel *carModel;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, weak)  id<ShopCarTableViewHeaderViewDelegate>delegate;




/** 设置选择按钮的tag */
@property (nonatomic, assign) NSInteger selectBtnTag;

/** 设置编辑按钮的tag */
@property (nonatomic, assign) NSInteger editBtnTag;

/** 设置全选按钮的状态 */
@property (nonatomic, assign) BOOL headerViewAllSelectBtnState;

/** 设置编辑按钮的状态 */
@property (nonatomic, assign) BOOL headerViewEditBtnState;
/** 设置编辑按钮的状态 */
@property (nonatomic, assign) BOOL hiddenEidtBtn;


@end
