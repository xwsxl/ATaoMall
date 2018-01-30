//
//  RecetHomeHeaderView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/20.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIButton+ImageTitleSpacing.h"
#import "ImageScale.h"

@interface RecetHomeHeaderView : UITableViewHeaderFooterView<UIScrollViewDelegate>

@property(nonatomic, strong)UIButton *hkButton;//香港购物佳
@property(nonatomic, strong)UIButton *ninenineButton;//九块九包邮
@property(nonatomic, strong)UIButton *scoreStoreButton;//纯积分商城

@property(nonatomic, strong)UIButton *PhoneButton;//话费
@property(nonatomic, strong)UIButton *FlowButton;//流量
@property(nonatomic, strong)UIButton *GameButton;//游戏

@property(nonatomic, strong)UIButton *TrainButton;//火车票
@property(nonatomic, strong)UIButton *AeroplaneButton;//飞机票
@property(nonatomic, strong)UIButton *CarButton;//违章

@property(nonatomic, strong)UIButton *MiaoQiangButton;//好货秒抢
@property(nonatomic, strong)UIButton *HQGButton;//惠抢购
@property(nonatomic, strong)UIButton *QDButton;//优选清单
@property(nonatomic, strong)UIButton *HDButton;//发现好店
@property(nonatomic, strong)UIButton *ZXButton;//为你甄选
@property(nonatomic, strong)UIButton *DPButton;//大牌推荐
@property(nonatomic, strong)UIButton *JDButton;//家电馆
@property(nonatomic, strong)UIButton *MWButton;//美味惠吃
@property(nonatomic, strong)UIButton *HFButton;//护肤美妆
@property(nonatomic, strong)UIButton *FZButton;//服装箱包
@property(nonatomic, strong)UIButton *JJButton;//居家生活
@property(nonatomic, strong)UIButton *GJButton;//搞基拍
@property(nonatomic, strong)UIButton *BBButton;//亲宝贝
@property(nonatomic, strong)UIButton *HWButton;//户外
@property(nonatomic, strong)UIButton *KCButton;//快充
@property(nonatomic, strong)UIButton *GGButton;//高贵
@property(nonatomic, strong)UIButton *OneButton;//户外
@property(nonatomic, strong)UIButton *TwoButton;//户外
@property(nonatomic, strong)UIButton *ThreeButton;//户外
@property(nonatomic, strong)UIButton *FourButton;//户外


@property (copy, nonatomic)  UIButton *yuyuanButton;//一元夺宝
//传入的头部数据的数组
@property(nonatomic, strong)NSArray *headerDatas;//图片

@property(nonatomic, strong)NSArray *dataArrM;//id

@property(nonatomic, strong)NSArray *list1;//积分商品

@property(nonatomic, strong)NSArray *list2;//积分商品

@property(nonatomic, strong)NSArray *JXlist;//积分商品
@property(nonatomic, strong)NSArray *HDlist;//积分商品

@property(nonatomic, strong)NSArray *dataArrM2;//attribute

@property(nonatomic,assign) NSInteger Count;

//@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) UIScrollView *myScrollView;


@property (weak, nonatomic)  NSTimer *timer;


/// 初始时间
@property (nonatomic, assign) NSTimeInterval time;

// 获取table view cell 的indexPath
@property (nonatomic, weak) NSIndexPath *m_indexPath;

@property (nonatomic)       BOOL         m_isDisplayed;

/**
 *  == [子类可以重写] ==
 *
 *  配置cell的默认属性
 */
- (void)defaultConfig;

- (void)loadData:(id)data type:(NSString *)string;

@end
