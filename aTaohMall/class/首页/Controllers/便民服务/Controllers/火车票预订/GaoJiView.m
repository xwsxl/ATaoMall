//
//  GaoJiView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "GaoJiView.h"

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface GaoJiView ()
{
    UIImageView *Wanimg;
    UIImageView *Duanimg;
    UIImageView *zaoimg;
    
    
    
    UIView *RightView1;
    UIView *RightView2;
    UIView *RightView3;
    
    UIScrollView *scrollView1;
    UIScrollView *scrollView2;
    UIScrollView *scrollView3;
    
    NSMutableArray *selectFromArr;
    NSMutableArray *selectToArr;
    NSMutableArray *selectSitArr;
    
    int RemoveAll;
    
}

@property(nonatomic,strong)NSMutableArray *fromStationArr;
@property(nonatomic,strong)NSMutableArray *toStationArr;
@property(nonatomic,strong)NSMutableArray *sitTypeArr;

@end

@implementation GaoJiView


//-(void)setStart:(NSArray *)start
//{
//    
//    _start = start;
//    
//
//    for (int i=0; i<_start.count; i++) {
//        NSLog(@"%@",_start[i]);
//        
//    }
//}
//
//-(void)setEnd:(NSArray *)end
//{
//    _end = end;
//    
//    for (int i=0; i<_end.count; i++) {
//        NSLog(@"%@",_end[i]);
//        UILabel *shareLabel=(UILabel *)[self viewWithTag:i+2021];
//        
//    }
//}
-(NSArray *)sitType
{
    if (!_sitType) {
        _sitType=@[@"不限",@"无座",@"硬座",@"硬卧",@"软卧",@"一等座",@"二等座",@"商务座",@"特等座"];
    }
    return _sitType;
}
-(NSMutableArray *)sitTypeArr
{
    if (!_sitTypeArr) {
        _sitTypeArr=[[NSMutableArray alloc]init];
    }
    return _sitTypeArr;
}
-(NSMutableArray *)fromStationArr
{
    if (!_fromStationArr) {
        _fromStationArr=[[NSMutableArray alloc]init];
    }
    return _fromStationArr;
}
-(NSMutableArray *)toStationArr
{
    if (!_toStationArr) {
        _toStationArr=[[NSMutableArray alloc]init];
    }
    return _toStationArr;
}

/**
 高级筛选视图初始化方法

 @param frame 视图frame
 @param startArray 出发站数组
 @param endArray 到达站数组
 @return 初始化高级筛选视图
 */
- (id)initWithFrame:(CGRect)frame withStart:(NSArray *)startArray andEndArray:(NSArray *)endArray{
    self = [super initWithFrame:frame];
    _start=startArray;
    _end=endArray;
    
    RemoveAll = 10;
    
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 290)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 40)];
        selectView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [_shareListView addSubview:selectView];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (40-14)/2, 50, 14)];
        leftLabel.text = @"取消";
        leftLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
        leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [selectView addSubview:leftLabel];
        
        UIControl *shareControl1 = [[UIControl alloc]initWithFrame:CGRectMake(15, 0, 50, 40)];
        [_shareListView addSubview:shareControl1];
        [shareControl1 addTarget:self action:@selector(shareControl1:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *DeleteLabel = [[UILabel alloc] initWithFrame:CGRectMake((UIBounds.size.width-80)/2, (40-30)/2, 80, 30)];
        DeleteLabel.text = @"清空筛选";
        DeleteLabel.backgroundColor=[UIColor whiteColor];
        DeleteLabel.textAlignment = NSTextAlignmentCenter;
        DeleteLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
        DeleteLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        DeleteLabel.layer.cornerRadius = 3;
        DeleteLabel.layer.masksToBounds = YES;
        [selectView addSubview:DeleteLabel];
        
        UIControl *shareControl2 = [[UIControl alloc]initWithFrame:CGRectMake((UIBounds.size.width-80)/2, 0, 80, 40)];
        [_shareListView addSubview:shareControl2];
        [shareControl2 addTarget:self action:@selector(shareControl2:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *OKLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-65, (40-14)/2, 50, 14)];
        OKLabel.text = @"确定";
        OKLabel.textAlignment = NSTextAlignmentRight;
        OKLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
        OKLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [selectView addSubview:OKLabel];
        
        UIControl *shareControl3 = [[UIControl alloc]initWithFrame:CGRectMake(UIBounds.size.width-65, 0, 50, 40)];
        [_shareListView addSubview:shareControl3];
        [shareControl3 addTarget:self action:@selector(shareControl3:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *LeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 95, 290-40)];
        LeftView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [_shareListView addSubview:LeftView];
        
        NSArray *titleArray = @[@"出发站 ",@"到达站 ",@"坐席类型"];
        
        for (int i=0; i < 3; i++) {
            
            UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*i, 95, 50)];
            if (i==0) {
                shareLabel.backgroundColor=[UIColor whiteColor];
            }
            shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
            shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
            shareLabel.text = [titleArray objectAtIndex:i];
            shareLabel.tag = i+2;
            shareLabel.textAlignment = NSTextAlignmentCenter;

            
            [LeftView addSubview:shareLabel];
            
            UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 21+50*i, 8, 8)];
            
            IV.tag=1234+i;
            
            [LeftView addSubview:IV];

            
            
            
            UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 50*i, 95, 50)];
            shareControl.tag = i+1;
            [LeftView addSubview:shareControl];
            [shareControl addTarget:self action:@selector(shareControl4:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [self initView3];
        [self initView1];
        [self initView2];
        RightView1.hidden=NO;
        RightView2.hidden=YES;
        RightView3.hidden=YES;
        scrollView1.hidden=NO;
        scrollView2.hidden=YES;
        scrollView3.hidden=YES;
    }
    return self;
}

- (void)showInView:(UIView *) view {
    if (self.isHidden) {
        self.hidden = NO;
        if (_huiseControl.superview==nil) {
            [view addSubview:_huiseControl];
        }
        [UIView animateWithDuration:0.2 animations:^{
            _huiseControl.alpha=1;
        }];
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [self.layer addAnimation:animation forKey:@"animation1"];
        self.frame = CGRectMake(0,view.frame.size.height - 290, UIBounds.size.width, 290);
        [view addSubview:self];
    }
    [self getSelectStationAndSitType2];
    
}


- (void)hideInView {
    if (!self.isHidden) {
        self.hidden = YES;
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [self.layer addAnimation:animation forKey:@"animtion2"];
        [UIView animateWithDuration:0.2 animations:^{
            _huiseControl.alpha=0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)shareControl1:(UIControl *)sender
{
    NSLog(@"取消");
    
    [self initViewWhenCancle];
    [self hideInView];
}

- (void)shareControl2:(UIControl *)sender
{
    NSLog(@"清除");
    
    RemoveAll = 20;
    
    [selectSitArr removeAllObjects];
    [selectToArr removeAllObjects];
    [selectFromArr removeAllObjects];
    
    for (int i=0; i<_start.count; i++) {
        
        if (i==0) {
            
            UIImageView *label = (UIImageView *)[self viewWithTag:1011];
            label.image = [UIImage imageNamed:@"选中"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:1000];
            shareControl.selected = YES;
        }else{
            
            UIImageView *label = (UIImageView *)[self viewWithTag:i+1011];
            label.image = [UIImage imageNamed:@"未选中框"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
            shareControl.selected = NO;
        }
        
    }
    for (int i=0; i<_end.count; i++) {
        
        if (i==0) {
            
            UIImageView *label = (UIImageView *)[self viewWithTag:2011];
            label.image = [UIImage imageNamed:@"选中"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:2000];
            shareControl.selected = YES;
        }else{
            
            UIImageView *label = (UIImageView *)[self viewWithTag:i+2011];
            label.image = [UIImage imageNamed:@"未选中框"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
            shareControl.selected = NO;
        }
        
        
    }
    for (int i=0; i<_sitType.count; i++) {
        
        if (i==0) {
            
            UIImageView *label = (UIImageView *)[self viewWithTag:3011];
            label.image = [UIImage imageNamed:@"选中"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:3000];
            shareControl.selected = YES;
            
        }else{
            
            UIImageView *label = (UIImageView *)[self viewWithTag:i+3011];
            label.image = [UIImage imageNamed:@"未选中框"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
            shareControl.selected = NO;
        }
        
        
    }
  //  [self reloadInputViews];
}

- (void)shareControl3:(UIControl *)sender
{
    NSLog(@"确定");
    
    NSString *fromStationString=[NSString string];
    NSString *toStationString=[NSString string];
    NSString *sitTypeString=[NSString string];
    
    if (RemoveAll == 20) {
        
        fromStationString = @"";
        toStationString = @"";
        sitTypeString = @"";
        
        [self.delegate fromString:fromStationString  ToStationString:toStationString SitTypeString:sitTypeString];
        NSLog(@"from111=%@,to=%@,sittype=%@",fromStationString,toStationString,sitTypeString);
        
    }else{
        
        [self getSelectStationAndSitType];
        
        for (NSString *string1 in _fromStationArr) {
            fromStationString=[fromStationString stringByAppendingString:[NSString stringWithFormat:@"%@,",string1]];
        }
        for (NSString *string2 in _toStationArr) {
            toStationString=[toStationString stringByAppendingString:[NSString stringWithFormat:@"%@,",string2]];
        }
        for (NSString *string3 in _sitTypeArr) {
            sitTypeString=[sitTypeString stringByAppendingString:[NSString stringWithFormat:@"%@,",string3]];
        }
        if (fromStationString.length>0) {
            fromStationString=[fromStationString substringToIndex:fromStationString.length-1];
        }
        if (toStationString.length>0) {
            toStationString=[toStationString substringToIndex:toStationString.length-1];
        }
        if (sitTypeString.length>0) {
            sitTypeString=[sitTypeString substringToIndex:sitTypeString.length-1];
        }
        
        [self.delegate fromString:fromStationString  ToStationString:toStationString SitTypeString:sitTypeString];
        NSLog(@"from222=%@,to=%@,sittype=%@",fromStationString,toStationString,sitTypeString);
        
    }
    
    RemoveAll = 10;
    
    [self hideInView];
}

#pragma-mark 获取选中的车站
-(void)getSelectStationAndSitType
{
    [self.fromStationArr removeAllObjects];
    [self.toStationArr removeAllObjects];
    [self.sitTypeArr removeAllObjects];
    
    for (int i=0; i<_start.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
        if (shareControl.selected==YES)
        {
            if (i==0) {
                [self.fromStationArr addObject:@""];
            }
            else
            {
            [self.fromStationArr addObject:_start[i]];
            }
        }
    }
    for (int i=0; i<_end.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
        if (shareControl.selected==YES)
        {
            if (i==0) {
                [self.toStationArr addObject:@""];
            }else
            {
            [self.toStationArr addObject:_end[i]];
            }
        }
    }
    for (int i=0; i<_sitType.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
        if (shareControl.selected==YES)
        {
            NSString *string=[NSString string];
            if ([_sitType[i] isEqualToString:@"无座"]) {
                string=@"wz_price";
            }else if ([_sitType[i] isEqualToString:@"硬座"]){
                string=@"yz_price";
            }else if ([_sitType[i] isEqualToString:@"硬卧"]){
                string=@"yw_price";
            }else if ([_sitType[i] isEqualToString:@"软卧"]){
                string=@"rw_price";
            }else if ([_sitType[i] isEqualToString:@"一等座"]){
                string=@"ydz_price";
            }else if ([_sitType[i] isEqualToString:@"二等座"]){
                string=@"edz_price";
            }else if ([_sitType[i] isEqualToString:@"商务座"]){
                string=@"swz_price";
            }else if ([_sitType[i] isEqualToString:@"特等座"])
            {
                string=@"tdz_price";
            }else
            {
                string=@"";
            }
            [self.sitTypeArr addObject:string];
        }
    }
    
}
-(void)getSelectStationAndSitType2
{
    selectFromArr=[[NSMutableArray alloc]init];
    selectToArr=[[NSMutableArray alloc]init];
    selectSitArr=[[NSMutableArray alloc]init];
    [selectSitArr removeAllObjects];
    [selectToArr removeAllObjects];
    [selectFromArr removeAllObjects];
    for (int i=0; i<_start.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
        if (shareControl.selected==YES)
        {
            [selectFromArr addObject:_start[i]];
            
        }
    }
    for (int i=0; i<_end.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
        if (shareControl.selected==YES)
        {
            [selectToArr addObject:_end[i]];
        }
    }
    for (int i=0; i<_sitType.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
        if (shareControl.selected==YES)
        {
            [selectSitArr addObject:_sitType[i]];
        }
    }
}
#pragma-mark 加载对应出发站、到达站、坐席类别视图、
- (void)shareControl4:(UIControl *)sender
{
    
    if (sender.tag+1==2) {
        
        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+1];
        label.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = (UILabel *)[self viewWithTag:3];
        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
        UILabel *label2 = (UILabel *)[self viewWithTag:4];
        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        RightView1.hidden=NO;
        RightView2.hidden=YES;
        RightView3.hidden=YES;
        scrollView1.hidden=NO;
        scrollView2.hidden=YES;
        scrollView3.hidden=YES;
        
        
    }else if(sender.tag+1==3){
        
        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+1];
        label.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = (UILabel *)[self viewWithTag:2];
        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
        UILabel *label2 = (UILabel *)[self viewWithTag:4];
        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        RightView1.hidden=YES;
        RightView2.hidden=NO;
        RightView3.hidden=YES;
        scrollView1.hidden=YES;
        scrollView2.hidden=NO;
        scrollView3.hidden=YES;
        
        
    }else{
        
        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+1];
        label.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = (UILabel *)[self viewWithTag:2];
        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
        UILabel *label2 = (UILabel *)[self viewWithTag:3];
        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        RightView1.hidden=YES;
        RightView2.hidden=YES;
        RightView3.hidden=NO;
        scrollView1.hidden=YES;
        scrollView2.hidden=YES;
        scrollView3.hidden=NO;
    }
    
    
    NSLog(@"点击的第%ld个",(long)sender.tag);
    
}
#pragma-出发站选择
-(void)initView1
{
    scrollView1=[[UIScrollView alloc]initWithFrame:CGRectMake(95, 40, UIBounds.size.width, 290-40)];
    
    [_shareListView addSubview:scrollView1];
    RightView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, self.start.count*50)];
    RightView1.backgroundColor = [UIColor whiteColor];
    scrollView1.contentSize=RightView1.frame.size;
    [scrollView1 addSubview:RightView1];
//    RightView1 = [[UIView alloc] initWithFrame:CGRectMake(80, 40, UIBounds.size.width-80, 290-40)];
//    RightView1.backgroundColor = [UIColor whiteColor];
//    [_shareListView addSubview:RightView1];

    for (int i=0; i < _start.count; i++) {
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-95, 50)];
        [RightView1 addSubview:view1];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-95, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view1 addSubview:line3];
        
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 80, 13)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];

//shareLabel.text = [titleArray objectAtIndex:i];
        shareLabel.text=[_start objectAtIndex:i];
        shareLabel.tag=1021+i;
        shareLabel.text=_start[i];
        shareLabel.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:shareLabel];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-95-20-16, (50-21)/2, 20, 21)];
        line4.image = [UIImage imageNamed:@"未选中框"];
        if(i==0)
        {
            line4.image=[UIImage imageNamed:@"选中"];
        }
        line4.tag=i+1011;
        
        [view1 addSubview:line4];

        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, 50)];
        shareControl.tag = i+1000;
        [view1 addSubview:shareControl];
        [shareControl addTarget:self action:@selector(shareControl5:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
#pragma-到站选择
-(void)initView2
{
    
//    RightView2 = [[UIView alloc] initWithFrame:CGRectMake(80, 40, UIBounds.size.width-80, 290-40)];
//    RightView2.backgroundColor = [UIColor whiteColor];
//    [_shareListView addSubview:RightView2];
    scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(95, 40, UIBounds.size.width, 290-40)];
    
    [_shareListView addSubview:scrollView2];
    RightView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, self.end.count*50)];
    RightView2.backgroundColor = [UIColor whiteColor];
    scrollView2.contentSize=RightView2.frame.size;
    [scrollView2 addSubview:RightView2];
   NSArray *titleArray = @[@"不限",@"北京东",@"北京西",@"北京南"];
    
    for (int i=0; i <_end.count; i++) {
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-95, 50)];
        [RightView2 addSubview:view1];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-95, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view1 addSubview:line3];
        
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 80, 13)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
// shareLabel.text = [titleArray objectAtIndex:i];
        shareLabel.text = [_end objectAtIndex:i];
        shareLabel.tag=i+2021;
        shareLabel.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:shareLabel];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-95-20-16, (50-21)/2, 20, 21)];
        line4.image = [UIImage imageNamed:@"未选中框"];
        if(i==0)
        {
            line4.image=[UIImage imageNamed:@"选中"];
        }
        line4.tag=i+2011;
        shareLabel.text=_end[i];
        [view1 addSubview:line4];
        
        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, 50)];
        shareControl.tag = i+2000;
        [view1 addSubview:shareControl];
        [shareControl addTarget:self action:@selector(shareControl6:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
#pragma-坐席选择
-(void)initView3
{
    scrollView3=[[UIScrollView alloc]initWithFrame:CGRectMake(95, 40, UIBounds.size.width, 290-40)];
    
    [_shareListView addSubview:scrollView3];
    RightView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, self.sitType.count*50)];
    RightView3.backgroundColor = [UIColor whiteColor];
    scrollView3.contentSize=RightView3.frame.size;
    [scrollView3 addSubview:RightView3];

  //  NSArray *titleArray = @[@"不限",@"无座",@"硬座",@"硬卧",@"软卧",@"一等座",@"二等座",@"商务座"];
    
    for (int i=0; i < self.sitType.count; i++) {
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-95, 50)];
        [RightView3 addSubview:view1];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-95, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view1 addSubview:line3];
        
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 80, 13)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        shareLabel.text = [_sitType objectAtIndex:i];
        shareLabel.tag=i+3021;
        shareLabel.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:shareLabel];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-95-20-16, (50-21)/2, 20, 21)];
        line4.image = [UIImage imageNamed:@"未选中框"];
        line4.tag=i+3011;
        if(i==0)
        {
            line4.image=[UIImage imageNamed:@"选中"];
        }
        [view1 addSubview:line4];
        
        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, 50)];
        shareControl.tag = i+3000;
        [view1 addSubview:shareControl];
        [shareControl addTarget:self action:@selector(shareControl7:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}

- (void)shareControl5:(UIControl *)sender
{
    if (sender.selected) {
        
        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
        label.image = [UIImage imageNamed:@"未选中框"];
        
    }else
    {
        if(sender.tag==1000)
        {
            for (int i=1; i<_start.count;i++ ) {
                UIImageView *label = (UIImageView *)[self viewWithTag:i+1011];
                label.image = [UIImage imageNamed:@"未选中框"];
                UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
                shareControl.selected = NO;
            }
        }else
        {
            UIImageView *label = (UIImageView *)[self viewWithTag:1011];
            label.image = [UIImage imageNamed:@"未选中框"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:1000];
            shareControl.selected = NO;
        }
        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
        label.image = [UIImage imageNamed:@"选中"];
        
    }
    sender.selected=!sender.selected;
    int count=0;
    for (int i=0; i<_start.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
        if (shareControl.selected==NO) {
            count++;
        }
    }
    if (count==_start.count) {
        UIImageView *label = (UIImageView *)[self viewWithTag:1011];
        label.image = [UIImage imageNamed:@"选中"];
        UIControl *shareControl = (UIControl *)[self viewWithTag:1000];
        shareControl.selected = YES;
    }
    
    int icount=0;
    for (int i=1; i<_start.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
        if (shareControl.selected==YES) {
            icount++;
        }
    }
    if (icount>0)
    {
        UIImageView *IV=(UIImageView *)[self viewWithTag:1234];
        
        IV.image=[UIImage imageNamed:@"icon-point"];
        
        UILabel *sharelabel=[self viewWithTag:2];
        sharelabel.text=@"  出发站 ";
        
    }
    UIControl *shareCon=(UIControl *)[self viewWithTag:1000];
    if (shareCon.selected==YES) {
        UIImageView *IV=(UIImageView *)[self viewWithTag:1234];
        
        IV.image=[UIImage imageNamed:@""];
        
        UILabel *sharelabel=[self viewWithTag:2];
        sharelabel.text=@"出发站 ";

    }
    
    
    

}
- (void)shareControl6:(UIControl *)sender
{
    if (sender.selected) {
        
        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
        label.image = [UIImage imageNamed:@"未选中框"];
        
    }else
    {
        if(sender.tag==2000)
        {
            for (int i=1; i<_end.count;i++ ) {
                UIImageView *label = (UIImageView *)[self viewWithTag:i+2011];
                label.image = [UIImage imageNamed:@"未选中框"];
                UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
                shareControl.selected = NO;
            }
        }else
        {
            UIImageView *label = (UIImageView *)[self viewWithTag:2011];
            label.image = [UIImage imageNamed:@"未选中框"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:2000];
            shareControl.selected = NO;
        }
        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
        label.image = [UIImage imageNamed:@"选中"];

        
    }
    sender.selected=!sender.selected;
    int count=0;
    for (int i=0; i<_end.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
        if (shareControl.selected==NO) {
            count++;
        }
    }
    if (count==_end.count) {
        UIImageView *label = (UIImageView *)[self viewWithTag:2011];
        label.image = [UIImage imageNamed:@"选中"];
        UIControl *shareControl = (UIControl *)[self viewWithTag:2000];
        shareControl.selected = YES;
    }
    int icount=0;
    for (int i=1; i<_end.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
        if (shareControl.selected==YES) {
            icount++;
        }
    }
    if (icount>0)
    {
        UIImageView *IV=(UIImageView *)[self viewWithTag:1235];
        
        IV.image=[UIImage imageNamed:@"icon-point"];
        
        UILabel *sharelabel=[self viewWithTag:3];
        sharelabel.text=@"  到达站 ";
        
    }
    UIControl *shareCon=(UIControl *)[self viewWithTag:2000];
    if (shareCon.selected==YES) {
        UIImageView *IV=(UIImageView *)[self viewWithTag:1235];
        
        IV.image=[UIImage imageNamed:@""];
        
        UILabel *sharelabel=[self viewWithTag:3];
        sharelabel.text=@"到达站 ";
        
    }
}
- (void)shareControl7:(UIControl *)sender
{
    if (sender.selected) {
    
        
        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
        label.image = [UIImage imageNamed:@"未选中框"];
    }else
    {
        if(sender.tag==3000)
        {
            for (int i=1; i<_sitType.count;i++ ) {
                UIImageView *label = (UIImageView *)[self viewWithTag:i+3011];
                label.image = [UIImage imageNamed:@"未选中框"];
                UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
                shareControl.selected = NO;
            }
        }else
        {
            UIImageView *label = (UIImageView *)[self viewWithTag:3011];
            label.image = [UIImage imageNamed:@"未选中框"];
            UIControl *shareControl = (UIControl *)[self viewWithTag:3000];
            shareControl.selected = NO;
        }
        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
        label.image = [UIImage imageNamed:@"选中"];

    }
    sender.selected=!sender.selected;
    int count=0;
    for (int i=0; i<_sitType.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
        if (shareControl.selected==NO) {
            count++;
        }
    }
    if (count==_sitType.count) {
        UIImageView *label = (UIImageView *)[self viewWithTag:3011];
        label.image = [UIImage imageNamed:@"选中"];
        UIControl *shareControl = (UIControl *)[self viewWithTag:3000];
        shareControl.selected = YES;
    }
    int icount=0;
    for (int i=1; i<_sitType.count; i++) {
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
        if (shareControl.selected==YES) {
            icount++;
        }
    }
    if (icount>0)
    {
        UIImageView *IV=(UIImageView *)[self viewWithTag:1236];
        
        IV.image=[UIImage imageNamed:@"icon-point"];
        
        UILabel *sharelabel=[self viewWithTag:4];
        sharelabel.text=@"   坐席类型";
        
    }
    UIControl *shareCon=(UIControl *)[self viewWithTag:3000];
    if (shareCon.selected==YES) {
        UIImageView *IV=(UIImageView *)[self viewWithTag:1236];
        
        IV.image=[UIImage imageNamed:@""];
        
        UILabel *sharelabel=[self viewWithTag:4];
        sharelabel.text=@"坐席类型";
        
    }
}

-(void)huiseControlClick{

    [self initViewWhenCancle];
    [self hideInView];
}

-(void)initViewWhenCancle
{
    
    
    for (int i=0; i<_start.count; i++) {
        UILabel *label=(UILabel *)[self viewWithTag:1021+i];
        UIImageView *line=(UIImageView *)[self viewWithTag:1011+i];
        line.image=[UIImage imageNamed:@"未选中框"];
        UIControl *shareControll=(UIControl *)[self viewWithTag:1000+i];
        shareControll.selected=NO;
        
        for (int j=0; j<selectFromArr.count; j++) {
            if ([selectFromArr[j] isEqualToString:@""]) {
                UIImageView *line2=(UIImageView *)[self viewWithTag:1011];
                line2.image=[UIImage imageNamed:@"选中"];
                UIControl *shareControll2=(UIControl *)[self viewWithTag:1000];
                shareControll2.selected=YES;
            }
            
            if ([label.text isEqualToString:selectFromArr[j]]) {
                line.image=[UIImage imageNamed:@"选中"];
                shareControll.selected=YES;
            }
        }
        if (selectFromArr.count==0) {
            UIImageView *line2=(UIImageView *)[self viewWithTag:1011];
            line2.image=[UIImage imageNamed:@"选中"];
            UIControl *shareControll2=(UIControl *)[self viewWithTag:1000];
            shareControll2.selected=YES;
        }
    }
    
    for (int i=0; i<_end.count; i++) {
        UILabel *label=(UILabel *)[self viewWithTag:2021+i];
        UIImageView *line=(UIImageView *)[self viewWithTag:2011+i];
        line.image=[UIImage imageNamed:@"未选中框"];
        UIControl *shareControll=(UIControl *)[self viewWithTag:2000+i];
        shareControll.selected=NO;
        
        for (int j=0; j<selectToArr.count; j++) {
    
            if ([label.text isEqualToString:selectToArr[j]]) {
                line.image=[UIImage imageNamed:@"选中"];
                shareControll.selected=YES;
            }
        }
        if (selectToArr.count==0) {
            UIImageView *line2=(UIImageView *)[self viewWithTag:2011];
            line2.image=[UIImage imageNamed:@"选中"];
            UIControl *shareControll2=(UIControl *)[self viewWithTag:2000];
            shareControll2.selected=YES;
        }
    }
    
    for (int i=0; i<_sitType.count; i++) {
        UILabel *label=(UILabel *)[self viewWithTag:3021+i];
        UIImageView *line=(UIImageView *)[self viewWithTag:3011+i];
        line.image=[UIImage imageNamed:@"未选中框"];
        UIControl *shareControll=(UIControl *)[self viewWithTag:3000+i];
        shareControll.selected=NO;
        
        for (int j=0; j<selectSitArr.count; j++) {
          
            if ([label.text isEqualToString:selectSitArr[j]]) {
                line.image=[UIImage imageNamed:@"选中"];
                shareControll.selected=YES;
            }
        }
        if (selectSitArr.count==0) {
            UIImageView *line2=(UIImageView *)[self viewWithTag:3011];
            line2.image=[UIImage imageNamed:@"选中"];
            UIControl *shareControll2=(UIControl *)[self viewWithTag:3000];
            shareControll2.selected=YES;
        }
    }
    UIControl *shareControll1=(UIControl *)[self viewWithTag:1000];
    UIControl *shareControll2=(UIControl *)[self viewWithTag:2000];
    UIControl *shareControll3=(UIControl *)[self viewWithTag:3000];
    if (shareControll1.selected&&shareControll2.selected&&shareControll3.selected) {
        [self.delegate setUnselect];
    }
}


@end
//
//#import "GaoJiView.h"
//
//#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
//#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
//
//@interface GaoJiView ()
//{
//    UIImageView *Wanimg;
//    UIImageView *Duanimg;
//    UIImageView *zaoimg;
//    
//    
//    
//    UIView *RightView1;
//    UIView *RightView2;
//    UIView *RightView3;
//    
//    UIScrollView *scrollView1;
//    UIScrollView *scrollView2;
//    UIScrollView *scrollView3;
//    
//    NSMutableArray *selectFromArr;
//    NSMutableArray *selectToArr;
//    NSMutableArray *selectSitArr;
//    
//    int RemoveAll;
//    
//}
//
//@property(nonatomic,strong)NSMutableArray *fromStationArr;
//@property(nonatomic,strong)NSMutableArray *toStationArr;
//@property(nonatomic,strong)NSMutableArray *sitTypeArr;
//
//@end
//
//@implementation GaoJiView
//
//
////-(void)setStart:(NSArray *)start
////{
////
////    _start = start;
////
////
////    for (int i=0; i<_start.count; i++) {
////        NSLog(@"%@",_start[i]);
////
////    }
////}
////
////-(void)setEnd:(NSArray *)end
////{
////    _end = end;
////
////    for (int i=0; i<_end.count; i++) {
////        NSLog(@"%@",_end[i]);
////        UILabel *shareLabel=(UILabel *)[self viewWithTag:i+2021];
////
////    }
////}
//-(NSArray *)sitType
//{
//    if (!_sitType) {
//        _sitType=@[@"不限",@"无座",@"硬座",@"硬卧",@"软卧",@"一等座",@"二等座",@"商务座",@"特等座"];
//    }
//    return _sitType;
//}
//-(NSMutableArray *)sitTypeArr
//{
//    if (!_sitTypeArr) {
//        _sitTypeArr=[[NSMutableArray alloc]init];
//    }
//    return _sitTypeArr;
//}
//-(NSMutableArray *)fromStationArr
//{
//    if (!_fromStationArr) {
//        _fromStationArr=[[NSMutableArray alloc]init];
//    }
//    return _fromStationArr;
//}
//-(NSMutableArray *)toStationArr
//{
//    if (!_toStationArr) {
//        _toStationArr=[[NSMutableArray alloc]init];
//    }
//    return _toStationArr;
//}
//
///**
// 高级筛选视图初始化方法
// 
// @param frame 视图frame
// @param startArray 出发站数组
// @param endArray 到达站数组
// @return 初始化高级筛选视图
// */
//- (id)initWithFrame:(CGRect)frame withStart:(NSArray *)startArray andEndArray:(NSArray *)endArray{
//    self = [super initWithFrame:frame];
//    _start=startArray;
//    _end=endArray;
//    
//    RemoveAll = 10;
//    
//    if (self) {
//        self.hidden = YES;
//        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
//        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
//        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
//        _huiseControl.alpha=0;
//        self.backgroundColor = [UIColor whiteColor];
//        
//        
//        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 290)];
//        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
//        [self addSubview:_shareListView];
//        
//        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 40)];
//        selectView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//        [_shareListView addSubview:selectView];
//        
//        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (40-14)/2, 50, 14)];
//        leftLabel.text = @"取消";
//        leftLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
//        leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
//        [selectView addSubview:leftLabel];
//        
//        UIControl *shareControl1 = [[UIControl alloc]initWithFrame:CGRectMake(15, 0, 50, 40)];
//        [_shareListView addSubview:shareControl1];
//        [shareControl1 addTarget:self action:@selector(shareControl1:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UILabel *DeleteLabel = [[UILabel alloc] initWithFrame:CGRectMake((UIBounds.size.width-80)/2, (40-30)/2, 80, 30)];
//        DeleteLabel.text = @"清空筛选";
//        DeleteLabel.backgroundColor=[UIColor whiteColor];
//        DeleteLabel.textAlignment = NSTextAlignmentCenter;
//        DeleteLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
//        DeleteLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
//        DeleteLabel.layer.cornerRadius = 3;
//        DeleteLabel.layer.masksToBounds = YES;
//        [selectView addSubview:DeleteLabel];
//        
//        UIControl *shareControl2 = [[UIControl alloc]initWithFrame:CGRectMake((UIBounds.size.width-80)/2, 0, 80, 40)];
//        [_shareListView addSubview:shareControl2];
//        [shareControl2 addTarget:self action:@selector(shareControl2:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UILabel *OKLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-65, (40-14)/2, 50, 14)];
//        OKLabel.text = @"确定";
//        OKLabel.textAlignment = NSTextAlignmentRight;
//        OKLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
//        OKLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
//        [selectView addSubview:OKLabel];
//        
//        UIControl *shareControl3 = [[UIControl alloc]initWithFrame:CGRectMake(UIBounds.size.width-65, 0, 50, 40)];
//        [_shareListView addSubview:shareControl3];
//        [shareControl3 addTarget:self action:@selector(shareControl3:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        UIView *LeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 80, 290-40)];
//        LeftView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//        [_shareListView addSubview:LeftView];
//        
//        NSArray *titleArray = @[@"出发站",@"到达站",@"坐席类型"];
//        
//        for (int i=0; i < 3; i++) {
//            
//            UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*i, 80, 50)];
//            if (i==0) {
//                shareLabel.backgroundColor=[UIColor whiteColor];
//            }
//            shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
//            shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
//            shareLabel.text = [titleArray objectAtIndex:i];
//            shareLabel.tag = i+2;
//            shareLabel.textAlignment = NSTextAlignmentCenter;
//            [LeftView addSubview:shareLabel];
//            
//            UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 50*i, 80, 50)];
//            shareControl.tag = i+1;
//            [LeftView addSubview:shareControl];
//            [shareControl addTarget:self action:@selector(shareControl4:) forControlEvents:UIControlEventTouchUpInside];
//            
//        }
//        [self initView3];
//        [self initView1];
//        [self initView2];
//        RightView1.hidden=NO;
//        RightView2.hidden=YES;
//        RightView3.hidden=YES;
//        scrollView1.hidden=NO;
//        scrollView2.hidden=YES;
//        scrollView3.hidden=YES;
//    }
//    return self;
//}
//
//
//- (void)showInView:(UIView *) view {
//    if (self.isHidden) {
//        self.hidden = NO;
//        if (_huiseControl.superview==nil) {
//            [view addSubview:_huiseControl];
//        }
//        [UIView animateWithDuration:0.2 animations:^{
//            _huiseControl.alpha=1;
//        }];
//        CATransition *animation = [CATransition  animation];
//        animation.delegate = self;
//        animation.duration = 0.2f;
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        animation.type = kCATransitionPush;
//        animation.subtype = kCATransitionFromTop;
//        [self.layer addAnimation:animation forKey:@"animation1"];
//        self.frame = CGRectMake(0,view.frame.size.height - 290, UIBounds.size.width, 290);
//        [view addSubview:self];
//    }
//    [self getSelectStationAndSitType2];
//    
//}
//
//
//- (void)hideInView {
//    if (!self.isHidden) {
//        self.hidden = YES;
//        CATransition *animation = [CATransition  animation];
//        animation.delegate = self;
//        animation.duration = 0.2f;
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        animation.type = kCATransitionPush;
//        animation.subtype = kCATransitionFromBottom;
//        [self.layer addAnimation:animation forKey:@"animtion2"];
//        [UIView animateWithDuration:0.2 animations:^{
//            _huiseControl.alpha=0;
//        }completion:^(BOOL finished) {
//            [self removeFromSuperview];
//        }];
//    }
//}
//
//- (void)shareControl1:(UIControl *)sender
//{
//    NSLog(@"取消");
//    
//    [self initViewWhenCancle];
//    [self hideInView];
//}
//
//- (void)shareControl2:(UIControl *)sender
//{
//    NSLog(@"清除");
//    
//    RemoveAll = 20;
//    
//    [selectSitArr removeAllObjects];
//    [selectToArr removeAllObjects];
//    [selectFromArr removeAllObjects];
//    
//    for (int i=0; i<_start.count; i++) {
//        
//        if (i==0) {
//            
//            UIImageView *label = (UIImageView *)[self viewWithTag:1011];
//            label.image = [UIImage imageNamed:@"选中"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:1000];
//            shareControl.selected = YES;
//        }else{
//            
//            UIImageView *label = (UIImageView *)[self viewWithTag:i+1011];
//            label.image = [UIImage imageNamed:@"未选中框"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
//            shareControl.selected = NO;
//        }
//        
//    }
//    for (int i=0; i<_end.count; i++) {
//        
//        if (i==0) {
//            
//            UIImageView *label = (UIImageView *)[self viewWithTag:2011];
//            label.image = [UIImage imageNamed:@"选中"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:2000];
//            shareControl.selected = YES;
//        }else{
//            
//            UIImageView *label = (UIImageView *)[self viewWithTag:i+2011];
//            label.image = [UIImage imageNamed:@"未选中框"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
//            shareControl.selected = NO;
//        }
//        
//        
//    }
//    for (int i=0; i<_sitType.count; i++) {
//        
//        if (i==0) {
//            
//            UIImageView *label = (UIImageView *)[self viewWithTag:3011];
//            label.image = [UIImage imageNamed:@"选中"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:3000];
//            shareControl.selected = YES;
//            
//        }else{
//            
//            UIImageView *label = (UIImageView *)[self viewWithTag:i+3011];
//            label.image = [UIImage imageNamed:@"未选中框"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
//            shareControl.selected = NO;
//        }
//        
//        
//    }
//    //  [self reloadInputViews];
//}
//
//- (void)shareControl3:(UIControl *)sender
//{
//    NSLog(@"确定");
//    
//    NSString *fromStationString=[NSString string];
//    NSString *toStationString=[NSString string];
//    NSString *sitTypeString=[NSString string];
//    
//    if (RemoveAll == 20) {
//        
//        fromStationString = @"";
//        toStationString = @"";
//        sitTypeString = @"";
//        
//        [self.delegate fromString:fromStationString  ToStationString:toStationString SitTypeString:sitTypeString];
//        NSLog(@"from111=%@,to=%@,sittype=%@",fromStationString,toStationString,sitTypeString);
//        
//    }else{
//        
//        [self getSelectStationAndSitType];
//        
//        for (NSString *string1 in _fromStationArr) {
//            fromStationString=[fromStationString stringByAppendingString:[NSString stringWithFormat:@"%@,",string1]];
//        }
//        for (NSString *string2 in _toStationArr) {
//            toStationString=[toStationString stringByAppendingString:[NSString stringWithFormat:@"%@,",string2]];
//        }
//        for (NSString *string3 in _sitTypeArr) {
//            sitTypeString=[sitTypeString stringByAppendingString:[NSString stringWithFormat:@"%@,",string3]];
//        }
//        if (fromStationString.length>0) {
//            fromStationString=[fromStationString substringToIndex:fromStationString.length-1];
//        }
//        if (toStationString.length>0) {
//            toStationString=[toStationString substringToIndex:toStationString.length-1];
//        }
//        if (sitTypeString.length>0) {
//            sitTypeString=[sitTypeString substringToIndex:sitTypeString.length-1];
//        }
//        
//        [self.delegate fromString:fromStationString  ToStationString:toStationString SitTypeString:sitTypeString];
//        NSLog(@"from222=%@,to=%@,sittype=%@",fromStationString,toStationString,sitTypeString);
//        
//    }
//    
//    RemoveAll = 10;
//    
//    [self hideInView];
//}
//
//#pragma-mark 获取选中的车站
//-(void)getSelectStationAndSitType
//{
//    [self.fromStationArr removeAllObjects];
//    [self.toStationArr removeAllObjects];
//    [self.sitTypeArr removeAllObjects];
//    
//    for (int i=0; i<_start.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
//        if (shareControl.selected==YES)
//        {
//            if (i==0) {
//                [self.fromStationArr addObject:@""];
//            }
//            else
//            {
//                [self.fromStationArr addObject:_start[i]];
//            }
//        }
//    }
//    for (int i=0; i<_end.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
//        if (shareControl.selected==YES)
//        {
//            if (i==0) {
//                [self.toStationArr addObject:@""];
//            }else
//            {
//                [self.toStationArr addObject:_end[i]];
//            }
//        }
//    }
//    for (int i=0; i<_sitType.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
//        if (shareControl.selected==YES)
//        {
//            NSString *string=[NSString string];
//            if ([_sitType[i] isEqualToString:@"无座"]) {
//                string=@"wz_price";
//            }else if ([_sitType[i] isEqualToString:@"硬座"]){
//                string=@"yz_price";
//            }else if ([_sitType[i] isEqualToString:@"硬卧"]){
//                string=@"yw_price";
//            }else if ([_sitType[i] isEqualToString:@"软卧"]){
//                string=@"rw_price";
//            }else if ([_sitType[i] isEqualToString:@"一等座"]){
//                string=@"ydz_price";
//            }else if ([_sitType[i] isEqualToString:@"二等座"]){
//                string=@"edz_price";
//            }else if ([_sitType[i] isEqualToString:@"商务座"]){
//                string=@"swz_price";
//            }else if ([_sitType[i] isEqualToString:@"特等座"])
//            {
//                string=@"tdz_price";
//            }else
//            {
//                string=@"";
//            }
//            [self.sitTypeArr addObject:string];
//        }
//    }
//    
//}
//-(void)getSelectStationAndSitType2
//{
//    selectFromArr=[[NSMutableArray alloc]init];
//    selectToArr=[[NSMutableArray alloc]init];
//    selectSitArr=[[NSMutableArray alloc]init];
//    [selectSitArr removeAllObjects];
//    [selectToArr removeAllObjects];
//    [selectFromArr removeAllObjects];
//    for (int i=0; i<_start.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
//        if (shareControl.selected==YES)
//        {
//            [selectFromArr addObject:_start[i]];
//            
//        }
//    }
//    for (int i=0; i<_end.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
//        if (shareControl.selected==YES)
//        {
//            [selectToArr addObject:_end[i]];
//        }
//    }
//    for (int i=0; i<_sitType.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
//        if (shareControl.selected==YES)
//        {
//            [selectSitArr addObject:_sitType[i]];
//        }
//    }
//}
//#pragma-mark 加载对应出发站、到达站、坐席类别视图、
//- (void)shareControl4:(UIControl *)sender
//{
//    
//    if (sender.tag+1==2) {
//        
//        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+1];
//        label.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *label1 = (UILabel *)[self viewWithTag:3];
//        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//        
//        UILabel *label2 = (UILabel *)[self viewWithTag:4];
//        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//        RightView1.hidden=NO;
//        RightView2.hidden=YES;
//        RightView3.hidden=YES;
//        scrollView1.hidden=NO;
//        scrollView2.hidden=YES;
//        scrollView3.hidden=YES;
//        
//        
//    }else if(sender.tag+1==3){
//        
//        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+1];
//        label.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *label1 = (UILabel *)[self viewWithTag:2];
//        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//        
//        UILabel *label2 = (UILabel *)[self viewWithTag:4];
//        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//        RightView1.hidden=YES;
//        RightView2.hidden=NO;
//        RightView3.hidden=YES;
//        scrollView1.hidden=YES;
//        scrollView2.hidden=NO;
//        scrollView3.hidden=YES;
//        
//        
//    }else{
//        
//        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+1];
//        label.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *label1 = (UILabel *)[self viewWithTag:2];
//        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//        
//        UILabel *label2 = (UILabel *)[self viewWithTag:3];
//        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//        RightView1.hidden=YES;
//        RightView2.hidden=YES;
//        RightView3.hidden=NO;
//        scrollView1.hidden=YES;
//        scrollView2.hidden=YES;
//        scrollView3.hidden=NO;
//    }
//    
//    
//    NSLog(@"点击的第%ld个",(long)sender.tag);
//    
//}
//#pragma-出发站选择
//-(void)initView1
//{
//    scrollView1=[[UIScrollView alloc]initWithFrame:CGRectMake(80, 40, UIBounds.size.width, 290-40)];
//    
//    [_shareListView addSubview:scrollView1];
//    RightView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-80, self.start.count*50)];
//    RightView1.backgroundColor = [UIColor whiteColor];
//    scrollView1.contentSize=RightView1.frame.size;
//    [scrollView1 addSubview:RightView1];
//    //    RightView1 = [[UIView alloc] initWithFrame:CGRectMake(80, 40, UIBounds.size.width-80, 290-40)];
//    //    RightView1.backgroundColor = [UIColor whiteColor];
//    //    [_shareListView addSubview:RightView1];
//    
//    for (int i=0; i < _start.count; i++) {
//        
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-80, 50)];
//        [RightView1 addSubview:view1];
//        
//        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-80, 1)];
//        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
//        [view1 addSubview:line3];
//        
//        
//        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, (50-13)/2, 80, 13)];
//        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
//        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
//        
//        //shareLabel.text = [titleArray objectAtIndex:i];
//        shareLabel.text=[_start objectAtIndex:i];
//        shareLabel.tag=1021+i;
//        shareLabel.text=_start[i];
//        shareLabel.textAlignment = NSTextAlignmentCenter;
//        [view1 addSubview:shareLabel];
//        
//        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-20-16, (50-21)/2, 20, 21)];
//        line4.image = [UIImage imageNamed:@"未选中框"];
//        if(i==0)
//        {
//            line4.image=[UIImage imageNamed:@"选中"];
//        }
//        line4.tag=i+1011;
//        
//        [view1 addSubview:line4];
//        
//        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-80, 50)];
//        shareControl.tag = i+1000;
//        [view1 addSubview:shareControl];
//        [shareControl addTarget:self action:@selector(shareControl5:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    
//}
//#pragma-到站选择
//-(void)initView2
//{
//    
//    //    RightView2 = [[UIView alloc] initWithFrame:CGRectMake(80, 40, UIBounds.size.width-80, 290-40)];
//    //    RightView2.backgroundColor = [UIColor whiteColor];
//    //    [_shareListView addSubview:RightView2];
//    scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(80, 40, UIBounds.size.width, 290-40)];
//    
//    [_shareListView addSubview:scrollView2];
//    RightView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-80, self.end.count*50)];
//    RightView2.backgroundColor = [UIColor whiteColor];
//    scrollView2.contentSize=RightView2.frame.size;
//    [scrollView2 addSubview:RightView2];
//    NSArray *titleArray = @[@"不限",@"北京东",@"北京西",@"北京南"];
//    
//    for (int i=0; i <_end.count; i++) {
//        
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-80, 50)];
//        [RightView2 addSubview:view1];
//        
//        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-80, 1)];
//        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
//        [view1 addSubview:line3];
//        
//        
//        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, (50-13)/2, 80, 13)];
//        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
//        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
//        // shareLabel.text = [titleArray objectAtIndex:i];
//        shareLabel.text = [_end objectAtIndex:i];
//        shareLabel.tag=i+2021;
//        shareLabel.textAlignment = NSTextAlignmentCenter;
//        [view1 addSubview:shareLabel];
//        
//        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-20-16, (50-21)/2, 20, 21)];
//        line4.image = [UIImage imageNamed:@"未选中框"];
//        if(i==0)
//        {
//            line4.image=[UIImage imageNamed:@"选中"];
//        }
//        line4.tag=i+2011;
//        shareLabel.text=_end[i];
//        [view1 addSubview:line4];
//        
//        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-80, 50)];
//        shareControl.tag = i+2000;
//        [view1 addSubview:shareControl];
//        [shareControl addTarget:self action:@selector(shareControl6:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    
//}
//#pragma-坐席选择
//-(void)initView3
//{
//    scrollView3=[[UIScrollView alloc]initWithFrame:CGRectMake(80, 40, UIBounds.size.width, 290-40)];
//    
//    [_shareListView addSubview:scrollView3];
//    RightView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-80, self.sitType.count*50)];
//    RightView3.backgroundColor = [UIColor whiteColor];
//    scrollView3.contentSize=RightView3.frame.size;
//    [scrollView3 addSubview:RightView3];
//    
//    //  NSArray *titleArray = @[@"不限",@"无座",@"硬座",@"硬卧",@"软卧",@"一等座",@"二等座",@"商务座"];
//    
//    for (int i=0; i < self.sitType.count; i++) {
//        
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-80, 50)];
//        [RightView3 addSubview:view1];
//        
//        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-80, 1)];
//        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
//        [view1 addSubview:line3];
//        
//        
//        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, (50-13)/2, 80, 13)];
//        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
//        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
//        shareLabel.text = [_sitType objectAtIndex:i];
//        shareLabel.tag=i+3021;
//        shareLabel.textAlignment = NSTextAlignmentCenter;
//        [view1 addSubview:shareLabel];
//        
//        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-80-20-16, (50-21)/2, 20, 21)];
//        line4.image = [UIImage imageNamed:@"未选中框"];
//        line4.tag=i+3011;
//        if(i==0)
//        {
//            line4.image=[UIImage imageNamed:@"选中"];
//        }
//        [view1 addSubview:line4];
//        
//        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-80, 50)];
//        shareControl.tag = i+3000;
//        [view1 addSubview:shareControl];
//        [shareControl addTarget:self action:@selector(shareControl7:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    
//    
//}
//
//- (void)shareControl5:(UIControl *)sender
//{
//    if (sender.selected) {
//        
//        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
//        label.image = [UIImage imageNamed:@"未选中框"];
//        
//    }else
//    {
//        if(sender.tag==1000)
//        {
//            for (int i=1; i<_start.count;i++ ) {
//                UIImageView *label = (UIImageView *)[self viewWithTag:i+1011];
//                label.image = [UIImage imageNamed:@"未选中框"];
//                UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
//                shareControl.selected = NO;
//            }
//        }else
//        {
//            UIImageView *label = (UIImageView *)[self viewWithTag:1011];
//            label.image = [UIImage imageNamed:@"未选中框"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:1000];
//            shareControl.selected = NO;
//        }
//        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
//        label.image = [UIImage imageNamed:@"选中"];
//        
//    }
//    sender.selected=!sender.selected;
//    int count=0;
//    for (int i=0; i<_start.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+1000];
//        if (shareControl.selected==NO) {
//            count++;
//        }
//    }
//    if (count==_start.count) {
//        UIImageView *label = (UIImageView *)[self viewWithTag:1011];
//        label.image = [UIImage imageNamed:@"选中"];
//        UIControl *shareControl = (UIControl *)[self viewWithTag:1000];
//        shareControl.selected = YES;
//    }
//    
//}
//- (void)shareControl6:(UIControl *)sender
//{
//    if (sender.selected) {
//        
//        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
//        label.image = [UIImage imageNamed:@"未选中框"];
//        
//    }else
//    {
//        if(sender.tag==2000)
//        {
//            for (int i=1; i<_end.count;i++ ) {
//                UIImageView *label = (UIImageView *)[self viewWithTag:i+2011];
//                label.image = [UIImage imageNamed:@"未选中框"];
//                UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
//                shareControl.selected = NO;
//            }
//        }else
//        {
//            UIImageView *label = (UIImageView *)[self viewWithTag:2011];
//            label.image = [UIImage imageNamed:@"未选中框"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:2000];
//            shareControl.selected = NO;
//        }
//        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
//        label.image = [UIImage imageNamed:@"选中"];
//        
//        
//    }
//    sender.selected=!sender.selected;
//    int count=0;
//    for (int i=0; i<_end.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+2000];
//        if (shareControl.selected==NO) {
//            count++;
//        }
//    }
//    if (count==_end.count) {
//        UIImageView *label = (UIImageView *)[self viewWithTag:2011];
//        label.image = [UIImage imageNamed:@"选中"];
//        UIControl *shareControl = (UIControl *)[self viewWithTag:2000];
//        shareControl.selected = YES;
//    }
//}
//- (void)shareControl7:(UIControl *)sender
//{
//    if (sender.selected) {
//        
//        
//        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
//        label.image = [UIImage imageNamed:@"未选中框"];
//    }else
//    {
//        if(sender.tag==3000)
//        {
//            for (int i=1; i<_sitType.count;i++ ) {
//                UIImageView *label = (UIImageView *)[self viewWithTag:i+3011];
//                label.image = [UIImage imageNamed:@"未选中框"];
//                UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
//                shareControl.selected = NO;
//            }
//        }else
//        {
//            UIImageView *label = (UIImageView *)[self viewWithTag:3011];
//            label.image = [UIImage imageNamed:@"未选中框"];
//            UIControl *shareControl = (UIControl *)[self viewWithTag:3000];
//            shareControl.selected = NO;
//        }
//        UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+11];
//        label.image = [UIImage imageNamed:@"选中"];
//        
//    }
//    sender.selected=!sender.selected;
//    int count=0;
//    for (int i=0; i<_sitType.count; i++) {
//        UIControl *shareControl = (UIControl *)[self viewWithTag:i+3000];
//        if (shareControl.selected==NO) {
//            count++;
//        }
//    }
//    if (count==_sitType.count) {
//        UIImageView *label = (UIImageView *)[self viewWithTag:3011];
//        label.image = [UIImage imageNamed:@"选中"];
//        UIControl *shareControl = (UIControl *)[self viewWithTag:3000];
//        shareControl.selected = YES;
//    }
//}
//
//-(void)huiseControlClick{
//    
//    [self initViewWhenCancle];
//    [self hideInView];
//}
//
//-(void)initViewWhenCancle
//{
//    
//    
//    for (int i=0; i<_start.count; i++) {
//        UILabel *label=(UILabel *)[self viewWithTag:1021+i];
//        UIImageView *line=(UIImageView *)[self viewWithTag:1011+i];
//        line.image=[UIImage imageNamed:@"未选中框"];
//        UIControl *shareControll=(UIControl *)[self viewWithTag:1000+i];
//        shareControll.selected=NO;
//        
//        for (int j=0; j<selectFromArr.count; j++) {
//            if ([selectFromArr[j] isEqualToString:@""]) {
//                UIImageView *line2=(UIImageView *)[self viewWithTag:1011];
//                line2.image=[UIImage imageNamed:@"选中"];
//                UIControl *shareControll2=(UIControl *)[self viewWithTag:1000];
//                shareControll2.selected=YES;
//            }
//            
//            if ([label.text isEqualToString:selectFromArr[j]]) {
//                line.image=[UIImage imageNamed:@"选中"];
//                shareControll.selected=YES;
//            }
//        }
//        if (selectFromArr.count==0) {
//            UIImageView *line2=(UIImageView *)[self viewWithTag:1011];
//            line2.image=[UIImage imageNamed:@"选中"];
//            UIControl *shareControll2=(UIControl *)[self viewWithTag:1000];
//            shareControll2.selected=YES;
//        }
//    }
//    
//    for (int i=0; i<_end.count; i++) {
//        UILabel *label=(UILabel *)[self viewWithTag:2021+i];
//        UIImageView *line=(UIImageView *)[self viewWithTag:2011+i];
//        line.image=[UIImage imageNamed:@"未选中框"];
//        UIControl *shareControll=(UIControl *)[self viewWithTag:2000+i];
//        shareControll.selected=NO;
//        
//        for (int j=0; j<selectToArr.count; j++) {
//            
//            if ([label.text isEqualToString:selectToArr[j]]) {
//                line.image=[UIImage imageNamed:@"选中"];
//                shareControll.selected=YES;
//            }
//        }
//        if (selectToArr.count==0) {
//            UIImageView *line2=(UIImageView *)[self viewWithTag:2011];
//            line2.image=[UIImage imageNamed:@"选中"];
//            UIControl *shareControll2=(UIControl *)[self viewWithTag:2000];
//            shareControll2.selected=YES;
//        }
//    }
//    
//    for (int i=0; i<_sitType.count; i++) {
//        UILabel *label=(UILabel *)[self viewWithTag:3021+i];
//        UIImageView *line=(UIImageView *)[self viewWithTag:3011+i];
//        line.image=[UIImage imageNamed:@"未选中框"];
//        UIControl *shareControll=(UIControl *)[self viewWithTag:3000+i];
//        shareControll.selected=NO;
//        
//        for (int j=0; j<selectSitArr.count; j++) {
//            
//            if ([label.text isEqualToString:selectSitArr[j]]) {
//                line.image=[UIImage imageNamed:@"选中"];
//                shareControll.selected=YES;
//            }
//        }
//        if (selectSitArr.count==0) {
//            UIImageView *line2=(UIImageView *)[self viewWithTag:3011];
//            line2.image=[UIImage imageNamed:@"选中"];
//            UIControl *shareControll2=(UIControl *)[self viewWithTag:3000];
//            shareControll2.selected=YES;
//        }
//    }
//    UIControl *shareControll1=(UIControl *)[self viewWithTag:1000];
//    UIControl *shareControll2=(UIControl *)[self viewWithTag:2000];
//    UIControl *shareControll3=(UIControl *)[self viewWithTag:3000];
//    if (shareControll1.selected&&shareControll2.selected&&shareControll3.selected) {
//        [self.delegate setUnselect];
//    }
//}
//
//
//@end
