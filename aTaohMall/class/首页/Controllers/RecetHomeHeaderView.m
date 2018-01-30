//
//  RecetHomeHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/20.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "RecetHomeHeaderView.h"

#import "HomeModel.h"
#import "YTScrolling.h"//图片轮番

#import "UIImageView+WebCache.m"

#import "NewGoodsDetailViewController.h"//商品详情

#import "YTGoodsDetailViewController.h"
#import "KTPageControl.h"
#import "HomeModel.h"
#import "AllSingleShoppingModel.h"
#import "HomeDPModel.h"
#import "HomeGeekGoodsListVC.h"
#import "HomeDaiPaiSuggestListVC.h"
#import "DPCommandDetailViewController.h"
#import "JXSelectViewController.h"
#import "JXSelectDetailViewController.h"
#import "HomeGoodGoodsHotSaleVC.h"
#import "MerchantDetailViewController.h"
//#define HHH ([UIScreen mainScreen].bounds.size.height)*27/11


@interface RecetHomeHeaderView()<UIScrollViewDelegate>

#define fHeight  [UIScreen mainScreen].bounds.size.height
#define fWidth    [UIScreen mainScreen].bounds.size.width
{

    //甄选
    UILabel *ZXName;
    UILabel *ZXTitle;
    UIImageView *ZXimgView;

    UILabel *DPName;
    UILabel *DPTitle;
    UIImageView *DPimgView;

    UILabel *JDName;
    UILabel *JDTitle;
    UIImageView *JDimgView;

    UILabel *MWName;
    UILabel *MWTitle;
    UIImageView *MWimgView;

    //特色必逛
    UILabel *HFName;
    UILabel *HFTitle;
    UIImageView *HFimgView;
    UIImageView *HFimgView1;

    UILabel *FZName;
    UILabel *FZTitle;
    UIImageView *FZimgView;

    UILabel *JJName;
    UILabel *JJTitle;
    UIImageView *JJimgView;

    UILabel *GJName;
    UILabel *GJTitle;
    UIImageView *GJimgView;

    UILabel *BBName;
    UILabel *BBTitle;
    UIImageView *BBimgView;

    UILabel *HWName;
    UILabel *HWTitle;
    UIImageView *HWimgView;

    //小家电轮播
    UIScrollView *MiaoScrollerView;

    UIView *MiaoQingView;
    UIView *view;

    NSMutableArray *DataArrM;



    UIImageView *HuiWaiImg;
    UILabel *HuiWaiLabel;


    //
    UIView *ChaoliuView;

    UIView *DaPaiView;
    UIImageView   *JiKeView;
    UIView *HaoHuoView;
    UIView *YouXuanView;

    UIView *HaoDianView;
    UIView *TopBangView;
    UIView *reMenSCView;

    NSInteger selectindex;

}
@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@property (nonatomic, strong) NSTimer        *m_timer; //定时器

@property (strong,nonatomic) KTPageControl *pageControl;
@end

NSInteger  HuiqiangGouHeight=-134;
CGFloat HHH;
@implementation RecetHomeHeaderView

#define fHeight  [UIScreen mainScreen].bounds.size.height
#define fWidth    [UIScreen mainScreen].bounds.size.width

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //在这里向contentView添加控件
        [self loadMyCell];
    }
    return self;
}

- (KTPageControl *)pageControl
{
    if (_pageControl == nil) {

        _pageControl = [[KTPageControl alloc] init];

        if ([UIScreen mainScreen].bounds.size.width > 320) {

            _pageControl.frame =CGRectMake(self.frame.size.width+100, HHH-20, 40, 7);

        }else{

            _pageControl.frame =CGRectMake(self.frame.size.width+50, HHH-20, 40, 7);

        }


        //有图片显示图片、没图片则显示设置颜色
        //        _pageControl.pageIndicatorTintColor =[UIColor yellowColor];
        //        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];

        _pageControl.currentImage =[UIImage imageNamed:@"椭圆-7"];
        _pageControl.defaultImage =[UIImage imageNamed:@"628"];

        //设置pageSize以设置为准、否则以图片大小为准、图片也没有默认7*7...
        _pageControl.pageSize = CGSizeMake(7, 7);


        //        _pageControl.numberOfPages = 5;
        _pageControl.currentPage = 0;

        [self.pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];

        //定时器
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];


    }
    return _pageControl;
}

-(void)loadMyCell
{
    CGFloat shiftHeight=0;
    /*
     bannar图
     */
    HHH=([UIScreen mainScreen].bounds.size.width)*310/750;

    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, shiftHeight, [UIScreen mainScreen].bounds.size.width, HHH)];
    shiftHeight+=self.myScrollView.frame.size.height;

    DataArrM = [NSMutableArray new];
    self.myScrollView.delegate=self;
    self.myScrollView.pagingEnabled=YES;
    self.myScrollView.bounces=NO;
    self.myScrollView.showsHorizontalScrollIndicator=YES;
    self.myScrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    [self addSubview:self.myScrollView];
    [self addSubview:self.pageControl];

    /*
     button 大健康专区、便民入口等等
     */

    self.headerButView=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreen_Width, (Height(13)+Height(5)+12+50)*2+Height(10)+Height(10))];
    shiftHeight+=self.headerButView.frame.size.height;
    [self addSubview:self.headerButView];
    //大健康
    UIView *HuiWaiVew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.hkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hkButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [HuiWaiVew addSubview:self.hkButton];

    [self.headerButView addSubview:HuiWaiVew];


    HuiWaiImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, Height(13), 50, 50)];
    [HuiWaiImg setImage:KImage(@"xlhome-icon-healthy")];
    [HuiWaiVew addSubview:HuiWaiImg];
    HuiWaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Height(13)+50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    HuiWaiLabel.text=@"大健康专区";
    HuiWaiLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    HuiWaiLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    HuiWaiLabel.textAlignment=NSTextAlignmentCenter;
    [HuiWaiVew addSubview:HuiWaiLabel];

    //九块九
    UIView *NineVew = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.ninenineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ninenineButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [NineVew addSubview:self.ninenineButton];

    [self.headerButView addSubview:NineVew];

    UIImageView *NineImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, Height(13), 50, 50)];
    NineImg.image = [UIImage imageNamed:@"xlhome-icon-free post"];
    [NineVew addSubview:NineImg];

    UILabel *NineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Height(13)+50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    NineLabel.text = @"九块九包邮";
    NineLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    NineLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NineLabel.textAlignment=NSTextAlignmentCenter;
    [NineVew addSubview:NineLabel];


    //海外购物佳
    UIView *JiFenVew = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*2, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.scoreStoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.scoreStoreButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [JiFenVew addSubview:self.scoreStoreButton];

    [self.headerButView addSubview:JiFenVew];

    UIImageView *JiFenImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, Height(13), 50, 50)];
    JiFenImg.image = [UIImage imageNamed:@"xlhome-icon-oversea"];
    [JiFenVew addSubview:JiFenImg];

    UILabel *JiFenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Height(13)+50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    JiFenLabel.text = @"海外购物佳";
    JiFenLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    JiFenLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JiFenLabel.textAlignment=NSTextAlignmentCenter;
    [JiFenVew addSubview:JiFenLabel];


    //小家电
    UIView *JiFenVew1 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*3, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.TrainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.TrainButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [JiFenVew1 addSubview:self.TrainButton];

    [self.headerButView addSubview:JiFenVew1];

    UIImageView *JiFenImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, Height(13), 50, 50)];
    JiFenImg1.image = [UIImage imageNamed:@"xlhome-icon-Appliances"];
    [JiFenVew1 addSubview:JiFenImg1];

    UILabel *JiFenLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, Height(13)+50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    JiFenLabel1.text = @"小家电";
    JiFenLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    JiFenLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JiFenLabel1.textAlignment=NSTextAlignmentCenter;
    [JiFenVew1 addSubview:JiFenLabel1];


    /*
     第二行
     */
    CGFloat eight=Height(13)+Height(5)+12+50+Height(10)+8;
    UIView *PhoneVew = [[UIView alloc] initWithFrame:CGRectMake(0, eight, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];

    self.PhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.PhoneButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [PhoneVew addSubview:self.PhoneButton];

    [self.headerButView addSubview:PhoneVew];

    UIImageView *PhoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 0, 50, 50)];
    PhoneImg.image = [UIImage imageNamed:@"xlhome-icon-traffic"];
    [PhoneVew addSubview:PhoneImg];

    UILabel *PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    PhoneLabel.text = @"交通出行";
    PhoneLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    PhoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PhoneLabel.textAlignment=NSTextAlignmentCenter;
    [PhoneVew addSubview:PhoneLabel];


    UIView *FlowVew = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4, eight, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.FlowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.FlowButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [FlowVew addSubview:self.FlowButton];

    [self.headerButView addSubview:FlowVew];

    UIImageView *FlowImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 0, 50, 50)];
    FlowImg.image = [UIImage imageNamed:@"xlhome-icon-Recharge"];
    [FlowVew addSubview:FlowImg];

    UILabel *FlowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    FlowLabel.text = @"充值中心";
    FlowLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    FlowLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    FlowLabel.textAlignment=NSTextAlignmentCenter;
    [FlowVew addSubview:FlowLabel];



    UIView *GameVew = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*2, eight, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.GameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.GameButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [GameVew addSubview:self.GameButton];

    [self.headerButView addSubview:GameVew];

    UIImageView *GameImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 0, 50, 50)];
    GameImg.image = [UIImage imageNamed:@"xlhome-icon-Violation"];
    [GameVew addSubview:GameImg];

    UILabel *GameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    GameLabel.text = @"违章缴费";
    GameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    GameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GameLabel.textAlignment=NSTextAlignmentCenter;
    [GameVew addSubview:GameLabel];

    UIView *GameVew1 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*3, eight, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.AeroplaneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.AeroplaneButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [GameVew1 addSubview:self.AeroplaneButton];

    [self.headerButView addSubview:GameVew1];

    UIImageView *GameImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 0, 50, 50)];
    GameImg1.image = [UIImage imageNamed:@"xlhome-icon-ranking"];
    [GameVew1 addSubview:GameImg1];

    UILabel *GameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    GameLabel1.text = @"热销排行";
    GameLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    GameLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GameLabel1.textAlignment=NSTextAlignmentCenter;
    [GameVew1 addSubview:GameLabel1];


    UIView *BgView = [[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, [UIScreen mainScreen].bounds.size.width, 10)];
    BgView.backgroundColor  =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self addSubview:BgView];

    UIImageView *BgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    BgLine.image = [UIImage imageNamed:@"fengexian"];
    [BgView addSubview:BgLine];
    shiftHeight+=10;


    if (MiaoQingView) {
        [MiaoQingView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        MiaoQingView=nil;
    }


    CGFloat height=124+HuiqiangGouHeight;
    if (height>0) {
        MiaoQingView = [[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, [UIScreen mainScreen].bounds.size.width, 124+HuiqiangGouHeight)];
        MiaoQingView.backgroundColor = [UIColor whiteColor];
        [self addSubview:MiaoQingView];
        NSLogRect(MiaoQingView.frame);
        shiftHeight+=MiaoQingView.frame.size.height;
    }else
    {
        shiftHeight-=10;
    }

    if (self.isShowHomeLittile) {
        UIImageView *LittleHomeHotIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 13, 16)];
        LittleHomeHotIV.image=KImage(@"icon_hot");
        [MiaoQingView addSubview:LittleHomeHotIV];

        UILabel *littleHomeHotLab=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 120, 15)];

        littleHomeHotLab.font=KNSFONT(15);
        littleHomeHotLab.textColor=RGB(51, 51, 51);
        littleHomeHotLab.text=@"热销家电";
        [MiaoQingView addSubview:littleHomeHotLab];

        self.MiaoQiangButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.MiaoQiangButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-80, 9.5, 70, 16);

        UIImageView *MoreIV=[[UIImageView alloc]initWithFrame:CGRectMake(70-15, 1.5, 8, 13)];
        [self.MiaoQiangButton addSubview:MoreIV];
        [MoreIV setImage:KImage(@"icon_more")];
        [self.MiaoQiangButton setTitle:@"更多" forState:0];
        self.MiaoQiangButton.titleLabel.font=KNSFONTM(13);
        [self.MiaoQiangButton setTitleColor:RGB(51, 51, 51) forState:0];
        [MiaoQingView addSubview:self.MiaoQiangButton];

        MiaoScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36.5, [UIScreen mainScreen].bounds.size.width, 204-36.5)];
        MiaoScrollerView.showsHorizontalScrollIndicator = NO;
        MiaoScrollerView.showsVerticalScrollIndicator = NO;
        [MiaoQingView addSubview:MiaoScrollerView];
    }





    UIView *BgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, [UIScreen mainScreen].bounds.size.width, 10)];
    BgView1.backgroundColor  =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self addSubview:BgView1];

    UIImageView *BgLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    BgLine1.image = [UIImage imageNamed:@"fengexian"];
    [BgView1 addSubview:BgLine1];

    shiftHeight+=BgView1.frame.size.height;

    //有好货
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, [UIScreen mainScreen].bounds.size.width, Width(200))];
    selectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:selectView];
    shiftHeight+=selectView.frame.size.height;

    UIView *ZXView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width(150), Width(200))];
    ZXView.backgroundColor = [UIColor whiteColor];
    [selectView addSubview:ZXView];

    ZXName = [[UILabel alloc] initWithFrame:CGRectMake(Width(12), Width(10), Width(150)-Width(24), Width(24))];
    ZXName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ZXName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:17];
    [ZXView addSubview:ZXName];

    // 创建渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];

    gradientLayer.frame = ZXName.frame;

    gradientLayer.colors = @[(id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:255/255.0 green:79/255.0 blue:71/255.0 alpha:1.0].CGColor];

    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);

    [ZXView.layer addSublayer:gradientLayer];

    gradientLayer.mask = ZXName.layer;

    ZXName.frame = gradientLayer.bounds;


    ZXTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(12), Width(36), Width(150)-Width(24), Width(17))];
    ZXTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    ZXTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [ZXView addSubview:ZXTitle];

    ZXimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(9), Width(60), Width(132), Width(132))];
    ZXimgView.image = [UIImage imageNamed:@""];
    [ZXView addSubview:ZXimgView];

    self.ZXButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ZXButton.frame = CGRectMake(0, 0, Width(150), Width(200));
    [ZXView addSubview:self.ZXButton];





    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(Width(149), 0, Width(1), Width(200))];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [ZXView addSubview:line1];


    UIView *DPView = [[UIView alloc] initWithFrame:CGRectMake(Width(150), 0, [UIScreen mainScreen].bounds.size.width-Width(150), Width(92))];
    DPView.backgroundColor = [UIColor whiteColor];
    [selectView addSubview:DPView];

    self.DPButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.DPButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-Width(150), Width(92));
    [DPView addSubview:self.DPButton];

    DPName = [[UILabel alloc] initWithFrame:CGRectMake(Width(11), Width(10), Width(110), Width(24))];
    //    DPName.text = @"大牌推荐";
    DPName.textColor = [UIColor colorWithRed:19/255.0 green:189/255.0 blue:250/255.0 alpha:1.0];
    DPName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:17];
    [DPView addSubview:DPName];


    DPTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(11), Width(36), Width(110), Width(17))];
    //    DPTitle.text = @"时尚生活我来推荐";
    DPTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    DPTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [DPView addSubview:DPTitle];
    UIImageView *imgiv=[[UIImageView alloc] initWithFrame:CGRectMake(Width(10), Width(57), 45, 22)];
    [imgiv setImage:KImage(@"btnGo")];
    [DPView addSubview:imgiv];


    DPimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(134), Width(5), Width(80), Width(80))];
    DPimgView.image = [UIImage imageNamed:@""];
    [DPView addSubview:DPimgView];

    UIImageView *DPline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, Width(90), [UIScreen mainScreen].bounds.size.width-Width(150), Width(1))];
    DPline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [DPView addSubview:DPline1];


    UIView *JDView = [[UIView alloc] initWithFrame:CGRectMake(Width(150), Width(91), ([UIScreen mainScreen].bounds.size.width-Width(150))/2, Width(109))];
    JDView.backgroundColor = [UIColor whiteColor];
    [selectView addSubview:JDView];

    self.JDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.JDButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-Width(150))/2, Width(109));
    [JDView addSubview:self.JDButton];

    JDName = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(5), ([UIScreen mainScreen].bounds.size.width-Width(150))/2-Width(20), Width(24))];
    //    JDName.text = @"家电馆";
    JDName.textColor = [UIColor colorWithRed:255/255.0 green:77/255.0 blue:111/255.0 alpha:1.0];
    JDName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:17];
    [JDView addSubview:JDName];


    JDTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(31), ([UIScreen mainScreen].bounds.size.width-Width(150))/2-Width(20), Width(12))];
    //    JDTitle.text = @"舒适便捷好生活";
    JDTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    JDTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [JDView addSubview:JDTitle];


    JDimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(15), Width(48), Width(76), Width(60))];
    JDimgView.image = [UIImage imageNamed:@""];
    [JDView addSubview:JDimgView];

    UIImageView *JDline1 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-Width(150))/2-Width(1), 0, Width(1), Width(109))];
    JDline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [JDView addSubview:JDline1];

    UIView *MWView = [[UIView alloc] initWithFrame:CGRectMake(Width(150)+([UIScreen mainScreen].bounds.size.width-Width(150))/2, Width(92), ([UIScreen mainScreen].bounds.size.width-Width(150))/2, Width(108))];
    MWView.backgroundColor = [UIColor whiteColor];
    [selectView addSubview:MWView];

    self.MWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.MWButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-Width(150))/2, Width(108));
    [MWView addSubview:self.MWButton];

    MWName = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(5), ([UIScreen mainScreen].bounds.size.width-Width(150))/2-Width(20), Width(24))];
    //    MWName.text = @"美味惠吃";
    MWName.textColor = [UIColor colorWithRed:255/255.0 green:139/255.0 blue:0/255.0 alpha:1.0];
    MWName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:17];
    [MWView addSubview:MWName];



    MWTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(31), ([UIScreen mainScreen].bounds.size.width-Width(150))/2-Width(20), Width(12))];
    //    MWTitle.text = @"吃货的后裔";
    MWTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    MWTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [MWView addSubview:MWTitle];


    MWimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(20), Width(46), Width(60), Width(58))];
    [MWView addSubview:MWimgView];

    //护肤
    UIView *TSView = [[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, [UIScreen mainScreen].bounds.size.width, Width(20))];
    TSView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self addSubview:TSView];
    shiftHeight+=Width(20);

    UIView *TSSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, [UIScreen mainScreen].bounds.size.width, Width(245))];
    TSSelectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:TSSelectView];
    shiftHeight+=TSSelectView.frame.size.height;

    UIView *HFView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width(188), Width(122))];
    HFView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:HFView];

    if (1) {
        UIImageView *ChaoliuIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 100, 30)];
        [ChaoliuIV setImage:KImage(@"xlhome-r1")];
        [TSSelectView addSubview:ChaoliuIV];

        UILabel * chaoliulab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
        chaoliulab.font=KNSFONT(17);
        chaoliulab.textColor=RGB(255, 255, 255);
        chaoliulab.text=@"特色必逛";
        chaoliulab.textAlignment=NSTextAlignmentRight;
        [ChaoliuIV addSubview:chaoliulab];
    }

    self.HFButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.HFButton.frame = CGRectMake(0, 0, Width(188), Width(122));
    [HFView addSubview:self.HFButton];

    HFName = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(10), Width(188)-Width(20), Width(15))];
    //    HFName.text = @"护肤美妆";
    HFName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    HFName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    HFName.textAlignment=NSTextAlignmentRight;
    [HFView addSubview:HFName];

    HFTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(31), Width(188)-Width(20), Width(12))];
    HFTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    HFTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    HFTitle.textAlignment=NSTextAlignmentRight;
    [HFView addSubview:HFTitle];

    HFimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(10), Width(52), Width(168), Width(60))];
    HFimgView.image = [UIImage imageNamed:@""];
    [HFView addSubview:HFimgView];



    UIImageView *HFline1 = [[UIImageView alloc] initWithFrame:CGRectMake(Width(375)/4.0*2-Width(1), 0, Width(1), Width(122))];
    HFline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [HFView addSubview:HFline1];

    UIImageView *HFline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, Width(121), Width(188), Width(1))];
    HFline2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [HFView addSubview:HFline2];


    UIView *FZView = [[UIView alloc] initWithFrame:CGRectMake(Width(188), 0, Width(187), Width(122))];
    FZView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:FZView];

    self.FZButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.FZButton.frame = CGRectMake(0, 0, Width(187), Width(122));
    [FZView addSubview:self.FZButton];

    FZName = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(10), Width(187)-Width(20), Width(15))];
    //    FZName.text = @"服装箱包";
    FZName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    FZName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [FZView addSubview:FZName];

    FZTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(31), Width(187)-Width(20), Width(12))];
    //    FZTitle.text = @"搭配属于你的时尚";
    FZTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    FZTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [FZView addSubview:FZTitle];

    FZimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(10), Width(52), Width(168), Width(60))];
    FZimgView.image = [UIImage imageNamed:@""];
    [FZView addSubview:FZimgView];


    UIImageView *FZline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, Width(121), Width(187), Width(1))];
    FZline2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [FZView addSubview:FZline2];

    UIView *JJView = [[UIView alloc] initWithFrame:CGRectMake(0, Width(122), [UIScreen mainScreen].bounds.size.width/4, Width(123))];
    JJView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:JJView];

    self.JJButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.JJButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Width(123));
    [JJView addSubview:self.JJButton];

    JJName = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(6), [UIScreen mainScreen].bounds.size.width/4-Width(20), Width(15))];
    //    JJName.text = @"居家生活";
    JJName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JJName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [JJView addSubview:JJName];

    JJTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(26), [UIScreen mainScreen].bounds.size.width/4-Width(20), Width(12))];
    //    JJTitle.text = @"造有品的家";
    JJTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    JJTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [JJView addSubview:JJTitle];

    JJimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(12), Width(48), Width(70), Width(70))];
    JJimgView.image = [UIImage imageNamed:@""];
    [JJView addSubview:JJimgView];

    UIImageView *JJline1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-Width(1), 0, Width(1), Width(123))];
    JJline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [JJView addSubview:JJline1];

    UIView *GJView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4, Width(122), [UIScreen mainScreen].bounds.size.width/4, Width(123))];
    GJView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:GJView];

    self.GJButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.GJButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Width(123));
    [GJView addSubview:self.GJButton];

    GJName = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(6), [UIScreen mainScreen].bounds.size.width/4-Width(20), Width(15))];
    //    GJName.text = @"搞机派";
    GJName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GJName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [GJView addSubview:GJName];

    GJTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(26), [UIScreen mainScreen].bounds.size.width/4-Width(20), Width(12))];
    //    GJTitle.text = @"数码发烧友";
    GJTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    GJTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [GJView addSubview:GJTitle];

    GJimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(12), Width(48), Width(70), Width(70))];
    GJimgView.image = [UIImage imageNamed:@""];
    [GJView addSubview:GJimgView];

    UIImageView *GJline1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-Width(1), 0, Width(1), Width(123))];
    GJline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [GJView addSubview:GJline1];

    UIView *BBView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*2, Width(122), [UIScreen mainScreen].bounds.size.width/4, Width(123))];
    BBView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:BBView];

    self.BBButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.BBButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Width(123));
    [BBView addSubview:self.BBButton];

    BBName = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(6), [UIScreen mainScreen].bounds.size.width/4-Width(20), Width(15))];
    //    BBName.text = @"亲宝贝";
    BBName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    BBName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [BBView addSubview:BBName];

    BBTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(26), [UIScreen mainScreen].bounds.size.width/4-Width(20), Width(12))];
    //    BBTitle.text = @"花钱少养好娃";
    BBTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    BBTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [BBView addSubview:BBTitle];

    BBimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(12), Width(48), Width(70), Width(70))];
    //    BBimgView.image = [UIImage imageNamed:@""];
    [BBView addSubview:BBimgView];

    UIImageView *BBline1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-Width(1), 0, Width(1), Width(123))];
    BBline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [BBView addSubview:BBline1];

    UIView *HWView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*3, Width(123), [UIScreen mainScreen].bounds.size.width/4, Width(123))];
    HWView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:HWView];

    self.HWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.HWButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Width(123));
    [HWView addSubview:self.HWButton];

    HWName = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(6), [UIScreen mainScreen].bounds.size.width/4-Width(20), Width(15))];
    //    HWName.text = @"户外运动";
    HWName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    HWName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [HWView addSubview:HWName];

    HWTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width(10), Width(26), [UIScreen mainScreen].bounds.size.width/4-Width(20), Width(12))];
    //    HWTitle.text = @"运动酷夏";
    HWTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    HWTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [HWView addSubview:HWTitle];

    HWimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width(12), Width(48), Width(70), Width(70))];
    //    HWimgView.image = [UIImage imageNamed:@""];
    [HWView addSubview:HWimgView];


    UIImageView *ChaoliufengeView=[[UIImageView alloc]initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Width(20))];
    ChaoliufengeView.image=KImage(@"分割线-拷贝");
    [self addSubview:ChaoliufengeView];

    //潮流
    if (!ChaoliuView) {
        ChaoliuView=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight+Width(20), kScreenWidth, Width(374))];
        [ChaoliuView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:ChaoliuView];
    }else
    {
        ChaoliuView.frame=CGRectMake(0, shiftHeight+Width(20), kScreenWidth, Width(374));
        [self addSubview:ChaoliuView];
    }
    shiftHeight+=ChaoliuView.frame.size.height+Width(20);
    //极客
    UIImageView *ChaoliufengeView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Width(10))];
    ChaoliufengeView1.image=KImage(@"分割线-拷贝");
    shiftHeight+=ChaoliufengeView1.frame.size.height;
    [self addSubview:ChaoliufengeView1];

    if (!JiKeView) {
        JiKeView=[[UIImageView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Width(124))];
        [JiKeView setImage:KImage(@"xlhome-Geek")];
        [self setjikeView];
        [self addSubview:JiKeView];

    }
    else
    {
        JiKeView.frame=CGRectMake(0, shiftHeight, kScreenWidth, Width(124));
        [self addSubview:JiKeView];
        [self addSubview:JiKeView];
    }
    shiftHeight+=JiKeView.frame.size.height;
    //大牌
    if (!DaPaiView) {
        DaPaiView=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Height(30)+Width(124)+40)];

        [self addSubview:DaPaiView];
    }else
    {
        DaPaiView.frame=CGRectMake(0, shiftHeight, kScreenWidth, Height(30)+Width(124)+40);
        [self addSubview:DaPaiView];
    }
    shiftHeight+=DaPaiView.frame.size.height;

    //清单
    if (!YouXuanView) {
        YouXuanView=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Height(30)+Width(124)+40)];

        [self addSubview:YouXuanView];
    }else
    {
        YouXuanView.frame=CGRectMake(0, shiftHeight, kScreenWidth, Height(30)+Width(124)+40);
        [self addSubview:YouXuanView];
    }
    shiftHeight+=YouXuanView.frame.size.height;

    //特卖
    if (!HaoHuoView) {
        HaoHuoView=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Height(30)+Width(124)+40)];

        [self addSubview:HaoHuoView];
    }
    else
    {
        HaoHuoView.frame=CGRectMake(0, shiftHeight, kScreenWidth, Height(30)+Width(124)+40);
        [self addSubview:HaoHuoView];

    }
    shiftHeight+=HaoHuoView.frame.size.height;

    //发现号店
    if (!HaoDianView) {

        HaoDianView=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Height(30)+Width(342))];

        [HaoDianView setBackgroundColor:RGB(246, 246, 246)];
        [self addSubview:HaoDianView];
    }else
    {
        HaoDianView.frame=CGRectMake(0, shiftHeight, kScreenWidth, Height(30)+Width(342));
        [self addSubview:HaoDianView];

    }
    shiftHeight+=HaoDianView.frame.size.height;

    //top榜
    if (!TopBangView) {
        TopBangView=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Width(362))];
        [TopBangView setBackgroundColor:[UIColor whiteColor]];
        [self  addSubview:TopBangView];
        TopBangView.userInteractionEnabled=YES;
    }else
    {
        TopBangView.frame=CGRectMake(0, shiftHeight, kScreenWidth, Width(362));
        TopBangView.userInteractionEnabled=YES;
        [self  addSubview:TopBangView];

    }
    shiftHeight +=TopBangView.frame.size.height;
    UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Height(10))];
    [backview setBackgroundColor:RGB(246, 246, 246)];
    shiftHeight+=Height(10);
    [self addSubview:backview];
    //热门市场
    if (!reMenSCView) {

        reMenSCView=[[UIView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, Width(242))];

        [self addSubview:reMenSCView];

    }else
    {
        reMenSCView.frame=CGRectMake(0, shiftHeight, kScreenWidth, Width(242));

        [self addSubview:reMenSCView];

    }
    shiftHeight+=reMenSCView.frame.size.height;


}


-(void)setIsShowHQG:(NSString *)isShowHQG  isShowBigHeathy:(NSString *)isShowBigHeathy isShowHomeLittile:(BOOL)isShow
{
    _isShowHQG=isShowHQG;
    _isShowBigHeathy=isShowBigHeathy;
    _isShowHomeLittile=isShow;

    if (isShow||[isShowHQG isEqualToString:@"0"]) {
        HuiqiangGouHeight=80;
    }else
    {
        HuiqiangGouHeight=-134;
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self loadMyCell];
    self.list1=_list1;
    self.list2=_list2;

}


- (UIViewController*)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
//积分专题、小家电
-(void)setList1:(NSArray *)list1
{

    _list1 = list1;

    NSLog(@"===惠抢购数据===%ld==DataArrM==%ld",(long)_list1.count,(long)DataArrM.count);

    for (UIView *view1 in MiaoScrollerView.subviews) {
        [view1 removeFromSuperview];
    }

    MiaoScrollerView.contentSize = CGSizeMake((HuiqiangGouHeight+5.5)*_list1.count+9.5, 94+HuiqiangGouHeight-36.5);

    for (int i =0; i < _list1.count; i++) {

        HomeModel *model = _list1[i];

        view = [[UIView alloc] initWithFrame:CGRectMake(HuiqiangGouHeight*i+9.5+5.5*i, 0, HuiqiangGouHeight, HuiqiangGouHeight+94-36.5)];
        view.tag = 10+i;
        [MiaoScrollerView addSubview:view];

        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        imgView.tag = 40+i;
        [view addSubview:imgView];

        if ([model.status isEqualToString:@"6"] || [model.stock isEqualToString:@"0"]) {

            UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake((80-60)/2, (80-60)/2, 60, 60)];
            imgView1.image = [UIImage imageNamed:@"已售完new"];
            [view addSubview:imgView1];
        }
        UILabel *Price = [[UILabel alloc] initWithFrame:CGRectMake(0, HuiqiangGouHeight+11, HuiqiangGouHeight, 40)];
        Price.text = [NSString stringWithFormat:@"￥%@\n+%@积分",model.pay_maney,model.pay_integer];
        Price.textAlignment = NSTextAlignmentCenter;
        Price.tag = 70+i;
        Price.numberOfLines=2;
        Price.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        Price.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [view addSubview:Price];

        UILabel *Count = [[UILabel alloc] initWithFrame:CGRectMake(0, HuiqiangGouHeight+51+10, HuiqiangGouHeight, 12.5)];
        Count.text = [NSString stringWithFormat:@"仅剩:%@件",model.stock];
        Count.textAlignment = NSTextAlignmentCenter;
        Count.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        Count.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:Count];

        NSString *stringForColor3 = [NSString stringWithFormat:@"%@",model.stock];
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:Count.text];
        //
        NSRange range3 = [Count.text rangeOfString:stringForColor3];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range3];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:13] range:range3];
        Count.attributedText=mAttStri;


        self.HQGButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.HQGButton.frame = CGRectMake(0, 0, 80, 234-36.5);
        self.HQGButton.tag = [model.ID integerValue];
        self.HQGButton.tag = i;
        self.HQGButton.userInteractionEnabled=YES;
        [self.HQGButton addTarget:self action:@selector(HQGButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.HQGButton];
    }

}
//为你甄选模块、、特色必逛
-(void)setList2:(NSArray *)list2
{

    _list2 = list2;

    for (int i =0; i < _list2.count; i++) {

        HomeModel *model = _list2[i];

        if ([model.ID isEqualToString:@"1"]) {

            JDName.text = model.special_name;
            JDTitle.text = model.subtitle;
            self.JDButton.tag = [model.ID integerValue];
            [JDimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"2"]){

            MWName.text = model.special_name;
            MWTitle.text = model.subtitle;
            self.MWButton.tag = [model.ID integerValue];
            [MWimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"3"]){

            HFName.text = model.special_name;
            HFTitle.text = model.subtitle;
            self.HFButton.tag = [model.ID integerValue];
            [HFimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"4"]){

            FZName.text = model.special_name;
            FZTitle.text = model.subtitle;
            self.FZButton.tag = [model.ID integerValue];
            [FZimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"5"]){

            JJName.text = model.special_name;
            JJTitle.text = model.subtitle;
            self.JJButton.tag = [model.ID integerValue];
            [JJimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"6"]){

            GJName.text = model.special_name;
            GJTitle.text = model.subtitle;
            self.GJButton.tag = [model.ID integerValue];
            [GJimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"7"]){

            BBName.text = model.special_name;
            BBTitle.text = model.subtitle;
            self.BBButton.tag = [model.ID integerValue];
            [BBimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"8"]){

            HWName.text = model.special_name;
            HWTitle.text = model.subtitle;
            self.HWButton.tag = [model.ID integerValue];
            [HWimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"9"]){

            ZXName.text = model.special_name;
            ZXTitle.text = model.subtitle;
            self.ZXButton.tag = [model.ID integerValue];
            [ZXimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if([model.ID isEqualToString:@"10"]){

            DPName.text = model.special_name;
            DPTitle.text = model.subtitle;
            self.DPButton.tag = [model.ID integerValue];
            [DPimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }
    }
}

//极客驿站
-(void)setjikeStr:(NSString *)str andJikeSubStr:(NSString *)str2 andPostPic:(NSString *)picstr
{

    _jikeStr=str;
    _jikeSubStr=str2;
    _picstr=picstr;
    [self setjikeView];

}
//潮流好货
-(void)setList4:(NSArray *)list4
{
    _list4=list4;
    if (list4.count==0) {
        return;
    }
    [self setChaoLiuView];
}
//大牌推荐
-(void)setDPArrM:(NSArray *)DPArrM
{
    _DPArrM=DPArrM;
    if (DPArrM.count==0) {
        return;
    }
    [self setDaPaiSugView];
}
//优选清单
-(void)setJXlist:(NSArray *)JXlist
{
    _JXlist=JXlist;
    if (JXlist.count==0) {
        return;
    }
    [self setYouXuanQDView];
}
//好货特卖
-(void)setHaoHuoArrM:(NSArray *)HaoHuoArrM
{
    _HaoHuoArrM=HaoHuoArrM;
    if (HaoHuoArrM.count==0) {
        return;
    }
    [self setHaoHuoTMView];
}
//发现好店
-(void)setHDlist:(NSArray *)HDlist
{
    _HDlist=HDlist;
    if (HDlist.count==0) {
        return;
    }
    [self setFaXianHDView];
}
//top榜
-(void)setTopBangArrM:(NSArray *)TopBangArrM
{
    _TopBangArrM=TopBangArrM;
    if (TopBangArrM.count==0) {
        return;
    }else
    {
        [self TopBangView];
    }
}

-(void)setXl:(NSString *)xl
{
    _xl=xl;
    selectindex=0;
}

//热门市场
-(void)setReMenSCArrM:(NSArray *)ReMenSCArrM
{
    _ReMenSCArrM=ReMenSCArrM;
    if (ReMenSCArrM.count>0) {
        [self ReMenSCView];
    }
}

//热门市场
-(void)ReMenSCView
{
    if (_ReMenSCArrM.count==0) {
        [reMenSCView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        reMenSCView=nil;
        return;

    }else
    {
        [reMenSCView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    CGFloat butWidth=Width(375-3)/4;
    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,kScreenWidth , Width(40))];
    titleLab.text=@"热门市场";
    titleLab.textColor=RGB(51, 51, 51);
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.font=KNSFONT(17);
    [reMenSCView addSubview:titleLab];

    UIImageView *MsgTitleIV1=[[UIImageView alloc] initWithFrame:CGRectMake(Width(93), (Width(40)-5)/2, 56, 5)];
    [MsgTitleIV1 setImage:KImage(@"msgTitle1")];
    [titleLab addSubview:MsgTitleIV1];

    UIImageView *MsgTitleIV2=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-Width(93)-56, (Width(40)-5)/2, 56, 5)];
    [MsgTitleIV2 setImage:KImage(@"msgTitle2")];
    [titleLab addSubview:MsgTitleIV2];


    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, Width(40), kScreenWidth, Width(1))];
    [view1 setBackgroundColor:RGB(242, 242, 242)];
    [reMenSCView addSubview:view1];

    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(0, Width(41)+butWidth, kScreenWidth, Width(1))];
    [view2 setBackgroundColor:RGB(242, 242, 242)];
    [reMenSCView addSubview:view2];

    UIView *view3=[[UIView alloc] initWithFrame:CGRectMake(0, butWidth*2+Width(42), kScreenWidth, Width(1))];
    [view3 setBackgroundColor:RGB(242, 242, 242)];
    [reMenSCView addSubview:view3];

    UIView *view4=[[UIView alloc] initWithFrame:CGRectMake(butWidth, Width(40), Width(1), 2*butWidth+Width(3))];
    [view4 setBackgroundColor:RGB(242, 242, 242)];
    [reMenSCView addSubview:view4];

    UIView *view5=[[UIView alloc] initWithFrame:CGRectMake(butWidth*2+Width(1), Width(40), Width(1), 2*butWidth+Width(3))];
    [view5 setBackgroundColor:RGB(242, 242, 242)];
    [reMenSCView addSubview:view5];

    UIView *view6=[[UIView alloc] initWithFrame:CGRectMake(butWidth*3+Width(2), Width(40), Width(1), 2*butWidth+Width(3))];
    [view6 setBackgroundColor:RGB(242, 242, 242)];
    [reMenSCView addSubview:view6];
    for (int i=0; i<2; i++) {
        for (int j=0; j<4; j++) {

            CGRect rect=CGRectMake(j*(Width(1)+butWidth), i*(butWidth+Width(1))+Width(40), butWidth, butWidth);

            UIButton *DPBut=[UIButton buttonWithType:UIButtonTypeCustom];
            DPBut.frame=rect;
            DPBut.tag=600+i*4+j;
            [DPBut addTarget:self action:@selector(RemenButClick:) forControlEvents:UIControlEventTouchUpInside];
            [reMenSCView addSubview:DPBut];

            UIImageView *DPIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(6), Width(6) , Width(80), Width(70))];
            [DPIV setImage:KImage(_ReMenSCArrM[i*4+j])];
            [DPBut addSubview:DPIV];

            UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(0, Width(77), butWidth, Width(17))];
            nameLab.font=KNSFONT(12);
            nameLab.textColor=RGB(155, 155, 155);
            nameLab.text=_ReMenSCArrM[i*4+j];
            nameLab.textAlignment=NSTextAlignmentCenter;
            [DPBut addSubview:nameLab];

            if ((j==0)&&(i==0)) {
                UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(Width(65), Width(1), Width(24), Width(24))];
                [iv setImage:KImage(@"xlhome-big-ranking 1")];
                [DPBut addSubview:iv];
            }else if ((j==1)&&(i==0)) {
                UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(Width(65), Width(1), Width(24), Width(24))];
                [iv setImage:KImage(@"xlhome-big-ranking 2")];
                [DPBut addSubview:iv];
            } else if ((j==2)&&(i==0)) {
                UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(Width(65), Width(1), Width(24), Width(24))];
                [iv setImage:KImage(@"xlhome-big ranking 3")];
                [DPBut addSubview:iv];
            }
        }
    }

}


-(void)RemenButClick:(UIButton *)sender
{

    NSString *str=_ReMenSCArrM[sender.tag-600];

    self.viewController.tabBarController.selectedIndex=1;

    [KNotificationCenter postNotificationName:@"homeClick" object:nil userInfo:@{@"text":str}];

}



-(void)TopBangView
{

    if (_TopBangArrM.count==0) {
        [TopBangView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        TopBangView=nil;
        return;
    }else
    {
        [TopBangView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }

    if (!selectindex) {
        selectindex=0;
    }

    CGFloat left=Width(10);
    CGFloat height=0;
    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,kScreenWidth , 40)];
    titleLab.text=@"TOP榜";
    titleLab.textColor=RGB(51, 51, 51);
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.font=KNSFONT(17);
    [TopBangView addSubview:titleLab];

    UIImageView *MsgTitleIV1=[[UIImageView alloc] initWithFrame:CGRectMake(Width(93), 18, 56, 5)];
    [MsgTitleIV1 setImage:KImage(@"msgTitle1")];
    [titleLab addSubview:MsgTitleIV1];

    UIImageView *MsgTitleIV2=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-Width(93)-56, 18, 56, 5)];
    [MsgTitleIV2 setImage:KImage(@"msgTitle2")];
    [titleLab addSubview:MsgTitleIV2];



    height+=Height(20)+15;

    XLHomeTopBangModel *topmodel=_TopBangArrM[selectindex];

    AllSingleShoppingModel *model=topmodel.good_list[0];

    UIImageView *lineIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 1)];
    [lineIV setImage:KImage(@"分割线-拷贝")];
    [TopBangView addSubview:lineIV];

    CGFloat butWidth=Width(83);
    CGFloat butWidthAndRigion=butWidth+(kScreenWidth-Width(83)*4-Width(20))/3;
    for (int i=0; i<_TopBangArrM.count; i++) {
        XLHomeTopBangModel *topmodel=_TopBangArrM[i];
        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.layer.cornerRadius=4;
        but.frame=CGRectMake(Width(10)+i*butWidthAndRigion, Width(50), butWidth, 26);
        [but setTitle:topmodel.scope forState:UIControlStateNormal];
        [but setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        but.titleLabel.font=KNSFONT(12);
        but.tag=500+i;
        [but setBackgroundColor:RGB(242, 242, 242)];
        [but addTarget:self action:@selector(topBangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [TopBangView addSubview:but];

        if (i==selectindex) {
            [but setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            [but setBackgroundColor:RGB(243, 73, 73)];
        }
    }



    height=Width(88);
    UIImageView *goodsIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(10), height, Width(112), Width(112))];
    [goodsIV sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
    [TopBangView addSubview:goodsIV];

    UILabel *numLab1=[[UILabel alloc] initWithFrame:CGRectMake(0, Width(82), Width(112), Width(30))];
    numLab1.text=[NSString stringWithFormat:@"热门指数%@",model.hot_index];
    numLab1.textColor=RGB(255, 255, 255);
    numLab1.font=KNSFONT(15);
    numLab1.textAlignment=NSTextAlignmentCenter;
    numLab1.backgroundColor=RGBA(0, 0, 0, 0.5);
    [goodsIV addSubview:numLab1];

    UILabel *goodsNameLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(20)+Width(112), height, kScreenWidth-Width(30)-Width(112), 42)];
    goodsNameLab.text=model.name;
    goodsNameLab.textColor=RGB(51, 51, 51);
    goodsNameLab.font=KNSFONT(15);
    goodsNameLab.numberOfLines=2;
    [TopBangView addSubview:goodsNameLab];

    UILabel *priceLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(20)+125, height +Width(20)+39, kScreenWidth-Width(30)-125, 15)];
    priceLab.text=[NSString stringWithFormat:@"￥%@+%@积分",model.pay_maney,model.pay_integer];
    priceLab.textColor=RGB(243, 73, 73);
    priceLab.font=KNSFONT(15);
    [TopBangView addSubview:priceLab];

    UILabel *storeNameLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(20)+Width(112), height+Width(112)-13, kScreenWidth-Width(30)-Width(112)-100, 15)];
    storeNameLab.text=model.storename;
    storeNameLab.textColor=RGB(153, 153, 153);
    storeNameLab.font=KNSFONT(13);
    [TopBangView addSubview:storeNameLab];

    UILabel *numLab=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(10)-100, height+Width(112)-13, 100, 13)];
    numLab.text=[NSString stringWithFormat:@"%@人付款",model.amount];
    numLab.textColor=RGB(153, 153, 153);
    numLab.font=KNSFONT(13);
    numLab.textAlignment=NSTextAlignmentRight;
    [TopBangView addSubview:numLab];

    UIButton *goodsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    goodsBut.frame=CGRectMake(0, height, kScreenWidth, 125);
    goodsBut.tag=1000;
    [goodsBut addTarget:self action:@selector(checkGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
    [TopBangView addSubview:goodsBut];


    height+=Width(112)+Width(10);

    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Width(152))];
    scroll.showsHorizontalScrollIndicator=NO;
    [TopBangView addSubview:scroll];

    CGFloat marin=10;

    for (int i=1; i<topmodel.good_list.count; i++) {


        AllSingleShoppingModel *model=topmodel.good_list[i];

        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(left+(Width(100)+marin)*(i-1), 0, Width(100), Width(100))];
        [iv sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [scroll addSubview:iv];

        UILabel *numLab=[[UILabel alloc] initWithFrame:CGRectMake(0, Width(70), Width(100), Width(30))];
        numLab.text=[NSString stringWithFormat:@"热门指数%@",model.hot_index];
        numLab.textColor=RGB(255, 255, 255);
        numLab.font=KNSFONT(15);
        numLab.textAlignment=NSTextAlignmentCenter;
        numLab.backgroundColor=RGBA(0, 0, 0, 0.5);
        [iv addSubview:numLab];

        iv.userInteractionEnabled=YES;

        UILabel *priceLab=[[UILabel alloc] initWithFrame:CGRectMake(left+(Width(100)+marin)*(i-1), Width(100)+Height(5), Width(100), 42)];
        priceLab.text=[NSString stringWithFormat:@"￥%@+%@积分",model.pay_maney,model.pay_integer];
        priceLab.textColor=RGB(243, 73, 73);
        priceLab.font=KNSFONT(14);
        priceLab.numberOfLines=2;
        priceLab.textAlignment=NSTextAlignmentCenter;
        [scroll addSubview:priceLab];

        UIButton *goodsBut1=[UIButton buttonWithType:UIButtonTypeCustom];
        [goodsBut1 setFrame:CGRectMake(left+(Width(100)+marin)*(i-1), 0, Width(100), Width(100)+Height(5)+14)];
        goodsBut1.tag=1000+i;
        [goodsBut1 addTarget:self action:@selector(checkGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:goodsBut1];
    }
    scroll.contentSize=CGSizeMake(left+(Width(100)+marin)*(topmodel.good_list.count-1), Width(152));
    if (!_m_timer) {
        _m_timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(topBangTimeChange:) userInfo:nil repeats:YES];
        [_m_timer fire];
    }

}

-(void)topBangTimeChange:(NSTimer *)timer
{
    selectindex++;
    NSLog(@"%d",selectindex);
    if (selectindex>3) {
        selectindex=0;
    }
    [self TopBangView];
}

-(void)checkGoodsDetail:(UIButton *)sender
{
    XLHomeTopBangModel *topmodel=_TopBangArrM[selectindex];

    AllSingleShoppingModel *model=topmodel.good_list[sender.tag-1000];
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.gid=model.gid;
    self.viewController.navigationController.navigationBar.hidden=YES;
    self.viewController.tabBarController.tabBar.hidden=YES;
    [self.viewController.navigationController pushViewController:vc animated:NO];
}

-(void)topBangBtnClick:(UIButton *)sender
{
    selectindex=sender.tag-500;

    YLog(@"%ld",sender.tag);
    [self TopBangView];
}

-(void)getDatas4
{

}


-(void)setFaXianHDView
{

    [HaoDianView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIView *DianPuView=[[UIView alloc] initWithFrame:CGRectMake(0, Height(20), kScreenWidth, Width(342))];
    [DianPuView setBackgroundColor:[UIColor whiteColor]];
    [HaoDianView addSubview:DianPuView];

    for (int i=0; i<_HDlist.count; i++) {

        HomeModel *model=_HDlist[i];

        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake((i%2)*kScreenWidth/2, (i/2)*Width(171), kScreenWidth/2, Width(171))];
        but.tag=300+i;
        [but addTarget:self action:@selector(FXHDBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [DianPuView addSubview:but];

        NSDictionary *dic=model.array.firstObject;
        NSString *str1=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];
        NSDictionary *dic2=model.array[1];
        NSString *str2=[NSString stringWithFormat:@"%@",dic2[@"scopeimg"]];
        NSDictionary *dic3=model.array[2];
        NSString *str3=[NSString stringWithFormat:@"%@",dic3[@"scopeimg"]];

        UIImageView *BigIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(9), Width(10), Width(112), Width(112))];
        [BigIV sd_setImageWithURL:KNSURL(str1) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [but addSubview:BigIV];

        UIImageView *smallIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(123), Width(10), Width(55), Width(55))];
        [smallIV sd_setImageWithURL:KNSURL(str2) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [but addSubview:smallIV];

        UIImageView *smallIV2=[[UIImageView alloc] initWithFrame:CGRectMake(Width(123), Width(10)+Width(55)+Width(2), Width(55), Width(55))];
        [smallIV2 sd_setImageWithURL:KNSURL(str3) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [but addSubview:smallIV2];

        UIView *redView=[[UIView alloc] initWithFrame:CGRectMake(Width(9), Width(128), Width(5), Width(16))];
        redView.backgroundColor=RGB(243, 73, 73);
        [but addSubview:redView];

        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(20), Width(125), Width(159), Width(21))];
        lab.font=KNSFONT(15);
        lab.textColor=RGB(51, 51, 51);
        lab.text=model.storename;
        [but addSubview:lab];

        UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(Width(9), Width(146), Width(169), Width(17))];
        lab1.font=KNSFONT(12);
        lab1.textColor=RGB(155, 155, 155);
        lab1.text=[NSString stringWithFormat:@"%@人已逛",model.click_volume];
        [but addSubview:lab1];

    }
    UIImageView *ChaoliuIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 100, 30)];
    [ChaoliuIV setImage:KImage(@"xlhome-r6")];
    [DianPuView addSubview:ChaoliuIV];

    UILabel * chaoliulab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    chaoliulab.font=KNSFONT(17);
    chaoliulab.textColor=RGB(255, 255, 255);
    chaoliulab.text=@"发现好店";
    chaoliulab.textAlignment=NSTextAlignmentRight;
    [ChaoliuIV addSubview:chaoliulab];


}

-(void)FXHDBtnClick:(UIButton *)sender
{

    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];


    HomeModel *model=_HDlist[sender.tag -300];

    vc.mid = model.mid;
    vc.Logo=model.logo;
    vc.GetString=@"1";

    self.viewController.navigationController.navigationBar.hidden=YES;

    self.viewController.tabBarController.tabBar.hidden=YES;

    [self.viewController.navigationController pushViewController:vc animated:NO];
}

-(void)setHaoHuoTMView
{


    [HaoHuoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];


    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Height(30)+Width(124))];
    scroll.backgroundColor=RGB(246, 246, 246);
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.tag=1234;
    scroll.delegate=self;
    [HaoHuoView addSubview:scroll];

    UIImageView *ChaoliuIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(20)-10, 100, 30)];
    [ChaoliuIV setImage:KImage(@"xlhome-r5")];
    [HaoHuoView addSubview:ChaoliuIV];

    UILabel * chaoliulab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    chaoliulab.font=KNSFONT(17);
    chaoliulab.textColor=RGB(255, 255, 255);
    chaoliulab.text=@"好货特卖";
    chaoliulab.textAlignment=NSTextAlignmentRight;
    [ChaoliuIV addSubview:chaoliulab];

    for (int i=0; i<_HaoHuoArrM.count; i++) {
        AllSingleShoppingModel *model=_HaoHuoArrM[i];
        UIImageView *DPIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(125)*i, Height(20) , Width(124), Width(124))];
        [DPIV sd_setImageWithURL:KNSURL(model.path) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [scroll addSubview:DPIV];
        DPIV.userInteractionEnabled=YES;

        UIButton *DPBut=[UIButton buttonWithType:UIButtonTypeCustom];
        DPBut.frame=DPIV.bounds;
        DPBut.tag=400+i;
        [DPBut addTarget:self action:@selector(HHBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [DPIV addSubview:DPBut];

        //        UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, Width(94), Width(124), Width(30))];
        //        backView.backgroundColor=RGBA(0, 0, 0,0.5);
        //        [DPIV addSubview:backView];
        //
        //        UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(0, Width(10), Width(230), Width(20))];
        //        nameLab.font=KNSFONT(17);
        //        nameLab.textColor=[UIColor whiteColor];
        //        nameLab.text=model.main_title;
        //        [backView addSubview:nameLab];
    }

    UIButton *moreBut=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBut.frame=CGRectMake(0, Height(30)+Width(124), kScreenWidth, 40);
    [moreBut setBackgroundColor:[UIColor whiteColor]];
    [moreBut setTitle:@"更多特卖" forState:UIControlStateNormal];
    moreBut.titleLabel.font=KNSFONT(15);
    NSString * str=@"更多特卖";
    UIImageView *IV=[[UIImageView alloc] init];
    CGSize size=[str sizeWithFont:KNSFONT(15) maxSize:kScreenSize];
    [IV setFrame:CGRectMake((kScreenWidth-size.width)/2+size.width+5, (40-13.5)/2, 8, 13)];
    [IV setImage:KImage(@"icon_more_jiadian")];
    [moreBut addSubview:IV];
    [moreBut addTarget:self action:@selector(moreHHBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [moreBut setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [HaoHuoView addSubview:moreBut];

}

-(void)HHBtnClick:(UIButton *)sender
{
    AllSingleShoppingModel *model=_HaoHuoArrM[sender.tag-400];
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.gid=model.gid;
    self.viewController.navigationController.navigationBar.hidden=YES;
    self.viewController.tabBarController.tabBar.hidden=YES;
    [self.viewController.navigationController pushViewController:vc animated:NO];

}

-(void)moreHHBtnClick
{

    HomeGoodGoodsHotSaleVC *VC=[[HomeGoodGoodsHotSaleVC alloc] init];

    VC.hidesBottomBarWhenPushed=YES;
    [self.viewController.navigationController pushViewController:VC animated:NO];

}

-(void)setYouXuanQDView
{


    [YouXuanView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];


    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Height(30)+Width(124))];
    scroll.backgroundColor=RGB(246, 246, 246);
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.tag=1234;
    scroll.delegate=self;
    [YouXuanView addSubview:scroll];

    UIImageView *ChaoliuIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(20)-10, 100, 30)];
    [ChaoliuIV setImage:KImage(@"xlhome-r4")];
    [YouXuanView addSubview:ChaoliuIV];

    UILabel * chaoliulab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    chaoliulab.font=KNSFONT(17);
    chaoliulab.textColor=RGB(255, 255, 255);
    chaoliulab.text=@"优选清单";
    chaoliulab.textAlignment=NSTextAlignmentRight;
    [ChaoliuIV addSubview:chaoliulab];

    for (int i=0; i<_JXlist.count; i++) {
        HomeModel *model=_JXlist[i];
        UIImageView *DPIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(10)+(Width(10)+Width(250))*i, Height(20) , Width(250), Width(124))];
        [DPIV sd_setImageWithURL:KNSURL(model.picpath) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [scroll addSubview:DPIV];
        DPIV.userInteractionEnabled=YES;

        UIButton *DPBut=[UIButton buttonWithType:UIButtonTypeCustom];
        DPBut.frame=DPIV.bounds;
        DPBut.tag=250+i;
        [DPBut addTarget:self action:@selector(YXBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [DPIV addSubview:DPBut];

        UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, Width(94), Width(250), Width(30))];
        backView.backgroundColor=RGBA(0, 0, 0,0.5);
        [DPIV addSubview:backView];

        UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width(230), Width(30))];
        nameLab.font=KNSFONT(17);
        nameLab.textColor=[UIColor whiteColor];
        nameLab.text=[NSString stringWithFormat:@"  %@",model.title];
        [backView addSubview:nameLab];
    }
    scroll.contentSize=CGSizeMake(Width(10)+Width(260)*_JXlist.count, Width(124));

    UIButton *moreBut=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBut.frame=CGRectMake(0, Height(30)+Width(124), kScreenWidth, 40);
    [moreBut setBackgroundColor:[UIColor whiteColor]];
    [moreBut setTitle:@"更多清单" forState:UIControlStateNormal];
    moreBut.titleLabel.font=KNSFONT(15);
    NSString * str=@"更多清单";
    UIImageView *IV=[[UIImageView alloc] init];
    CGSize size=[str sizeWithFont:KNSFONT(15) maxSize:kScreenSize];
    [IV setFrame:CGRectMake((kScreenWidth-size.width)/2+size.width+5, (40-13.5)/2, 8, 13)];
    [IV setImage:KImage(@"icon_more_jiadian")];
    [moreBut addSubview:IV];

    [moreBut addTarget:self action:@selector(moreYXBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [moreBut setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [YouXuanView addSubview:moreBut];

}
-(void)YXBtnClick:(UIButton *)sender
{
    HomeModel *model=_JXlist[sender.tag-250];
    JXSelectDetailViewController *vc = [[JXSelectDetailViewController alloc] init];

    vc.ID = model.ID;
    vc.Back = @"100";
    [self.viewController.navigationController pushViewController:vc animated:NO];
    self.viewController.tabBarController.tabBar.hidden=YES;
}

-(void)moreYXBtnClick
{

    JXSelectViewController *vc=[[JXSelectViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:NO];
    self.viewController.navigationController.navigationBar.hidden=YES;
    self.viewController.tabBarController.tabBar.hidden=YES;

}

-(void)setDaPaiSugView
{

    if (_DPArrM.count==0) {
        [DaPaiView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        DaPaiView=nil;
        return;
    }else
    {
        [DaPaiView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }

    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Height(30)+Width(124))];
    scroll.backgroundColor=RGB(246, 246, 246);
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.tag=1234;
    scroll.delegate=self;
    scroll.userInteractionEnabled=YES;
    [DaPaiView addSubview:scroll];

    UIImageView *ChaoliuIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(20)-10, 100, 30)];
    [ChaoliuIV setImage:KImage(@"xlhome-r3")];
    [DaPaiView addSubview:ChaoliuIV];

    UILabel * chaoliulab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    chaoliulab.font=KNSFONT(17);
    chaoliulab.textColor=RGB(255, 255, 255);
    chaoliulab.text=@"大牌推荐";
    chaoliulab.textAlignment=NSTextAlignmentRight;
    [ChaoliuIV addSubview:chaoliulab];

    for (int i=0; i<_DPArrM.count; i++) {
        HomeDPModel*model=_DPArrM[i];
        UIImageView *DPIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(10)+(Width(10)+Width(250))*i, Height(20) , Width(250), Width(124))];
        [DPIV sd_setImageWithURL:KNSURL(model.picpath) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [scroll addSubview:DPIV];
        DPIV.userInteractionEnabled=YES;

        UIButton *DPBut=[UIButton buttonWithType:UIButtonTypeCustom];
        DPBut.frame=DPIV.bounds;
        [DPBut addTarget:self action:@selector(DPBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        DPBut.tag=200+i;
        [DPIV addSubview:DPBut];
    }
    scroll.contentSize=CGSizeMake(Width(10)+Width(260)*5, Width(124));
    UIButton *moreBut=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBut.frame=CGRectMake(0, Height(30)+Width(124), kScreenWidth, 40);
    [moreBut setBackgroundColor:[UIColor whiteColor]];
    [moreBut setTitle:@"更多品牌" forState:UIControlStateNormal];
    moreBut.titleLabel.font=KNSFONT(15);
    NSString * str=@"更多品牌";
    UIImageView *IV=[[UIImageView alloc] init];
    CGSize size=[str sizeWithFont:KNSFONT(15) maxSize:kScreenSize];
    [IV setFrame:CGRectMake((kScreenWidth-size.width)/2+size.width+5, (40-13.5)/2, 8, 13)];
    [IV setImage:KImage(@"icon_more_jiadian")];
    [moreBut addSubview:IV];

    [moreBut addTarget:self action:@selector(moreDPBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [moreBut setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [DaPaiView addSubview:moreBut];

    [DaPaiView setNeedsLayout];

}

-(void)DPBtnClick:(UIButton *)sender
{
    HomeDPModel *model=_DPArrM[sender.tag-200];
    DPCommandDetailViewController *VC=[[DPCommandDetailViewController alloc] init];
    VC.Title=model.cream_name;
    VC.ID=model.ID;
    VC.hidesBottomBarWhenPushed=YES;
    [self.viewController.navigationController pushViewController:VC animated:NO];
}

-(void)moreDPBtnClick
{
    HomeDaiPaiSuggestListVC *VC=[[HomeDaiPaiSuggestListVC alloc] init];
    VC.hidesBottomBarWhenPushed=YES;
    [self.viewController.navigationController pushViewController:VC animated:NO];

}

-(void)setjikeView
{

    if ([_jikeStr isEqualToString:@""]) {
        [JiKeView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        JiKeView=nil;
        return;
    }else
    {
        [JiKeView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }


    [JiKeView sd_setImageWithURL:KNSURL(_picstr) placeholderImage:KImage(@"default_image")];

    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(Width(88), Width(53), Width(200), Width(60))];
    backView.backgroundColor=RGBA(0, 0, 0,0.5);
    [JiKeView addSubview:backView];

    UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(0, Width(10), Width(200), Width(20))];
    nameLab.font=KNSFONT(17);
    nameLab.textColor=[UIColor whiteColor];
    nameLab.text=_jikeStr;
    nameLab.textAlignment=NSTextAlignmentCenter;
    [backView addSubview:nameLab];

    UILabel *nameLab2=[[UILabel alloc] initWithFrame:CGRectMake(0, Width(31), Width(200), Width(17))];
    nameLab2.font=KNSFONT(12);
    nameLab2.textColor=[UIColor whiteColor];
    nameLab2.text=_jikeSubStr;
    nameLab2.textAlignment=NSTextAlignmentCenter;
    [backView addSubview:nameLab2];
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    [but setFrame:JiKeView.bounds];
    [but addTarget:self
            action:@selector(jikeButClick:) forControlEvents:UIControlEventTouchUpInside];
    JiKeView.userInteractionEnabled=YES;
    [JiKeView addSubview:but];

}

-(void)jikeButClick:(UIButton *)sender
{

    HomeGeekGoodsListVC *VC=[[HomeGeekGoodsListVC alloc] init];
    VC.naviTitle=_jikeStr;
    VC.hidesBottomBarWhenPushed=YES;
    [self.viewController.navigationController pushViewController:VC animated:NO];
}

-(void)setChaoLiuView
{

    if (_list4.count==0) {
        [ChaoliuView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        ChaoliuView=nil;
        return;
    }else
    {
        [ChaoliuView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }

    AllSingleShoppingModel *model1=_list4[0];

    UIImageView *IV1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width(250), Width(124))];
    [IV1 sd_setImageWithURL:KNSURL(model1.path) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
    IV1.userInteractionEnabled=YES;
    [ChaoliuView addSubview:IV1];

    UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, Width(94), Width(250), Width(30))];
    lab1.font=KNSFONT(14);
    lab1.textColor=[UIColor whiteColor];
    lab1.backgroundColor=RGBA(0, 0, 0, 0.4);
    lab1.text=[NSString stringWithFormat:@"  %@",model1.main_title];
    [IV1 addSubview:lab1];

    UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame=IV1.bounds;
    but1.tag=298;
    [but1 addTarget:self action:@selector(chaoliuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [IV1 addSubview:but1];

    AllSingleShoppingModel *model2=_list4[1];
    UIImageView *IV2=[[UIImageView alloc] initWithFrame:CGRectMake(Width(251), 0, Width(124), Width(124))];
    [IV2 sd_setImageWithURL:KNSURL(model2.path) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
    [ChaoliuView addSubview:IV2];

    UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, Width(94), Width(124), Width(30))];
    lab2.font=KNSFONT(14);
    lab2.textColor=[UIColor whiteColor];
    lab2.backgroundColor=RGBA(0, 0, 0, 0.4);
    lab2.text=[NSString stringWithFormat:@"  %@",model2.main_title];
    [IV2 addSubview:lab2];

    UIButton *but2=[UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame=IV2.bounds;
    IV2.userInteractionEnabled=YES;
    but2.tag=299;
    [but2 addTarget:self action:@selector(chaoliuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [IV2 addSubview:but2];

    UIImageView *ChaoliuIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 100, 30)];
    [ChaoliuIV setImage:KImage(@"xlhome-r2")];
    [ChaoliuView addSubview:ChaoliuIV];

    UILabel * chaoliulab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    chaoliulab.font=KNSFONT(17);
    chaoliulab.textColor=RGB(255, 255, 255);
    chaoliulab.text=@"潮流好货";
    chaoliulab.textAlignment=NSTextAlignmentRight;
    [ChaoliuIV addSubview:chaoliulab];

    for (int i=0; i<6; i++) {

        AllSingleShoppingModel *model=_list4[i+2];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake((i%3)*Width(125),Width(125)+(i/3)*Width(125),  Width(125), Width(125))];
        view.backgroundColor=(i%2==0)?RGB(250, 250, 250):[UIColor whiteColor];
        [ChaoliuView addSubview:view];

        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=view.bounds;
        but.tag=i+300;
        [but addTarget:self action:@selector(chaoliuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:but];


        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(10), Height(10), Width(105), 15)];
        lab.font=KNSFONT(15);
        lab.textColor=RGB(51, 51, 51);
        lab.text=model.main_title;
        [view addSubview:lab];

        UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(Width(10), Height(20)+15, Width(105), 12)];
        lab1.font=KNSFONT(12);
        lab1.textColor=RGB(155, 155, 155);
        lab1.text=model.subtitle;
        [view addSubview:lab1];

        UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake((Width(125)-80)/2.0, (Width(125)-60-Height(20)-15-12)/2.0+Height(20)+15+12, 80, 60)];
        [IV sd_setImageWithURL:KNSURL(model.path) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [view addSubview:IV];
    }




}

-(void)chaoliuBtnClick:(UIButton *)sender
{
    AllSingleShoppingModel *model=_list4[sender.tag-298];
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];

    vc.gid=model.gid;
    self.viewController.navigationController.navigationBar.hidden=YES;
    self.viewController.tabBarController.tabBar.hidden=YES;
    [self.viewController.navigationController pushViewController:vc animated:NO];
}

-(void)HQGButtonBtnClick:(UIButton *)sender
{

    NSLog(@"******");

    NSLog(@"=====%ld",(long)sender.tag);

    //    NSString *gid=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSString *attribute = @"";

    //  NSLog(@"====%@",gid);
    HomeModel *model=_list1[sender.tag];

    //            NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];


    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.good_type;
    //    vc.gid=gid;
    vc.gid=model.ID;
    vc.type=@"1";
    vc.attribute = attribute;
    //    vc.ID=gid;
    vc.ID=model.ID;
    YLog(@"id=%@,gid=%@",model.ID,model.gid);

    self.viewController.navigationController.navigationBar.hidden=YES;
    self.viewController.tabBarController.tabBar.hidden=YES;
    [self.viewController.navigationController pushViewController:vc animated:NO];

}

- (void)timeChange:(NSTimer *)timer
{
    static int num;
    num ++;
    if (num == _headerDatas.count) {
        num = 0;
    }

    if (num != 0) {
        [self.myScrollView setContentOffset:CGPointMake(num*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    } else {
        [self.myScrollView setContentOffset:CGPointZero];
    }
}
- (void)pageChange:(UIPageControl *)pageCtl
{

    NSInteger currentPage = pageCtl.currentPage;

    //-----------修改scrollView的页面-------------


    //移动点, 设置相对于原点的偏移量
    [self.myScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width*currentPage, 0) animated:YES];

}

//正在滚动中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //使用偏移量获取当前的页
    NSInteger currentPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;


    self.pageControl.currentPage = currentPage;

}

-(void)setHeaderDatas:(NSArray *)headerDatas
{
    _headerDatas = headerDatas;

    self.pageControl.numberOfPages = _headerDatas.count;
    //设置contentSize
    self.myScrollView.contentSize = CGSizeMake(headerDatas.count * [UIScreen mainScreen].bounds.size.width, 0);

    //先移除旧UI
    for (UIView *view1 in self.myScrollView.subviews) {
        [view1 removeFromSuperview];
    }

    //添加新UI
    //赋值
    for (int i=0; i<headerDatas.count; i++) {

        NSString *string = headerDatas[i];

        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, HHH)];
        //        [imgView sd_setImageWithURL:[NSURL URLWithString:string]];

        [imgView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        UITapGestureRecognizer *tapOne=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOne:)];

        imgView.tag=1+i;

        //设置点击的次数
        tapOne.numberOfTapsRequired = 1;
        //设置手指个数
        tapOne.numberOfTouchesRequired = 1;

        //将这个单击手势， 添加给imgView
        [imgView addGestureRecognizer:tapOne];

        [self.myScrollView addSubview:imgView];

        //将imgView的用户交互， 使能标志打开
        imgView.userInteractionEnabled = YES;

    }
}

-(void)setDataArrM:(NSArray *)dataArrM
{
    _dataArrM=dataArrM;

    //    NSLog(@"%ld",_dataArrM.count);

}
- (void)tapOne:(UITapGestureRecognizer *)tap
{
    UIImageView *imgView =  (UIImageView *)tap.view;

    //    NSLog(@"%ld",imgView.tag);

    for (int i=0; i<_dataArrM.count; i++) {

        if (i==imgView.tag-1) {
            NSString *gid=_dataArrM[i];
            NSString *attribute = _dataArrM2[i];

            NSLog(@"===huixianggou=%@",gid);


            //            NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];


            YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];

            vc.gid=gid;
            vc.type=@"1";
            vc.attribute = attribute;
            vc.ID=gid;
            self.viewController.navigationController.navigationBar.hidden=YES;
            self.viewController.tabBarController.tabBar.hidden=YES;
            [self.viewController.navigationController pushViewController:vc animated:NO];
        }

    }

}

-(void)dealloc
{
    [self.timer invalidate];
    [self.m_timer invalidate];
    self.timer=nil;
    self.m_timer=nil;
}


@end

