//
//  BMPlaneAndTrainViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/20.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "BMPlaneAndTrainViewController.h"

#import "SCNavTabBarController.h"//导航分栏控制器


#import "AeroplaneViewController.h"//飞机票
#import "TrainViewController.h"//火车票

#import "WKProgressHUD.h"
#import "TrainToast.h"
#import "NewGoodsDetailViewController.h"
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)

#define  kFont(size) ([UIFont systemFontOfSize:(size)])
#define  kColor(r, g, b, a) ([UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)])

#import "PersonaViewController.h"

#import "YTGoodsDetailViewController.h"

#import "TrainOrderViewController.h"



@interface BMPlaneAndTrainViewController ()<UIScrollViewDelegate>
{
    
    
}

@property (nonatomic, strong) UIScrollView *contentScrollView; //!< 作为容器的ScrollView
@property (nonatomic, strong) UIScrollView *titleScrollView; //!< 标题的ScrollView
@property (nonatomic, strong) UILabel *label;//标题；
@property (nonatomic, strong) UIImageView *ImgView;//标题；
@property (nonatomic, strong) UIView *slider;//选择时的红线；

@property (nonatomic, strong) UILabel *currentTitleLabel;//当前标题
@property (nonatomic, strong) UILabel *nextTitleLabel;//滑动下一个标题

@property (nonatomic, assign) CGPoint beginOffset; //!<拖拽开始的偏移量
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end

@implementation BMPlaneAndTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [titleView addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    [Qurt addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"交通出行";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 6)];
    view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    [self.view addSubview:self.contentScrollView];
    [self.view addSubview:self.titleScrollView];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //话费
    AeroplaneViewController *vc1=[[AeroplaneViewController alloc] init];
    
    
    //流量
    TrainViewController *vc2=[[TrainViewController alloc] init];
    

    
    
    [self addChildViewController:vc1];
    [self.contentScrollView addSubview:vc1.view];
    [vc1 didMoveToParentViewController:self];
    
    [self addChildViewController:vc2];
    [self.contentScrollView addSubview:vc2.view];
    [vc2 didMoveToParentViewController:self];
    
    
    
    CGSize size = self.contentScrollView.bounds.size;
    vc1.view.frame = CGRectMake(0, 0, size.width, size.height);
    vc2.view.frame = CGRectMake(size.width, 0, size.width, size.height);
    
    self.contentScrollView.contentSize = CGSizeMake(size.width*3, size.height);
    self.contentScrollView.pagingEnabled = YES;
    
    //首次点击进入判断，点击的哪一个；
    if (self.tag0==100) {
        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth*(self.tag0-100), 0);
        
        
//        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:self.tag0];
//        
//        self.currentTitleLabel.textColor = [UIColor redColor];
        
        for (int i=0; i<2; i++) {
            UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:100+i];
            label.textColor = [UIColor blackColor];
        }
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:self.tag0];
        self.currentTitleLabel.textColor = [UIColor redColor];
        
        UIImageView *logo = (UIImageView *)[self.titleScrollView viewWithTag:300];
        logo.image = [UIImage imageNamed:@"tab_icon_airplay1711"];
        
        UIImageView *logo1 = (UIImageView *)[self.titleScrollView viewWithTag:301];
        logo1.image = [UIImage imageNamed:@"tab_icon_train1711"];
        
        
        
    }else if (self.tag1==101) {
        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth*(self.tag1-100), 0);
        
        
//        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:self.tag1];
//        
//        self.currentTitleLabel.textColor = [UIColor redColor];
        
        for (int i=0; i<2; i++) {
            UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:100+i];
            label.textColor = [UIColor blackColor];
        }
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:self.tag1];
        self.currentTitleLabel.textColor = [UIColor redColor];
        
        UIView *slider = [self.titleScrollView viewWithTag:10001];
        [UIView animateWithDuration:0.25 animations:^{
            slider.center = CGPointMake(self.currentTitleLabel.center.x, slider.center.y);
        } completion:nil];
        
        UIImageView *logo = (UIImageView *)[self.titleScrollView viewWithTag:300];
        logo.image = [UIImage imageNamed:@"tab_icon_airplay711"];
        
        UIImageView *logo1 = (UIImageView *)[self.titleScrollView viewWithTag:301];
        logo1.image = [UIImage imageNamed:@"tab_icon_train711"];
        
    }
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
        [self.titleScrollView scrollRectToVisible:CGRectMake(itemWidth*1, 0, itemWidth, 44) animated:YES];
        [self.contentScrollView setContentOffset:CGPointMake(kScreenWidth*1, 0) animated:YES];
    
        for (int i=0; i<2; i++) {
            UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:100+i];
            label.textColor = [UIColor blackColor];
        }
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:101];
        self.currentTitleLabel.textColor = [UIColor redColor];
        UIImageView *logo = (UIImageView *)[self.titleScrollView viewWithTag:300];
        logo.image = [UIImage imageNamed:@"tab_icon_airplay711"];
        
        UIImageView *logo1 = (UIImageView *)[self.titleScrollView viewWithTag:301];
        logo1.image = [UIImage imageNamed:@"tab_icon_train711"];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"右滑");
        CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/2;
        [self.titleScrollView scrollRectToVisible:CGRectMake(itemWidth*0, 0, itemWidth, 44) animated:YES];
        [self.contentScrollView setContentOffset:CGPointMake(kScreenWidth*0, 0) animated:YES];

        for (int i=0; i<2; i++) {
            UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:100+i];
            label.textColor = [UIColor blackColor];
        }
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:100];
        self.currentTitleLabel.textColor = [UIColor redColor];
        UIImageView *logo = (UIImageView *)[self.titleScrollView viewWithTag:300];
        logo.image = [UIImage imageNamed:@"tab_icon_airplay1711"];
        
        UIImageView *logo1 = (UIImageView *)[self.titleScrollView viewWithTag:301];
        logo1.image = [UIImage imageNamed:@"tab_icon_train1711"];
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
        
        
        for (int i=0; i<2; i++) {
            UILabel *label= (UILabel *)[self.titleScrollView viewWithTag:100+i];
            label.textColor = [UIColor blackColor];
        }
        self.currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:tap.view.tag];
        self.currentTitleLabel.textColor = [UIColor redColor];
    
    if (tap.view.tag+200 == 300) {
        
        UIImageView *logo = (UIImageView *)[self.titleScrollView viewWithTag:300];
        logo.image = [UIImage imageNamed:@"tab_icon_airplay1711"];
        
        UIImageView *logo1 = (UIImageView *)[self.titleScrollView viewWithTag:301];
        logo1.image = [UIImage imageNamed:@"tab_icon_train1711"];
        
    }else if(tap.view.tag+200 == 301){
        
        UIImageView *logo = (UIImageView *)[self.titleScrollView viewWithTag:300];
        logo.image = [UIImage imageNamed:@"tab_icon_airplay711"];
        
        UIImageView *logo1 = (UIImageView *)[self.titleScrollView viewWithTag:301];
        logo1.image = [UIImage imageNamed:@"tab_icon_train711"];
    }
    
    
}

#pragma mark - Getter

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50+KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-50-KSafeAreaTopNaviHeight)];
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
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+6, kScreenWidth, 44)];
        _titleScrollView.backgroundColor = [UIColor clearColor];
        _titleScrollView.bounces=NO;

        NSArray *titles = @[@"飞机票", @"火车票"];
        //宽度
        CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/2;
        
        for (int i=0; i<2; i++) {
            
            
            _label = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth*i, 0, itemWidth, 44)];
            _label.textAlignment = NSTextAlignmentCenter;
            _label.font=[UIFont systemFontOfSize:14];
            _label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
            
            _ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(itemWidth/4+itemWidth*i-10, 11.5, 21, 21)];
            _ImgView.contentMode = UIViewContentModeScaleAspectFit;
            _ImgView.tag = 300+i;
            [_titleScrollView addSubview:_ImgView];
            
            if (i==0) {
                
                _label.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
                _ImgView.image = [UIImage imageNamed:@"tab_icon_airplay1711"];
                
            }else{
                
                _ImgView.image = [UIImage imageNamed:@"tab_icon_train1711"];
            }
            
            _label.text = titles[i];
            _label.tag = 100 + i;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleDidTap:)];
            [_label addGestureRecognizer:tapGesture];
            _label.userInteractionEnabled = YES;
            
            [_titleScrollView addSubview:_label];
        }
        
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(itemWidth-1, 9.5, 1, 25)];
        view.backgroundColor = UIColorFromRGB(0xe1e1e1);
        [_titleScrollView addSubview:view];
        
        _titleScrollView.contentSize = CGSizeMake(itemWidth*2, 44);
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50+KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
        
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
