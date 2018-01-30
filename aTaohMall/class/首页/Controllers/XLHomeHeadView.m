//
//  XLHomeHeadView.m
//  aTaohMall
//
//  Created by Hawky on 2018/1/2.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLHomeHeadView.h"
#import "KTPageControl.h"

@interface XLHomeHeadView()<UIScrollViewDelegate>
{
    NSArray *_headerBannerArr;


    UIScrollView *_myScrollView;
    KTPageControl *_pageControl;

}





@end
@implementation XLHomeHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

//
-(void)setUpSubViews
{

    [self setBanner];
    NSLog(@"hahaha");


}
//banner
-(void)setBanner
{

    CGFloat HHH=([UIScreen mainScreen].bounds.size.height)*4/11;
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HHH)];

    _myScrollView.delegate=self;

    _myScrollView.pagingEnabled=YES;

    _myScrollView.bounces=NO;

    _myScrollView.showsHorizontalScrollIndicator=YES;

    _myScrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;

    [self addSubview:_myScrollView];


    if (_pageControl == nil)
    {

        _pageControl = [[KTPageControl alloc] init];

        if ([UIScreen mainScreen].bounds.size.width > 320) {

            _pageControl.frame =CGRectMake(self.frame.size.width+100, HHH-20, 40, 7);

        }else{

            _pageControl.frame =CGRectMake(self.frame.size.width+50, HHH-20, 40, 7);

        }

        _pageControl.currentImage =[UIImage imageNamed:@"椭圆-7"];
        _pageControl.defaultImage =[UIImage imageNamed:@"628"];

        //设置pageSize以设置为准、否则以图片大小为准、图片也没有默认7*7...
        _pageControl.pageSize = CGSizeMake(7, 7);

        _pageControl.currentPage = 0;

        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];

        //定时器
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];

    }
    
         [self addSubview:_pageControl];

}












@end
