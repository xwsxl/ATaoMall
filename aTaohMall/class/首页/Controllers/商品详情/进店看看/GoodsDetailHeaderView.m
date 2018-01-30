//
//  GoodsDetailHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "GoodsDetailHeaderView.h"

#import "GoodsDetailImageModel.h"

#import "UIImageView+WebCache.h"

#import "TimeModel.h"
#import "GGClockView.h"//倒计时
@interface GoodsDetailHeaderView()<UIScrollViewDelegate>
{
    int num;
}
@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@end
@implementation GoodsDetailHeaderView
{
    __weak IBOutlet UIScrollView *myScrollView;
    
    __weak IBOutlet UIPageControl *pageControl;
}


+ (instancetype)headerView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"GoodsDetailHeaderView" owner:nil options:nil]lastObject];
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

-(void)awakeFromNib
{
    
    self.YTTimeLabel.hidden=YES;
    
    myScrollView.delegate=self;
    
    myScrollView.pagingEnabled=YES;
    
    myScrollView.bounces=NO;
    
    myScrollView.showsHorizontalScrollIndicator=YES;
    
    myScrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    
    
    
    
    //设置背景颜色
//       pageControl.backgroundColor = [UIColor orangeColor];
    //设置总共的页数
//    pageControl.numberOfPages = _headerDatas.count;
    //设置所有点的颜色
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //设置当前页点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //设置当前的页, 0......
    pageControl.currentPage = 0;
    
    //添加事件  UIControlEventValueChanged
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    
    //定时器
    [_timer invalidate];
    _timer = nil;
    num=0;
    _timer =[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];

   
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TimeStop3:) name:@"TimeStop3" object:nil];
    
    
}

- (void)TimeStop3:(NSNotification *)text{
    
    
    _goods_type=@"2";
    
    
}

- (void)timeChange:(NSTimer *)timer
{
    

    

    if (num == _headerDatas.count-1&&_headerDatas.count==1) {
        [myScrollView setContentOffset:CGPointZero];
    } else if(num >= _headerDatas.count){
        num = 0;
    }else{
     if (num>0) {
            [myScrollView setContentOffset:CGPointMake(num*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
         
        } else {
            [myScrollView setContentOffset:CGPointZero];
        }
        num ++;
    }
    NSLog(@"====_headerDatas.count====%ld,%ld",_headerDatas.count,num);
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

#pragma mark - setter
- (void)setTime:(NSTimeInterval)time {
    _time = time;
    
//    [self setViewWith:_time];
//
//    [self.timer1 invalidate];
//    self.timer1 = nil;
//
//    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
//    [self.timer1 fire];

}

-(void)setEnd_time_str:(NSString *)end_time_str
{
    
    _end_time_str=end_time_str;
    
    //日期转换为时间戳 (日期转换为秒数)
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
//    
//    //当前时间
//    NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
//    
//    //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
//    NSDate *date2 = [dateFormatter dateFromString:_end_time_str];
//    
//    
//    
//    
//    NSDate *num1 = [self getNowDateFromatAnDate:date3];
//    NSDate *num2=[self getNowDateFromatAnDate:date2];
//    
//    
//    NSLog(@"=====66666====当前日期为:%@",num1);
//    NSLog(@"=====66666====结束日期为:%@",num2);
//    
//    NSTimeInterval hh1= [num1 timeIntervalSince1970];
//    
//    NSTimeInterval hh2 = [num2 timeIntervalSince1970];
//    
//    
//    NSInteger times;
//    
//    
//    times=hh2-hh1;
//    
//    
//    
//    
//    GGClockView *clockView = [[GGClockView alloc] init];
//    clockView.frame = self.ShiJianLabel.frame;
//    
//    //        clockView.frame =_header.ShiJianLabel.frame;
//    
//    [clockView setTimeBackgroundColor:[UIColor blackColor] timeTextColor:[UIColor whiteColor] colonColor:[UIColor blackColor] font:[UIFont systemFontOfSize:10]];
//    clockView.time = times;
//    [self.YTTimeLabel addSubview:clockView];
//    self.clockView = clockView;
    
    
    
}


#pragma mark - personal
- (void)timeRun {
    
    if (_time <= 0) {
        [self.timer1 invalidate];
        self.timer1 = nil;
        _time = 0;
    } else {
        _time --;
    }
    
    [self setViewWith:_time];
}

-(void)setGoods_type:(NSString *)goods_type
{
    
    _goods_type=goods_type;
    
    NSLog(@"---------daojishi===%@",_goods_type);
    
    
    
    if ([_goods_type isEqualToString:@"1"]) {
        
        self.YTTimeLabel.hidden=NO;
        
    }else{
        
        self.YTTimeLabel.hidden=YES;
    }
}

- (void)setViewWith:(NSTimeInterval)time {
    
    
//    self.YTTimeLabel.hidden=NO;
//
////    NSLog(@"====_goods_type====%@",_goods_type);
//
//    NSInteger hour = time/3600.0;
//    NSInteger min  = (time - hour*3600)/60;
//    NSInteger sec  = time - hour*3600 - min*60;
//
//    self.hourLabel.text   = [NSString stringWithFormat:@"%02tu",hour];
//    self.minLabel.text = [NSString stringWithFormat:@"%02tu",min];
//    self.secLabel.text = [NSString stringWithFormat:@"%02tu",sec];
//
//    self.hourLabel.layer.cornerRadius  = 2;
//    self.hourLabel.layer.masksToBounds = YES;
//
//    self.minLabel.layer.cornerRadius  = 2;
//    self.minLabel.layer.masksToBounds = YES;
//
//    self.secLabel.layer.cornerRadius  = 2;
//    self.secLabel.layer.masksToBounds = YES;
//
//
//    if ([_goods_type isEqualToString:@"1"]) {
//
//        if ([self.hourLabel.text isEqualToString:@"00"] && [self.minLabel.text isEqualToString:@"00"] && [self.secLabel.text isEqualToString:@"00"]) {
//
//
//            [self.timer1 invalidate];
//            self.timer1 = nil;
//
//            NSNotification *notification =[NSNotification notificationWithName:@"TimeStop2" object:nil userInfo:nil];
//            //通过通知中心发送通知
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
//
//        }
//
//
//    }else if ([_goods_type isEqualToString:@"2"]){
//
//
//    }

    
    
    
}

-(void)setHeaderDatas:(NSArray *)headerDatas
{
    _headerDatas = headerDatas;
    
    if (_headerDatas.count==0) {
        pageControl.numberOfPages = 0;
    }else{
        
      pageControl.numberOfPages = _headerDatas.count;  
    }
    
    //设置contentSize
    myScrollView.contentSize = CGSizeMake(headerDatas.count * [UIScreen mainScreen].bounds.size.width, 0);
    
    
    //先移除旧UI
    for (UIView *view in myScrollView.subviews) {
        [view removeFromSuperview];
    }
    //添加新UI
    //赋值
    
//    for (GoodsDetailImageModel *model in headerDatas) {
//        NSString *picpath=model.picpath;
//        NSString *picpath2=model.picpath2;
//        NSString *picpath3=model.picpath3;
//        NSString *picpath4=model.picpath4;
//        
//    }
    for (int i=0; i<headerDatas.count; i++) {
        
//        GoodsDetailImageModel *model = headerDatas[i];
        
        
        //图片
        NSString *string=headerDatas[i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*4/7)];
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

- (void)tapOne:(UITapGestureRecognizer *)tap
{
//    UIImageView *imgView =  (UIImageView *)tap.view;
    
}


- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}


-(void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

@end
