//
//  XLCellectionEditVC.h
//  aTaohMall
//
//  Created by Hawky on 2018/3/12.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XLCellectionEditVCDelegate<NSObject>
/*****  刷新商品收藏 *****/
-(void)refreshTableWithGoodsDataSource:(NSArray *)arr;

/*****  刷新店铺收藏 *****/
-(void)refreshTableWithShopsDataSource:(NSArray *)arr;

@end


@interface XLCellectionEditVC : UIViewController

@property (nonatomic,strong)NSArray *goodsDataSource;

@property (nonatomic,strong)NSArray *shopsDataSource;

@property (nonatomic,weak)id<XLCellectionEditVCDelegate> delegate;

@end
