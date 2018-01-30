//
//  AirPlaneDateSelectViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneDateSelectViewController.h"
#import "Color.h"
//UI
#import "CalendarMonthCollectionViewLayout.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarDayCell.h"
//MODEL
#import "CalendarDayModel.h"
#import "AirPlaneCell.h"
#import "AirPlaneCollectionViewLayout.h"
#import "AirPlaneHeaderView.h"
@interface AirPlaneDateSelectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    NSTimer* timer;//定时器
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
    
    NSString *string;
}
@end

@implementation AirPlaneDateSelectViewController

static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initData];
        [self initView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initNav];
    
    [self initWeekView];
    
}

//创建导航栏
-(void)initNav
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"请选择日期";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initWeekView
{
    
    UIView *weekView = [[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 32)];
    [self.view addSubview:weekView];
    
    NSArray *weekArrM = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (int i = 0; i < 7; i++) {
        
        UILabel *StartTime = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/7*i, 10, [UIScreen mainScreen].bounds.size.width/7, 12)];
        StartTime.text = weekArrM[i];
        StartTime.textColor = [UIColor blackColor];
        StartTime.textAlignment = NSTextAlignmentCenter;
        StartTime.font = [UIFont fontWithName:@"PingFang-SC-Light" size:13];
        [weekView addSubview:StartTime];
    }
}
-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)initView{
    
    
    AirPlaneCollectionViewLayout *layout = [AirPlaneCollectionViewLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 108+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-108) collectionViewLayout:layout]; //初始化网格视图大小
    
    [self.collectionView registerClass:[AirPlaneCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID
    
    [self.collectionView registerClass:[AirPlaneHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
    
    //    self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
}



-(void)initData{
    
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
    
}



#pragma mark - CollectionView代理方法

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //    return self.calendarMonth.count;
    return 6;
}


//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:section];
    
    return monthArray.count;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AirPlaneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    
    cell.model = model;
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_Array objectAtIndex:15];
        
        AirPlaneHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%d年 %d月",model.year,model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    return reusableview;
    
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [month_Array objectAtIndex:indexPath.row];
    
    if (model.style == CellDayTypeFutur || model.style == CellDayTypeWeek ||model.style == CellDayTypeClick) {
        
        [self.Logic selectLogic:model];
        
        if (self.calendarblock) {
            
            self.calendarblock(model);//传递数组给上级
            
            timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        }
        [self.collectionView reloadData];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}




//定时器方法
- (void)onTimer{
    
    [timer invalidate];//定时器无效
    
    timer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置方法
- (void)setAirPlaneToDay:(int)day ToDateforString:(NSString *)todate andString:(NSString *)str back:(NSString *)back
{
    
    self.back = back;
    string=str;
    daynumber = day;
    optiondaynumber = 1;//选择一个后返回数据对象
    self.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [self.collectionView reloadData];//刷新
}
//飞机初始化方法
- (void)setAirPlaneToDay:(int)day ToDateforString:(NSString *)todate back:(NSString *)back
{
    
    self.back = back;
    
    daynumber = day;
    optiondaynumber = 1;//选择一个后返回数据对象
    self.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [self.collectionView reloadData];//刷新
}

//酒店初始化方法
- (void)setHotelToDay:(int)day ToDateforString:(NSString *)todate
{
    
    daynumber = day;
    optiondaynumber = 2;//选择两个后返回数据对象
    self.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [self.collectionView reloadData];//刷新
}


//火车初始化方法
- (void)setTrainToDay:(int)day ToDateforString:(NSString *)todate
{
    daynumber = day;
    optiondaynumber = 1;//选择一个后返回数据对象
    self.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [self.collectionView reloadData];//刷新
    
}



#pragma mark - 逻辑代码初始化

//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate
{
    
    NSDate *date = [NSDate date];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    self.Logic = [[CalendarLogic alloc]init];
    
    if ([self.back isEqualToString:@"100"]) {
        return [self.Logic reloadCalendarView:date selectDate:[[NSDateFormatter shareDateFormatter] dateFromString:string]  needDays:day ChuanRu:todate Back:self.back];
    }else
    {
    return [self.Logic reloadCalendarView:date selectDate:selectdate  needDays:day ChuanRu:[[NSDateFormatter shareDateFormatter]stringFromDate:date] Back:self.back];
    }
}


@end
