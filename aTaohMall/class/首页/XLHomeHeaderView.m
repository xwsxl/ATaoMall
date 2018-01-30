//
//  XLHomeHeaderView.m
//  aTaohMall
//
//  Created by Hawky on 2018/1/2.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLHomeHeaderView.h"

#import "HomeModel.h"

#import "YTScrolling.h"//图片轮番

#import "UIImageView+WebCache.m"

#import "NewGoodsDetailViewController.h"//商品详情

#import "YTGoodsDetailViewController.h"

#import "KTPageControl.h"

#import "HomeModel.h"

@interface XLHomeHeaderView()<UIScrollViewDelegate>

#define fHeight  [UIScreen mainScreen].bounds.size.height
#define fWidth    [UIScreen mainScreen].bounds.size.width
{
    
    UILabel *HourLabel;
    UILabel *MinLabel;
    UILabel *SecLabel;
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

    UILabel *HFName;
    UILabel *HFTitle;
    UIImageView *HFimgView;

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

    UIScrollView *MiaoScrollerView;

    UILabel *KCName;
    UIImageView *KCimgView;

    UILabel *GGName;
    UIImageView *GGimgView;

    UIImageView *OneimgView1;
    UIImageView *OneimgView2;
    UIImageView *OneimgView3;
    UIImageView *OneLogo;
    UILabel *OneName;
    UILabel *OneCount;

    UIImageView *TwoimgView1;
    UIImageView *TwoimgView2;
    UIImageView *TwoimgView3;
    UIImageView *TwoLogo;
    UILabel *TwoName;
    UILabel *TwoCount;

    UIImageView *ThreeimgView1;
    UIImageView *ThreeimgView2;
    UIImageView *ThreeimgView3;
    UIImageView *ThreeLogo;
    UILabel *ThreeName;
    UILabel *ThreeCount;

    UIImageView *FourimgView1;
    UIImageView *FourimgView2;
    UIImageView *FourimgView3;
    UIImageView *FourLogo;
    UILabel *FourName;
    UILabel *FourCount;

    UIView *MiaoQingView;

    CGFloat XLHHHHH;

    UIView *view;

    NSMutableArray *DataArrM;


    UIImageView *HuiWaiImg;
    UILabel *HuiWaiLabel;
}
@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@property (nonatomic, strong) NSTimer        *m_timer; //定时器

@property (strong,nonatomic) KTPageControl *pageControl;
@end

NSInteger  XLHuiqiangGouHeight=60;
CGFloat XLHHH;
@implementation XLHomeHeaderView

#define fHeight  [UIScreen mainScreen].bounds.size.height
#define fWidth    [UIScreen mainScreen].bounds.size.width


-(void)setIsShowHQG:(NSString *)isShowHQG  isShowBigHeathy:(NSString *)isShowBigHeathy isShowHomeLittile:(BOOL)isShow
{
    _isShowHQG=isShowHQG;
    _isShowBigHeathy=isShowBigHeathy;
    _isShowHomeLittile=isShow;

    if (isShow||[isShowHQG isEqualToString:@"0"]) {
        XLHuiqiangGouHeight=80;
    }else
    {
        XLHuiqiangGouHeight=-134;
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self loadMyCell];
    self.list1=_list1;
    self.list2=_list2;
    self.JXlist=_JXlist;
    self.HDlist=_HDlist;



}


-(void)setIsShowHQG:(NSString *)isShowHQG
{
    _isShowHQG=isShowHQG;

}

-(void)setIsShowBigHeathy:(NSString *)isShowBigHeathy
{
    _isShowBigHeathy=isShowBigHeathy;
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

-(void)setList1:(NSArray *)list1
{
    _list1 = list1;
    NSLog(@"===惠抢购数据===%ld==DataArrM==%ld",(long)_list1.count,(long)DataArrM.count);
    for (UIView *view1 in MiaoScrollerView.subviews) {
        [view1 removeFromSuperview];
    }
    MiaoScrollerView.contentSize = CGSizeMake((XLHuiqiangGouHeight+5.5)*_list1.count+9.5, 94+XLHuiqiangGouHeight-36.5);
    for (int i =0; i < _list1.count; i++) {
        HomeModel *model = _list1[i];
        view = [[UIView alloc] initWithFrame:CGRectMake(XLHuiqiangGouHeight*i+9.5+5.5*i, 0, XLHuiqiangGouHeight, XLHuiqiangGouHeight+94-36.5)];
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
        UILabel *Price = [[UILabel alloc] initWithFrame:CGRectMake(0, XLHuiqiangGouHeight+11, XLHuiqiangGouHeight, 40)];
        Price.text = [NSString stringWithFormat:@"￥%@\n+%@积分",model.pay_maney,model.pay_integer];
        Price.textAlignment = NSTextAlignmentCenter;
        Price.tag = 70+i;
        Price.numberOfLines=2;
        Price.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        Price.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [view addSubview:Price];

        UILabel *Count = [[UILabel alloc] initWithFrame:CGRectMake(0, XLHuiqiangGouHeight+51+10, XLHuiqiangGouHeight, 12.5)];
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


        NSLog(@"");



        self.HQGButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.HQGButton.frame = CGRectMake(0, 0, 80, 234-36.5);
        self.HQGButton.tag = [model.ID integerValue];
        self.HQGButton.tag = i;
        self.HQGButton.userInteractionEnabled=YES;
        [self.HQGButton addTarget:self action:@selector(HQGButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.HQGButton];


    }

}

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



-(void)setJXlist:(NSArray *)JXlist
{

    NSLog(@"===%ld",_JXlist.count);

    _JXlist = JXlist;
    for (int i =0; i < _JXlist.count; i++) {

        HomeModel *model = _JXlist[i];

        if (i==0) {

            KCName.text = model.title;
            self.KCButton.tag = [model.ID integerValue];

            [KCimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        }else if (i==1){

            GGName.text = model.title;
            self.GGButton.tag = [model.ID integerValue];

            [GGimgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        }
    }
}

-(void)setHDlist:(NSArray *)HDlist
{

    _HDlist = HDlist;
    for (int i =0; i < _HDlist.count; i++) {
        HomeModel *model = _HDlist[i];
        if (i==0) {

            OneName.text = model.storename;
            OneCount.text = [NSString stringWithFormat:@"%@人已逛",model.click_volume];
            self.OneButton.tag = [model.mid integerValue];
            [OneLogo sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

            for (int j =0; j < model.array.count; j++) {
                NSDictionary *dict = model.array[j];

                NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];
                NSLog(@"%@",str);



                if (j==0) {

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [OneimgView1 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

                }else if (j == 1){

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [OneimgView2 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }else if (j == 2){

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [OneimgView3 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }
            }

        }else if (i==1){

            TwoName.text = model.storename;
            TwoCount.text = [NSString stringWithFormat:@"%@人已逛",model.click_volume];
            self.TwoButton.tag = [model.mid integerValue];
            [TwoLogo sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

            for (int j =0; j < model.array.count; j++) {

                if (j==0) {

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [TwoimgView1 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }else if (j == 1){

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [TwoimgView2 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }else if (j == 2){

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [TwoimgView3 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }
            }

        }else if (i==2){

            ThreeName.text = model.storename;
            ThreeCount.text = [NSString stringWithFormat:@"%@人已逛",model.click_volume];
            self.ThreeButton.tag = [model.mid integerValue];
            [ThreeLogo sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

            for (int j =0; j < model.array.count; j++) {
                NSDictionary *dict = model.array[j];

                NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];
                NSLog(@"%@",str);
                if (j==0) {

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [ThreeimgView1 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }else if (j == 1){

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [ThreeimgView2 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }else if (j == 2){

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [ThreeimgView3 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }
            }
        }else if (i==3){

            FourName.text = model.storename;
            FourCount.text = [NSString stringWithFormat:@"%@人已逛",model.click_volume];
            self.FourButton.tag = [model.mid integerValue];
            [FourLogo sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

            for (int j =0; j < model.array.count; j++) {

                if (j==0) {

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];
                    [FourimgView1 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }else if (j == 1){

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [FourimgView2 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }else if (j == 2){

                    NSDictionary *dict = model.array[j];

                    NSString *str = [NSString stringWithFormat:@"%@",dict[@"scopeimg"] ];

                    [FourimgView3 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                }
            }
        }
    }
}



-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
         [self loadMyCell];
    }
    return self;
}


- (KTPageControl *)pageControl
{
    if (_pageControl == nil) {

        _pageControl = [[KTPageControl alloc] init];

        if ([UIScreen mainScreen].bounds.size.width > 320) {

            _pageControl.frame =CGRectMake(self.frame.size.width+100, XLHHH-20, 40, 7);

        }else{

            _pageControl.frame =CGRectMake(self.frame.size.width+50, XLHHH-20, 40, 7);

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
    XLHHH=([UIScreen mainScreen].bounds.size.width)*310/750;

    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, shiftHeight, [UIScreen mainScreen].bounds.size.width, XLHHH)];
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

    UIImageView *JiFenImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 15, 50, 50)];
    JiFenImg.image = [UIImage imageNamed:@"xlhome-icon-oversea"];
    [JiFenVew addSubview:JiFenImg];

    UILabel *JiFenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Height(13)+50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    JiFenLabel.text = @"海外购物佳";
    JiFenLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    JiFenLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JiFenLabel.textAlignment=NSTextAlignmentCenter;
    [JiFenVew addSubview:JiFenLabel];


    //小家电
    UIView *JiFenVew1 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*2, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.scoreStoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.scoreStoreButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [JiFenVew addSubview:self.scoreStoreButton];

    [self.headerButView addSubview:JiFenVew1];

    UIImageView *JiFenImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 15, 50, 50)];
    JiFenImg.image = [UIImage imageNamed:@"xlhome-icon-Appliances"];
    [JiFenVew1 addSubview:JiFenImg1];

    UILabel *JiFenLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, Height(13)+50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    JiFenLabel.text = @"小家电专场";
    JiFenLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    JiFenLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JiFenLabel.textAlignment=NSTextAlignmentCenter;
    [JiFenVew1 addSubview:JiFenLabel1];
    

    /*
     第二行
     */
    UIView *PhoneVew = [[UIView alloc] initWithFrame:CGRectMake(0, Height(13)+Height(5)+12+50+Height(10), [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];

    //    PhoneVew.backgroundColor=[UIColor orangeColor];

    self.PhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.PhoneButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [PhoneVew addSubview:self.PhoneButton];

    [self.headerButView addSubview:PhoneVew];

    UIImageView *PhoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 0, 50, 50)];
    PhoneImg.image = [UIImage imageNamed:@"交通出行111"];
    [PhoneVew addSubview:PhoneImg];

    UILabel *PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    PhoneLabel.text = @"交通出行";
    PhoneLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    PhoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PhoneLabel.textAlignment=NSTextAlignmentCenter;
    [PhoneVew addSubview:PhoneLabel];


    UIView *FlowVew = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50+Height(10), [UIScreen mainScreen].bounds.size.width/3, Height(13)+Height(5)+12+50)];
    self.FlowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.FlowButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [FlowVew addSubview:self.FlowButton];

    [self.headerButView addSubview:FlowVew];

    UIImageView *FlowImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 0, 50, 50)];
    FlowImg.image = [UIImage imageNamed:@"流量充值"];
    [FlowVew addSubview:FlowImg];

    UILabel *FlowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 20)];
    FlowLabel.text = @"充值中心";
    FlowLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    FlowLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    FlowLabel.textAlignment=NSTextAlignmentCenter;
    [FlowVew addSubview:FlowLabel];



    UIView *GameVew = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*2, Height(13)+Height(5)+12+50+Height(10), [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50)];
    self.GameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.GameButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, Height(13)+Height(5)+12+50);
    [GameVew addSubview:self.GameButton];

    [self.headerButView addSubview:GameVew];

    UIImageView *GameImg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-50)/2, 0, 50, 50)];
    GameImg.image = [UIImage imageNamed:@"查违章111"];
    [GameVew addSubview:GameImg];

    UILabel *GameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50+Height(5), [UIScreen mainScreen].bounds.size.width/4, 12)];
    GameLabel.text = @"违章缴费";
    GameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    GameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GameLabel.textAlignment=NSTextAlignmentCenter;
    [GameVew addSubview:GameLabel];


    



    UIView *BgView = [[UIView alloc] initWithFrame:CGRectMake(0, 365-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 10)];
    BgView.backgroundColor  =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self.headerButView addSubview:BgView];

    UIImageView *BgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    BgLine.image = [UIImage imageNamed:@"fengexian"];
    [BgView addSubview:BgLine];


    if (MiaoQingView) {
        [MiaoQingView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        MiaoQingView=nil;
    }
    MiaoQingView = [[UIView alloc] initWithFrame:CGRectMake(0, 375-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 0)];
    //    MiaoQingView = [[UIView alloc] init];
    MiaoQingView.backgroundColor = [UIColor whiteColor];
    [self addSubview:MiaoQingView];

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


    }

    MiaoScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36.5, [UIScreen mainScreen].bounds.size.width, 204-36.5)];
    //    MiaoScrollerView.contentSize = CGSizeMake(85.5*_list1.count+9.5, 174-36.5);
    MiaoScrollerView.showsHorizontalScrollIndicator = NO;
    MiaoScrollerView.showsVerticalScrollIndicator = NO;
    [MiaoQingView addSubview:MiaoScrollerView];


    UIView *BgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 6)];
    BgView1.backgroundColor  =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self addSubview:BgView1];

    UIImageView *BgLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    BgLine1.image = [UIImage imageNamed:@"fengexian"];
    [BgView1 addSubview:BgLine1];


    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 230)];
    selectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:selectView];

    UIView *ZXView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 155, 230)];
    ZXView.backgroundColor = [UIColor whiteColor];
    [selectView addSubview:ZXView];

    UIImageView *ZXimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(23.5, 30.5, 16, 16)];
    ZXimgView1.image = [UIImage imageNamed:@"职位优选"];
    [ZXView addSubview:ZXimgView1];

    ZXName = [[UILabel alloc] initWithFrame:CGRectMake(44.5, 31.5, 155-44.5, 14)];
    //    ZXName.text = @"为你甄选";
    ZXName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ZXName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [ZXView addSubview:ZXName];

    // 创建渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];

    gradientLayer.frame = ZXName.frame;

    gradientLayer.colors = @[(id)[UIColor colorWithRed:52/255.0 green:128/255.0 blue:255/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:157/255.0 green:94/255.0 blue:252/255.0 alpha:1.0].CGColor];

    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);

    [ZXView.layer addSublayer:gradientLayer];

    gradientLayer.mask = ZXName.layer;

    ZXName.frame = gradientLayer.bounds;


    ZXTitle = [[UILabel alloc] initWithFrame:CGRectMake(23.5, 51, 155-23.5, 12.5)];
    //    ZXTitle.text = @"专属你的购物指南";
    ZXTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ZXTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [ZXView addSubview:ZXTitle];

    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];

    gradientLayer1.frame = ZXTitle.frame;

    gradientLayer1.colors = @[(id)[UIColor colorWithRed:52/255.0 green:128/255.0 blue:255/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:157/255.0 green:94/255.0 blue:252/255.0 alpha:1.0].CGColor];

    gradientLayer1.locations = @[@0.0, @1.0];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1.0, 0.0);

    [ZXView.layer addSublayer:gradientLayer1];

    gradientLayer1.mask = ZXTitle.layer;

    ZXTitle.frame = gradientLayer1.bounds;

    ZXimgView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 82.5, 104, 117)];
    ZXimgView.image = [UIImage imageNamed:@""];
    [ZXView addSubview:ZXimgView];

    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(154, 0, 1, 230)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [ZXView addSubview:line1];

    self.ZXButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ZXButton.frame = CGRectMake(0, 0, 155, 230);
    [ZXView addSubview:self.ZXButton];

    UIView *DPView = [[UIView alloc] initWithFrame:CGRectMake(155, 0, [UIScreen mainScreen].bounds.size.width-155, 115)];
    DPView.backgroundColor = [UIColor whiteColor];
    [selectView addSubview:DPView];

    self.DPButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.DPButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-155, 115);
    [DPView addSubview:self.DPButton];

    DPName = [[UILabel alloc] initWithFrame:CGRectMake(9.5, 30, 100, 12)];
    //    DPName.text = @"大牌推荐";
    DPName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    DPName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [DPView addSubview:DPName];

    CAGradientLayer *gradientLayer3 = [CAGradientLayer layer];

    gradientLayer3.frame = DPName.frame;

    gradientLayer3.colors = @[(id)[UIColor colorWithRed:52/255.0 green:128/255.0 blue:255/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:233/255.0 green:50/255.0 blue:255/255.0 alpha:1.0].CGColor];

    gradientLayer3.locations = @[@0.0, @1.0];
    gradientLayer3.startPoint = CGPointMake(0, 0);
    gradientLayer3.endPoint = CGPointMake(1.0, 0.0);

    [DPView.layer addSublayer:gradientLayer3];

    gradientLayer3.mask = DPName.layer;

    DPName.frame = gradientLayer3.bounds;

    DPTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 51.5, 100, 11.5)];
    //    DPTitle.text = @"时尚生活我来推荐";
    DPTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    DPTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [DPView addSubview:DPTitle];

    CAGradientLayer *gradientLayer4 = [CAGradientLayer layer];

    gradientLayer4.frame = DPTitle.frame;

    gradientLayer4.colors = @[(id)[UIColor colorWithRed:52/255.0 green:128/255.0 blue:255/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:233/255.0 green:50/255.0 blue:255/255.0 alpha:1.0].CGColor];

    gradientLayer4.locations = @[@0.0, @1.0];
    gradientLayer4.startPoint = CGPointMake(0, 0);
    gradientLayer4.endPoint = CGPointMake(1.0, 0.0);

    [DPView.layer addSublayer:gradientLayer4];

    gradientLayer4.mask = DPTitle.layer;

    DPTitle.frame = gradientLayer4.bounds;

    DPimgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-155-65.5-29, 16.5, 65.5, 82)];
    DPimgView.image = [UIImage imageNamed:@""];
    [DPView addSubview:DPimgView];

    UIImageView *DPline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 114, [UIScreen mainScreen].bounds.size.width-155, 1)];
    DPline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [DPView addSubview:DPline1];


    UIView *JDView = [[UIView alloc] initWithFrame:CGRectMake(155, 115, ([UIScreen mainScreen].bounds.size.width-155)/2, 115)];
    JDView.backgroundColor = [UIColor whiteColor];
    [selectView addSubview:JDView];

    self.JDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.JDButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-155)/2, 115);
    [JDView addSubview:self.JDButton];

    JDName = [[UILabel alloc] initWithFrame:CGRectMake(12.5, 9.5, ([UIScreen mainScreen].bounds.size.width-155)/2-12.5, 12.5)];
    //    JDName.text = @"家电馆";
    JDName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JDName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [JDView addSubview:JDName];

    CAGradientLayer *gradientLayer5 = [CAGradientLayer layer];

    gradientLayer5.frame = JDName.frame;

    gradientLayer5.colors = @[(id)[UIColor colorWithRed:155/255.0 green:102/255.0 blue:251/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:211/255.0 green:48/255.0 blue:198/255.0 alpha:1.0].CGColor];

    gradientLayer5.locations = @[@0.0, @1.0];
    gradientLayer5.startPoint = CGPointMake(0, 0);
    gradientLayer5.endPoint = CGPointMake(1.0, 0.0);

    [JDView.layer addSublayer:gradientLayer5];

    gradientLayer5.mask = JDName.layer;

    JDName.frame = gradientLayer5.bounds;

    JDTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 31.5, ([UIScreen mainScreen].bounds.size.width-155)/2-12, 11.5)];
    //    JDTitle.text = @"舒适便捷好生活";
    JDTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JDTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [JDView addSubview:JDTitle];

    CAGradientLayer *gradientLayer6 = [CAGradientLayer layer];

    gradientLayer6.frame = JDTitle.frame;

    gradientLayer6.colors = @[(id)[UIColor colorWithRed:155/255.0 green:102/255.0 blue:251/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:211/255.0 green:48/255.0 blue:198/255.0 alpha:1.0].CGColor];

    gradientLayer6.locations = @[@0.0, @1.0];
    gradientLayer6.startPoint = CGPointMake(0, 0);
    gradientLayer6.endPoint = CGPointMake(1.0, 0.0);

    [JDView.layer addSublayer:gradientLayer6];

    gradientLayer6.mask = JDTitle.layer;

    JDTitle.frame = gradientLayer6.bounds;

    JDimgView = [[UIImageView alloc] initWithFrame:CGRectMake((([UIScreen mainScreen].bounds.size.width-155)/2-62)/2, 52.5, 62, 50)];
    JDimgView.image = [UIImage imageNamed:@""];
    [JDView addSubview:JDimgView];

    UIImageView *JDline1 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-155)/2-1, 0, 1, 115)];
    JDline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [JDView addSubview:JDline1];

    UIView *MWView = [[UIView alloc] initWithFrame:CGRectMake(155+([UIScreen mainScreen].bounds.size.width-155)/2, 115, ([UIScreen mainScreen].bounds.size.width-155)/2, 115)];
    MWView.backgroundColor = [UIColor whiteColor];
    [selectView addSubview:MWView];

    self.MWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.MWButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-155)/2, 115);
    [MWView addSubview:self.MWButton];

    MWName = [[UILabel alloc] initWithFrame:CGRectMake(24.5, 10, ([UIScreen mainScreen].bounds.size.width-155)/2-24.5, 12)];
    //    MWName.text = @"美味惠吃";
    MWName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    MWName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [MWView addSubview:MWName];

    CAGradientLayer *gradientLayer7 = [CAGradientLayer layer];
    gradientLayer7.frame = MWName.frame;
    gradientLayer7.colors = @[(id)[UIColor colorWithRed:155/255.0 green:102/255.0 blue:251/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:48/255.0 green:211/255.0 blue:209/255.0 alpha:1.0].CGColor];
    gradientLayer7.locations = @[@0.0, @1.0];
    gradientLayer7.startPoint = CGPointMake(0, 0);
    gradientLayer7.endPoint = CGPointMake(1.0, 0.0);
    [MWView.layer addSublayer:gradientLayer7];
    gradientLayer7.mask = MWName.layer;
    MWName.frame = gradientLayer7.bounds;


    MWTitle = [[UILabel alloc] initWithFrame:CGRectMake(24.5, 31.5, ([UIScreen mainScreen].bounds.size.width-155)/2-24.5, 11.5)];
    //    MWTitle.text = @"吃货的后裔";
    MWTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    MWTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [MWView addSubview:MWTitle];

    CAGradientLayer *gradientLayer8 = [CAGradientLayer layer];
    gradientLayer8.frame = MWTitle.frame;
    gradientLayer8.colors = @[(id)[UIColor colorWithRed:155/255.0 green:102/255.0 blue:251/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:48/255.0 green:211/255.0 blue:209/255.0 alpha:1.0].CGColor];
    gradientLayer8.locations = @[@0.0, @1.0];
    gradientLayer8.startPoint = CGPointMake(0, 0);
    gradientLayer8.endPoint = CGPointMake(1.0, 0.0);
    [MWView.layer addSublayer:gradientLayer8];
    gradientLayer8.mask = MWTitle.layer;
    MWTitle.frame = gradientLayer8.bounds;

    MWimgView = [[UIImageView alloc] initWithFrame:CGRectMake((([UIScreen mainScreen].bounds.size.width-155)/2-62)/2, 52.5, 62, 50)];
    //    MWimgView.image = [UIImage imageNamed:@""];
    [MWView addSubview:MWimgView];

    UIImageView *line11 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+230-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 1)];
    line11.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:line11];

    UIView *TSView = [[UIView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+231-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 35)];
    TSView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self addSubview:TSView];

    UIImageView *TSName = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-289/2)/2, 0, 289/2, 44)];
    TSName.image  =[UIImage imageNamed:@"渐变球"];
    [TSView addSubview:TSName];

    UIView *TSSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+231+35-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 250)];
    TSSelectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:TSSelectView];

    UIView *HFView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 125)];
    HFView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:HFView];

    self.HFButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.HFButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 125);
    [HFView addSubview:self.HFButton];

    HFName = [[UILabel alloc] initWithFrame:CGRectMake(26.5, 15, [UIScreen mainScreen].bounds.size.width/2-26.5, 12.5)];
    //    HFName.text = @"护肤美妆";
    HFName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    HFName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [HFView addSubview:HFName];

    HFTitle = [[UILabel alloc] initWithFrame:CGRectMake(27, 37, [UIScreen mainScreen].bounds.size.width/2-27, 12)];
    //    HFTitle.text = @"五月不美白，六月晒成碳";
    HFTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    HFTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [HFView addSubview:HFTitle];

    HFimgView = [[UIImageView alloc] initWithFrame:CGRectMake(26.5, 63.5, [UIScreen mainScreen].bounds.size.width/2-26.5*2, 50)];
    HFimgView.image = [UIImage imageNamed:@""];
    [HFView addSubview:HFimgView];

    //    UIImageView *HFimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-62-26, 63.5, 62, 50)];
    

    UIImageView *HFline1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-1, 0, 1, 125)];
    HFline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [HFView addSubview:HFline1];

    UIImageView *HFline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 124, [UIScreen mainScreen].bounds.size.width/2, 1)];
    HFline2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [HFView addSubview:HFline2];


    UIView *FZView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 125)];
    FZView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:FZView];

    self.FZButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.FZButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 125);
    [FZView addSubview:self.FZButton];

    FZName = [[UILabel alloc] initWithFrame:CGRectMake(25.5, 15, [UIScreen mainScreen].bounds.size.width/2-25.5, 12.5)];
    //    FZName.text = @"服装箱包";
    FZName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    FZName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [FZView addSubview:FZName];

    FZTitle = [[UILabel alloc] initWithFrame:CGRectMake(26, 37, [UIScreen mainScreen].bounds.size.width/2-26, 11.5)];
    //    FZTitle.text = @"搭配属于你的时尚";
    FZTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    FZTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [FZView addSubview:FZTitle];

    FZimgView = [[UIImageView alloc] initWithFrame:CGRectMake(26, 63.5, [UIScreen mainScreen].bounds.size.width/2-52, 50)];
    FZimgView.image = [UIImage imageNamed:@""];
    [FZView addSubview:FZimgView];

    //    UIImageView *FZimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-62-26, 63.5, 62, 50)];
    //    FZimgView1.image = [UIImage imageNamed:@""];
    //    [FZView addSubview:FZimgView1];

    UIImageView *FZline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 124, [UIScreen mainScreen].bounds.size.width/2, 1)];
    FZline2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [FZView addSubview:FZline2];

    UIView *JJView = [[UIView alloc] initWithFrame:CGRectMake(0, 125, [UIScreen mainScreen].bounds.size.width/4, 125)];
    JJView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:JJView];

    self.JJButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.JJButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4, 125);
    [JJView addSubview:self.JJButton];

    JJName = [[UILabel alloc] initWithFrame:CGRectMake(16.5, 9.5, [UIScreen mainScreen].bounds.size.width/4-16.5, 12.5)];
    //    JJName.text = @"居家生活";
    JJName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JJName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [JJView addSubview:JJName];

    JJTitle = [[UILabel alloc] initWithFrame:CGRectMake(16.5, 31.5, [UIScreen mainScreen].bounds.size.width/4-16.5, 11.5)];
    //    JJTitle.text = @"造有品的家";
    JJTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    JJTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [JJView addSubview:JJTitle];

    JJimgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-62)/2, 58.5, 62, 50)];
    JJimgView.image = [UIImage imageNamed:@""];
    [JJView addSubview:JJimgView];

    UIImageView *JJline1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-1, 0, 1, 125)];
    JJline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [JJView addSubview:JJline1];

    UIView *GJView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4, 125, [UIScreen mainScreen].bounds.size.width/4, 125)];
    GJView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:GJView];

    self.GJButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.GJButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 125);
    [GJView addSubview:self.GJButton];

    GJName = [[UILabel alloc] initWithFrame:CGRectMake(16, 9.5, [UIScreen mainScreen].bounds.size.width/4-16, 12.5)];
    //    GJName.text = @"搞机派";
    GJName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GJName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [GJView addSubview:GJName];

    GJTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 31.5, [UIScreen mainScreen].bounds.size.width/4-16, 11.5)];
    //    GJTitle.text = @"数码发烧友";
    GJTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GJTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [GJView addSubview:GJTitle];

    GJimgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-62)/2, 58.5, 62, 50)];
    GJimgView.image = [UIImage imageNamed:@""];
    [GJView addSubview:GJimgView];

    UIImageView *GJline1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-1, 0, 1, 125)];
    GJline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [GJView addSubview:GJline1];

    UIView *BBView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*2, 125, [UIScreen mainScreen].bounds.size.width/4, 125)];
    BBView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:BBView];

    self.BBButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.BBButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 125);
    [BBView addSubview:self.BBButton];

    BBName = [[UILabel alloc] initWithFrame:CGRectMake(16, 9.5, [UIScreen mainScreen].bounds.size.width/4-16, 12.5)];
    //    BBName.text = @"亲宝贝";
    BBName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    BBName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [BBView addSubview:BBName];

    BBTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 31.5, [UIScreen mainScreen].bounds.size.width/4-16, 11.5)];
    //    BBTitle.text = @"花钱少养好娃";
    BBTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    BBTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [BBView addSubview:BBTitle];

    BBimgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-62)/2, 58.5, 62, 50)];
    //    BBimgView.image = [UIImage imageNamed:@""];
    [BBView addSubview:BBimgView];

    UIImageView *BBline1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4-1, 0, 1, 125)];
    BBline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [BBView addSubview:BBline1];

    UIView *HWView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4*3, 125, [UIScreen mainScreen].bounds.size.width/4, 125)];
    HWView.backgroundColor = [UIColor whiteColor];
    [TSSelectView addSubview:HWView];

    self.HWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.HWButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 125);
    [HWView addSubview:self.HWButton];

    HWName = [[UILabel alloc] initWithFrame:CGRectMake(16, 9.5, [UIScreen mainScreen].bounds.size.width/4-16, 12.5)];
    //    HWName.text = @"户外运动";
    HWName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    HWName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [HWView addSubview:HWName];

    HWTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 31.5, [UIScreen mainScreen].bounds.size.width/4-16, 11.5)];
    //    HWTitle.text = @"运动酷夏";
    HWTitle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    HWTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [HWView addSubview:HWTitle];

    HWimgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/4-62)/2, 58.5, 62, 50)];
    //    HWimgView.image = [UIImage imageNamed:@""];
    [HWView addSubview:HWimgView];

    UIImageView *line12 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+231+35+250-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 1)];
    line12.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:line12];

    UIView *YXView = [[UIView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+231+35+250+1-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 35)];
    YXView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self addSubview:YXView];


    UIImageView *youxuan= [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-289/2)/2, 0, 289/2, 44)];
    youxuan.image  =[UIImage imageNamed:@"youxuan"];
    [YXView addSubview:youxuan];


    UILabel *YXName = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, (35-10)/2, 40, 10)];
    YXName.text = @"更多清单";
    YXName.textAlignment = NSTextAlignmentRight;
    YXName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    YXName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [YXView addSubview:YXName];

    CAGradientLayer *gradientLayer9 = [CAGradientLayer layer];

    gradientLayer9.frame = YXName.frame;

    gradientLayer9.colors = @[(id)[UIColor colorWithRed:211/255.0 green:48/255.0 blue:139/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:252/255.0 green:66/255.0 blue:76/255.0 alpha:1.0].CGColor];

    gradientLayer9.locations = @[@0.0, @1.0];
    gradientLayer9.startPoint = CGPointMake(0, 0);
    gradientLayer9.endPoint = CGPointMake(1.0, 0.0);

    [YXView.layer addSublayer:gradientLayer9];

    gradientLayer9.mask = YXName.layer;

    YXName.frame = gradientLayer9.bounds;

    UIImageView *YX1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-25, 13, 10, 10)];
    YX1.image  =[UIImage imageNamed:@"箭头-(1)"];
    [YXView addSubview:YX1];


    self.QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.QDButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 35);
    [YXView addSubview:self.QDButton];

    //优选清单
    UIView *YXSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+231+35+250+1+35-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 150)];
    YXSelectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:YXSelectView];

    UIView *KCView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 150)];
    [YXSelectView addSubview:KCView];

    self.KCButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.KCButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 150);
    [KCView addSubview:self.KCButton];

    KCName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width/2-20, 40)];
    //    KCName.text = @"充电快一步，1500元内快充手机推荐";
    KCName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    KCName.numberOfLines = 2;
    KCName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [KCView addSubview:KCName];

    KCimgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width/2-20, 95)];
    //    KCimgView.image = [UIImage imageNamed:@""];
    [KCView addSubview:KCimgView];


    UIImageView *KCline1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-1, 0, 1, 150)];
    KCline1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [KCView addSubview:KCline1];

    UIView *GGView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 150)];
    [YXSelectView addSubview:GGView];

    self.GGButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.GGButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 150);
    [GGView addSubview:self.GGButton];

    GGName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width/2-20, 40)];
    //    GGName.text = @"显高显瘦A字裙，尽显女性高贵气质";
    GGName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GGName.numberOfLines = 2;
    GGName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [GGView addSubview:GGName];

    GGimgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width/2-20, 95)];
    GGimgView.image = [UIImage imageNamed:@""];
    [GGView addSubview:GGimgView];

    UIImageView *line13 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+231+35+250+1+35+150-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 1)];
    line13.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:line13];

    //发现好店

    UIView *HDView = [[UIView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+231+35+250+1+35+150+1-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 35)];
    HDView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self addSubview:HDView];

    UIImageView *HD = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-289/2)/2, 0, 289/2, 44)];
    HD.image  =[UIImage imageNamed:@"faxianhaodian"];
    [HDView addSubview:HD];

    UILabel *HDName = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, (35-10)/2, 40, 10)];
    HDName.text = @"发现好店";
    HDName.textAlignment = NSTextAlignmentRight;
    HDName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    HDName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    // [HDView addSubview:HDName];


    CAGradientLayer *gradientLayer11 = [CAGradientLayer layer];

    gradientLayer11.frame = HDName.frame;

    gradientLayer11.colors = @[(id)[UIColor colorWithRed:211/255.0 green:48/255.0 blue:139/255.0 alpha:1.0].CGColor, (id)[UIColor  colorWithRed:123/255.0 green:57/255.0 blue:248/255.0 alpha:1.0].CGColor];

    gradientLayer11.locations = @[@0.0, @1.0];
    gradientLayer11.startPoint = CGPointMake(0, 0);
    gradientLayer11.endPoint = CGPointMake(1.0, 0.0);

    [HDView.layer addSublayer:gradientLayer11];

    gradientLayer11.mask = HDName.layer;

    HDName.frame = gradientLayer11.bounds;

    UIImageView *HD1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-25, 13, 10, 10)];
    HD1.image  =[UIImage imageNamed:@"箭头-(1)111"];
    //  [HDView addSubview:HD1];


    self.HDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.HDButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 35);
    //[HDView addSubview:self.HDButton];

    //1676
    UIView *HDSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 375+124+XLHuiqiangGouHeight+6+231+35+250+1+35+150+1+35-200+XLHHH, [UIScreen mainScreen].bounds.size.width, 356)];
    HDSelectView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self addSubview:HDSelectView];


    UIView *OneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/2, 177)];
    OneView.backgroundColor  =[UIColor whiteColor];
    [HDSelectView addSubview:OneView];



    UIView *OneView1 = [[UIView alloc] initWithFrame:CGRectMake(8, 10, ([UIScreen mainScreen].bounds.size.width-2)/2-12, 115)];
    OneView1.backgroundColor  =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [OneView addSubview:OneView1];

    OneimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 2.5, ([UIScreen mainScreen].bounds.size.width-2)/2-12-63, 110)];
    OneimgView1.image = [UIImage imageNamed:@""];
    [OneView1 addSubview:OneimgView1];

    OneimgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2-12-57.5, 2.5, 55, 54)];
    OneimgView2.image = [UIImage imageNamed:@""];
    [OneView1 addSubview:OneimgView2];

    OneimgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2-12-57.5, 58.5, 55, 54)];
    OneimgView3.image = [UIImage imageNamed:@""];
    [OneView1 addSubview:OneimgView3];

    OneLogo = [[UIImageView alloc] initWithFrame:CGRectMake(8.5, 135, 30, 30)];
    OneLogo.image = [UIImage imageNamed:@""];
    [OneView addSubview:OneLogo];

    OneName = [[UILabel alloc] initWithFrame:CGRectMake(49, 135, ([UIScreen mainScreen].bounds.size.width-2)/2-50, 13)];
    //    OneName.text = @"一米你旗舰店";
    OneName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    OneName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OneView addSubview:OneName];

    OneCount = [[UILabel alloc] initWithFrame:CGRectMake(49, 151.5, ([UIScreen mainScreen].bounds.size.width-2)/2-50, 11.5)];
    //    OneCount.text = @"18.3万人已逛";
    OneCount.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    OneCount.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [OneView addSubview:OneCount];

    self.OneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.OneButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/2, 177);
    [OneView addSubview:self.OneButton];

    UIView *TwoView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2+2, 0, ([UIScreen mainScreen].bounds.size.width-2)/2, 177)];
    TwoView.backgroundColor = [UIColor whiteColor];
    [HDSelectView addSubview:TwoView];



    UIView *TwoView1 = [[UIView alloc] initWithFrame:CGRectMake(2, 10, ([UIScreen mainScreen].bounds.size.width-2)/2-12, 115)];
    TwoView1.backgroundColor  =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [TwoView addSubview:TwoView1];

    TwoimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 2.5, ([UIScreen mainScreen].bounds.size.width-2)/2-12-63, 110)];
    TwoimgView1.image = [UIImage imageNamed:@""];
    [TwoView1 addSubview:TwoimgView1];

    TwoimgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2-12-57.5, 2.5, 55, 54)];
    TwoimgView2.image = [UIImage imageNamed:@""];
    [TwoView1 addSubview:TwoimgView2];

    TwoimgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2-12-57.5, 58.5, 55, 54)];
    TwoimgView3.image = [UIImage imageNamed:@""];
    [TwoView1 addSubview:TwoimgView3];

    TwoLogo = [[UIImageView alloc] initWithFrame:CGRectMake(8.5, 135, 30, 30)];
    TwoLogo.image = [UIImage imageNamed:@""];
    [TwoView addSubview:TwoLogo];

    TwoName = [[UILabel alloc] initWithFrame:CGRectMake(49, 135, ([UIScreen mainScreen].bounds.size.width-2)/2-50, 13)];
    //    TwoName.text = @"一米你旗舰店";
    TwoName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    TwoName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [TwoView addSubview:TwoName];

    TwoCount = [[UILabel alloc] initWithFrame:CGRectMake(49, 151.5, ([UIScreen mainScreen].bounds.size.width-2)/2-50, 11.5)];
    //    TwoCount.text = @"18.3万人已逛";
    TwoCount.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    TwoCount.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [TwoView addSubview:TwoCount];

    self.TwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.TwoButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/2, 177);
    [TwoView addSubview:self.TwoButton];

    UIView *ThreeView = [[UIView alloc] initWithFrame:CGRectMake(0, 2+177, ([UIScreen mainScreen].bounds.size.width-2)/2, 177)];
    ThreeView.backgroundColor = [UIColor whiteColor];
    [HDSelectView addSubview:ThreeView];



    UIView *ThreeView1 = [[UIView alloc] initWithFrame:CGRectMake(8, 10, ([UIScreen mainScreen].bounds.size.width-2)/2-12, 115)];
    ThreeView1.backgroundColor  =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [ThreeView addSubview:ThreeView1];

    ThreeimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 2.5, ([UIScreen mainScreen].bounds.size.width-2)/2-12-63, 110)];
    ThreeimgView1.image = [UIImage imageNamed:@""];
    [ThreeView1 addSubview:ThreeimgView1];

    ThreeimgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2-12-57.5, 2.5, 55, 54)];
    ThreeimgView2.image = [UIImage imageNamed:@""];
    [ThreeView1 addSubview:ThreeimgView2];

    ThreeimgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2-12-57.5, 58.5, 55, 54)];
    ThreeimgView3.image = [UIImage imageNamed:@""];
    [ThreeView1 addSubview:ThreeimgView3];

    ThreeLogo = [[UIImageView alloc] initWithFrame:CGRectMake(8.5, 135, 30, 30)];
    ThreeLogo.image = [UIImage imageNamed:@""];
    [ThreeView addSubview:ThreeLogo];

    ThreeName = [[UILabel alloc] initWithFrame:CGRectMake(49, 135, ([UIScreen mainScreen].bounds.size.width-2)/2-50, 13)];
    //    ThreeName.text = @"一米你旗舰店";
    ThreeName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ThreeName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [ThreeView addSubview:ThreeName];

    ThreeCount = [[UILabel alloc] initWithFrame:CGRectMake(49, 151.5, ([UIScreen mainScreen].bounds.size.width-2)/2-50, 11.5)];
    //    ThreeCount.text = @"18.3万人已逛";
    ThreeCount.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    ThreeCount.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [ThreeView addSubview:ThreeCount];

    self.ThreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ThreeButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/2, 177);
    [ThreeView addSubview:self.ThreeButton];

    UIView *FourView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2+2, 2+177, ([UIScreen mainScreen].bounds.size.width-2)/2, 177)];
    FourView.backgroundColor = [UIColor whiteColor];
    [HDSelectView addSubview:FourView];



    UIView *FourView1 = [[UIView alloc] initWithFrame:CGRectMake(2, 10, ([UIScreen mainScreen].bounds.size.width-2)/2-12, 115)];
    FourView1.backgroundColor  =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [FourView addSubview:FourView1];

    FourimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 2.5, ([UIScreen mainScreen].bounds.size.width-2)/2-12-63, 110)];
    FourimgView1.image = [UIImage imageNamed:@""];
    [FourView1 addSubview:FourimgView1];

    FourimgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2-12-57.5, 2.5, 55, 54)];
    FourimgView2.image = [UIImage imageNamed:@""];
    [FourView1 addSubview:FourimgView2];

    FourimgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/2-12-57.5, 58.5, 55, 54)];
    FourimgView3.image = [UIImage imageNamed:@""];
    [FourView1 addSubview:FourimgView3];

    FourLogo = [[UIImageView alloc] initWithFrame:CGRectMake(8.5, 135, 30, 30)];
    FourLogo.image = [UIImage imageNamed:@""];
    [FourView addSubview:FourLogo];

    FourName = [[UILabel alloc] initWithFrame:CGRectMake(49, 135, ([UIScreen mainScreen].bounds.size.width-2)/2-50, 13)];
    //    FourName.text = @"一米你旗舰店";
    FourName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    FourName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [FourView addSubview:FourName];

    FourCount = [[UILabel alloc] initWithFrame:CGRectMake(49, 151.5, ([UIScreen mainScreen].bounds.size.width-2)/2-50, 11.5)];
    //    FourCount.text = @"18.3万人已逛";
    FourCount.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    FourCount.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [FourView addSubview:FourCount];

    self.FourButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.FourButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/2, 177);
    [FourView addSubview:self.FourButton];

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

        //        NSLog(@"=========%@",string);


        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, XLHHH)];
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




@end


