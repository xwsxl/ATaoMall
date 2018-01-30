//
//  NewHomeHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NewHomeHeaderView.h"

#import "HomeModel.h"
#import "YTScrolling.h"//图片轮番

#import "UIImageView+WebCache.m"

#import "NewGoodsDetailViewController.h"//商品详情

#import "YTGoodsDetailViewController.h"
@interface NewHomeHeaderView()<UIScrollViewDelegate>

#define fHeight  [UIScreen mainScreen].bounds.size.height
#define fWidth    [UIScreen mainScreen].bounds.size.width

@end
@implementation NewHomeHeaderView
{
    
    __weak IBOutlet UIPageControl *pageControl;
    __weak IBOutlet UIScrollView *myScrollView;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIViewController*)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


-(void)awakeFromNib
{
    
    NSLog(@"进入---->NewHomeHeaderView");
    
    
    myScrollView.delegate=self;
    
    myScrollView.pagingEnabled=YES;
    
    myScrollView.bounces=NO;
    
    myScrollView.showsHorizontalScrollIndicator=YES;
    
    myScrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    
    
    [self initButton];
    
    //设置背景颜色
    //   pageControl.backgroundColor = [UIColor lightGrayColor];
    //设置总共的页数
//    pageControl.numberOfPages = 5;
    //设置所有点的颜色
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //设置当前页点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //设置当前的页, 0......
    pageControl.currentPage = 0;
    
    //添加事件  UIControlEventValueChanged
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];
    
    [self addSubview:pageControl];
    
 //   [self insertSubview:pageControl aboveSubview:myScrollView];
    
    
 //   self.pageControl.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
}

//@property (weak, nonatomic) IBOutlet UIButton *hkButton;//香港购物佳
//@property (weak, nonatomic) IBOutlet UIButton *ninenineButton;//九块九包邮
//@property (weak, nonatomic) IBOutlet UIButton *scoreStoreButton;//纯积分商城
//@property (weak, nonatomic) IBOutlet UIButton *yuyuanButton;//一元夺宝
-(void)initButton{
//    float fHeight = [UIScreen mainScreen].bounds.size.height;
//    float fWidth   = [UIScreen mainScreen].bounds.size.width;
    
//     NSLog(@"kkkk%f",myScrollView.frame.size.height);
//     NSLog(@"kkkk%f",self.frame.size.height);
//     NSLog(@"kkkk%f",([UIScreen mainScreen].bounds.size.height)*7/11);
    CGFloat space = 20.0;
    
    _hkButton = [[UIButton alloc]initWithFrame:CGRectMake(fWidth/3*0, fHeight*7/11 - fHeight*2/11-5, fWidth/3-1, fHeight*2/11)];
    
    UIImage *image = [[UIImage imageNamed:@"海外"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_hkButton setImage:[image scaleToSize:CGSizeMake(fWidth*16/100, fWidth*16/100)] forState:UIControlStateNormal];
    [_hkButton setTitle:@"海外购物佳" forState:0];
    _hkButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [_hkButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:0];
    [ _hkButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
     imageTitleSpace:space];
    [self addSubview:_hkButton];
    
    _ninenineButton = [[UIButton alloc]initWithFrame:CGRectMake(fWidth/3*1, fHeight*7/11 - fHeight*2/11-5, fWidth/3-1, fHeight*2/11)];
//    _ninenineButton.backgroundColor = [UIColor greenColor];
    
    UIImage *image2 = [[UIImage imageNamed:@"9.9new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_ninenineButton setImage:[image2 scaleToSize:CGSizeMake(fWidth*16/100, fWidth*16/100)] forState:UIControlStateNormal];
    [_ninenineButton setTitle:@"九块九包邮" forState:0];
    _ninenineButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [_ninenineButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:0];
    [ _ninenineButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                                imageTitleSpace:space];
    [self addSubview:_ninenineButton];
    
    _scoreStoreButton = [[UIButton alloc]initWithFrame:CGRectMake(fWidth/3*2, fHeight*7/11 - fHeight*2/11-5, fWidth/3-1, fHeight*2/11)];
//    _scoreStoreButton.backgroundColor = [UIColor greenColor];
    UIImage *image3 = [[UIImage imageNamed:@"积分专题"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_scoreStoreButton setImage:[image3 scaleToSize:CGSizeMake(fWidth*16/100, fWidth*16/100)] forState:UIControlStateNormal];
    [_scoreStoreButton setTitle:@"积分专题" forState:0];
    _scoreStoreButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [_scoreStoreButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:0];
    [ _scoreStoreButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                                imageTitleSpace:space];
    [self addSubview:_scoreStoreButton];
    
    
//    _hkButton = [[UIButton alloc]initWithFrame:CGRectMake(fWidth/3*0, fHeight*7/11 - fHeight*2/11-5, fWidth/3-1, fHeight*2/11)];
//    
//    UIImage *image = [[UIImage imageNamed:@"海外"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [_hkButton setImage:[image scaleToSize:CGSizeMake(40, 40)] forState:UIControlStateNormal];
//    [_hkButton setTitle:@"海外购物佳" forState:0];
//    _hkButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
//    [_hkButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:0];
//    [ _hkButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
//                                imageTitleSpace:space];
//    [self addSubview:_hkButton];
//    
//    _ninenineButton = [[UIButton alloc]initWithFrame:CGRectMake(fWidth/3*1, fHeight*7/11 - fHeight*2/11-5, fWidth/3-1, fHeight*2/11)];
//    //    _ninenineButton.backgroundColor = [UIColor greenColor];
//    
//    UIImage *image2 = [[UIImage imageNamed:@"9.9"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [_ninenineButton setImage:[image2 scaleToSize:CGSizeMake(40, 40)] forState:UIControlStateNormal];
//    [_ninenineButton setTitle:@"九块九包邮" forState:0];
//    _ninenineButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
//    [_ninenineButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:0];
//    [ _ninenineButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
//                                      imageTitleSpace:space];
//    [self addSubview:_ninenineButton];
//    
//    _scoreStoreButton = [[UIButton alloc]initWithFrame:CGRectMake(fWidth/3*2, fHeight*7/11 - fHeight*2/11-5, fWidth/3-1, fHeight*2/11)];
//    //    _scoreStoreButton.backgroundColor = [UIColor greenColor];
//    UIImage *image3 = [[UIImage imageNamed:@"积分专题"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [_scoreStoreButton setImage:[image3 scaleToSize:CGSizeMake(40, 40)] forState:UIControlStateNormal];
//    [_scoreStoreButton setTitle:@"积分专题" forState:0];
//    _scoreStoreButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
//    [_scoreStoreButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:0];
//    [ _scoreStoreButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
//                                        imageTitleSpace:space];
//    [self addSubview:_scoreStoreButton];
//    
    
    
    
    
    
}

- (void)timeChange:(NSTimer *)timer
{
    static int num;
    num ++;
    if (num == _headerDatas.count) {
        num = 0;
    }
    
    if (num != 0) {
        [myScrollView setContentOffset:CGPointMake(num*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    } else {
        [myScrollView setContentOffset:CGPointZero];
    }
}
- (void)pageChange:(UIPageControl *)pageCtl
{
    
    NSInteger currentPage = pageCtl.currentPage;
    
    //-----------修改scrollView的页面-------------
    
    
    //移动点, 设置相对于原点的偏移量
    [myScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width*currentPage, 0) animated:YES];
    
}

//正在滚动中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //使用偏移量获取当前的页
    NSInteger currentPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    
    pageControl.currentPage = currentPage;
    
}


-(void)setHeaderDatas:(NSArray *)headerDatas
{
    _headerDatas = headerDatas;
    
    
    pageControl.numberOfPages = _headerDatas.count;
    //设置contentSize
    myScrollView.contentSize = CGSizeMake(headerDatas.count * [UIScreen mainScreen].bounds.size.width, 0);
    
    
    //先移除旧UI
    for (UIView *view in myScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    //添加新UI
    //赋值
    for (int i=0; i<headerDatas.count; i++) {
        
        NSString *string = headerDatas[i];
        
//        NSLog(@"=========%@",string);
        
        
        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*3/7)];
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
        
        [myScrollView addSubview:imgView];
        
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
            
            NSLog(@"====%@",gid);
            
            
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

//
//- (UIPageControl *)pageControl {
//    if (!_MypageControl) {
//        _MypageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
//        _MypageControl.numberOfPages = 4;
//        _MypageControl.currentPage = 0;
//    }
//    return _MypageControl;
//}

@end
