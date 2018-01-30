//
//  BMNewGameAndPhoneViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/20.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "BMNewGameAndPhoneViewController.h"

#import "SCNavTabBarController.h"//导航分栏控制器


#import "TelephoneBillViewController.h"//话费
#import "PhoneFlowViewController.h"//流量
#import "GameViewController.h"//游戏

#import "WKProgressHUD.h"

#import "NewGoodsDetailViewController.h"
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)

#define  kFont(size) ([UIFont systemFontOfSize:(size)])
#define  kColor(r, g, b, a) ([UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)])

#import "PersonaViewController.h"

#import "YTGoodsDetailViewController.h"

@interface BMNewGameAndPhoneViewController ()<UIScrollViewDelegate>
{
    
    
}

@property (nonatomic, strong) UIScrollView *contentScrollView; //!< 作为容器的ScrollView
@property (nonatomic, strong) UIScrollView *titleScrollView; //!< 标题的ScrollView
@property (nonatomic, strong) UILabel *label;//标题；
@property (nonatomic, strong) UIView *slider;//选择时的红线；

@property (nonatomic, strong) UILabel *currentTitleLabel;//当前标题
@property (nonatomic, strong) UILabel *nextTitleLabel;//滑动下一个标题

@property (nonatomic, assign) CGPoint beginOffset; //!<拖拽开始的偏移量
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;


@end

@implementation BMNewGameAndPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    [Qurt addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"充值中心";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
    [self.view addSubview:self.contentScrollView];
    [self.view addSubview:self.titleScrollView];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //话费
    TelephoneBillViewController *vc1=[[TelephoneBillViewController alloc] init];
    
    
    //流量
    PhoneFlowViewController *vc2=[[PhoneFlowViewController alloc] init];
    
    //游戏
 //   GameViewController *vc3=[[GameViewController alloc] init];
    
    
    [self addChildViewController:vc1];
    [self.contentScrollView addSubview:vc1.view];
    [vc1 didMoveToParentViewController:self];
    
    [self addChildViewController:vc2];
    [self.contentScrollView addSubview:vc2.view];
    [vc2 didMoveToParentViewController:self];
    
//    [self addChildViewController:vc3];
//    [self.contentScrollView addSubview:vc3.view];
//    [vc3 didMoveToParentViewController:self];
    
    
    CGSize size = self.contentScrollView.bounds.size;
    vc1.view.frame = CGRectMake(0, 0, size.width, size.height);
    vc2.view.frame = CGRectMake(size.width, 0, size.width, size.height);
 //   vc3.view.frame = CGRectMake(size.width*2, 0, size.width, size.height);
    
    self.contentScrollView.contentSize = CGSizeMake(size.width*2, size.height);
    self.contentScrollView.pagingEnabled = YES;
    
    //首次点击进入判断，点击的哪一个；
    if (self.tag0==100) {
        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth*(self.tag0-100), 0);
        
        
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:self.tag0];
        
        self.currentTitleLabel.textColor = [UIColor redColor];
        
        
    }else if (self.tag1==101) {
        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth*(self.tag1-100), 0);
        
        
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:self.tag1];
        
        self.currentTitleLabel.textColor = [UIColor redColor];
        
        UIView *slider = [self.titleScrollView viewWithTag:10001];
        [UIView animateWithDuration:0.25 animations:^{
            slider.center = CGPointMake(self.currentTitleLabel.center.x, slider.center.y);
        } completion:nil];
        
    }
//    else if (self.tag2==102){
//        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth*(self.tag2-100), 0);
//        
//        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:self.tag2];
//        
//        self.currentTitleLabel.textColor = [UIColor redColor];
//        
//        UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:101];
//        
//        label.textColor = [UIColor blackColor];
//        
//        UIView *slider = [self.titleScrollView viewWithTag:10001];
//        [UIView animateWithDuration:0.25 animations:^{
//            slider.center = CGPointMake(self.currentTitleLabel.center.x, slider.center.y);
//        } completion:nil];
//        
//    }
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    
    
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/2;
        [self.titleScrollView scrollRectToVisible:CGRectMake(itemWidth*1, 0, itemWidth, 40) animated:YES];
        [self.contentScrollView setContentOffset:CGPointMake(kScreenWidth*1, 0) animated:YES];
        UIView *slider = [self.titleScrollView viewWithTag:10001];
        [UIView animateWithDuration:0.25 animations:^{
            slider.center = CGPointMake(itemWidth/2+itemWidth, slider.center.y);
        } completion:nil];
        for (int i=0; i<2; i++) {
            UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:100+i];
            label.textColor = [UIColor blackColor];
        }
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:101];
        self.currentTitleLabel.textColor = [UIColor redColor];
        
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"右滑");
        CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/2;
        [self.titleScrollView scrollRectToVisible:CGRectMake(itemWidth*0, 0, itemWidth, 40) animated:YES];
        [self.contentScrollView setContentOffset:CGPointMake(kScreenWidth*0, 0) animated:YES];
        UIView *slider = [self.titleScrollView viewWithTag:10001];
        [UIView animateWithDuration:0.25 animations:^{
            slider.center = CGPointMake(itemWidth/2+itemWidth*0, slider.center.y);
        } completion:nil];
        for (int i=0; i<2; i++) {
            UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:100+i];
            label.textColor = [UIColor blackColor];
        }
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:100];
        self.currentTitleLabel.textColor = [UIColor redColor];
        
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    self.beginOffset = scrollView.contentOffset;

}

#pragma mark - Event Handlers

//点击顶部的标题（下划线的移动，字体变色）

- (void)titleDidTap:(UITapGestureRecognizer *)tap
{
    
    NSInteger index = tap.view.tag - 100;
    [self.titleScrollView scrollRectToVisible:tap.view.frame animated:YES];
    [self.contentScrollView setContentOffset:CGPointMake(kScreenWidth*index, 0) animated:NO];
    UIView *slider = [self.titleScrollView viewWithTag:10001];
    [UIView animateWithDuration:0.25 animations:^{
        slider.center = CGPointMake(tap.view.center.x, slider.center.y);
    } completion:nil];
    for (int i=0; i<2; i++) {
        UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:100+i];
        label.textColor = [UIColor blackColor];
    }
    self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:tap.view.tag];
    self.currentTitleLabel.textColor = [UIColor redColor];

}

#pragma mark - Getter

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40+KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-40-KSafeAreaTopNaviHeight)];
        _contentScrollView.backgroundColor = [UIColor lightGrayColor];
        
        _contentScrollView.delegate = self;
        _contentScrollView.scrollEnabled = NO;
    }
    
    return _contentScrollView;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (UIScrollView *)titleScrollView
{
    if (_titleScrollView == nil) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, 40)];
        _titleScrollView.backgroundColor = [UIColor clearColor];
        _titleScrollView.bounces=NO;
        NSArray *titles = @[@"话费充值", @"流量充值"];
        //宽度
      CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/2;
        
        for (int i=0; i<2; i++) {
            _label = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth*i, 0, itemWidth, 40)];
            _label.textAlignment = NSTextAlignmentCenter;
            _label.font=[UIFont systemFontOfSize:14];
            _label.text = titles[i];
            _label.tag = 100 + i;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleDidTap:)];
            [_label addGestureRecognizer:tapGesture];
            _label.userInteractionEnabled = YES;
            
            [_titleScrollView addSubview:_label];
        }
        
        _slider = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2-63)/2, 40-3, 63, 3)];
        
        _slider.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        _slider.tag = 10001;
        [_titleScrollView addSubview:_slider];
        
        _titleScrollView.contentSize = CGSizeMake(itemWidth*2, 40);
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40+KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
        
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        
        [self.view addSubview:line];
    }
    
    return _titleScrollView;
}




//返回
-(void)backBtnClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
