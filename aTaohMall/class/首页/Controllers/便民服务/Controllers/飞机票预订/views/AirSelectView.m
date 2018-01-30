//
//  AirSelectView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/19.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirSelectView.h"

#import "BianMinModel.h"
#import "RecordAirManger.h"
#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface AirSelectView ()
{
    UIImageView *Wanimg;
    UIImageView *Duanimg;
    UIImageView *zaoimg;
    
    
    //记录筛选的信息
    NSMutableArray *numberArrM;
    NSMutableArray *ModelArrM;
    NSMutableArray *TypeArrM;
    
    NSMutableArray *ArrM;
    
    //记录选中的信息
    
    NSMutableArray *GongSi;
    NSMutableArray *CangWei;
    NSMutableArray *JiXing;
    
    NSMutableArray *BXGongSi;
    NSMutableArray *BXCangWei;
    NSMutableArray *BXJiXing;
    
    int number;
    int Model;
    int Type;
    
    //不限时候否选择
    int numberisNo;
    int ModelisNo;
    int TypeisNo;
    
    NSString *airline_airway;
    NSString *shipping_space;//0:只有经济舱1：包含商务舱
    NSString *plane_type;//机型   0：小，1：中，2：大
    
    UIScrollView *RightView1;
    UIScrollView *RightView2;
    UIScrollView *RightView3;
}
@end

@implementation AirSelectView

-(void)AirArray:(NSArray *)AirArray ModelArray:(NSArray *)ModelArray TypeArray:(NSArray *)TypeArray{
    
    _AirArray = AirArray;
    _ModelArray = ModelArray;
    _TypeArray = TypeArray;
    
    UIView *LeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 95, 290-40)];
    LeftView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [_shareListView addSubview:LeftView];
    
    NSArray *titleArray = @[@"航空公司",@"舱位",@"机型"];
    
    for (int i=0; i < 3; i++) {
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*i, 95, 50)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        shareLabel.text = [titleArray objectAtIndex:i];
        shareLabel.tag = i+1000;
        shareLabel.textAlignment = NSTextAlignmentCenter;
        [LeftView addSubview:shareLabel];
        
        UIImageView *PointImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, (50-8)/2 +50*i, 8, 8)];
        PointImg.image = [UIImage imageNamed:@""];
        PointImg.tag = 100+i;
        [LeftView addSubview:PointImg];
        
        if (i==0) {
            
            shareLabel.backgroundColor = [UIColor whiteColor];
            
            [self initView1];
            
            RightView1.hidden = NO;
            
        }else if (i == 1){
            
            shareLabel.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
            [self initView2];
            
            RightView2.hidden = YES;
            
        }else{
            
            shareLabel.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
            [self initView3];
            
            RightView3.hidden = YES;
            
        }
        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 50*i, 95, 50)];
        shareControl.tag = i+1;
        [LeftView addSubview:shareControl];
        [shareControl addTarget:self action:@selector(shareControl4:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
}

-(void)setAirArray:(NSArray *)AirArray{
    
//    _AirArray = AirArray;
//    
//    
//   NSLog(@"2222");
//    
//    UIView *LeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 95, 290-40)];
//    LeftView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//    [_shareListView addSubview:LeftView];
//    
//    NSArray *titleArray = @[@"航空公司",@"舱位",@"机型"];
//    
//    for (int i=0; i < 3; i++) {
//        
//        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*i, 95, 50)];
//        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
//        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
//        shareLabel.text = [titleArray objectAtIndex:i];
//        shareLabel.tag = i+1000;
//        shareLabel.textAlignment = NSTextAlignmentCenter;
//        [LeftView addSubview:shareLabel];
//        
//        UIImageView *PointImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, (50-8)/2 +50*i, 8, 8)];
//        PointImg.image = [UIImage imageNamed:@""];
//        PointImg.tag = 100+i;
//        [LeftView addSubview:PointImg];
//        
//        if (i==0) {
//            
//            shareLabel.backgroundColor = [UIColor whiteColor];
//            [self initView1];
//            
//        }
//        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 50*i, 95, 50)];
//        shareControl.tag = i+1;
//        [LeftView addSubview:shareControl];
//        [shareControl addTarget:self action:@selector(shareControl4:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    
    
}

-(void)setModelArray:(NSArray *)ModelArray{
    
//    _ModelArray = ModelArray;
    
    
}

-(void)setTypeArray:(NSArray *)TypeArray{
    
//    _TypeArray = TypeArray;
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        number = 0;
        Model = 0;
        Type = 0;
        
        numberisNo = 0;
        ModelisNo = 0;
        TypeisNo = 0;
        
        
        airline_airway = @"100";
        shipping_space = @"100";
        plane_type = @"100";
        
        
        numberArrM = [NSMutableArray new];
        ModelArrM = [NSMutableArray new];
        TypeArrM = [NSMutableArray new];
        ArrM = [NSMutableArray new];
        
        
        GongSi = [NSMutableArray new];
        CangWei = [NSMutableArray new];
        JiXing = [NSMutableArray new];
        
        BXGongSi = [NSMutableArray new];
        BXCangWei = [NSMutableArray new];
        BXJiXing = [NSMutableArray new];
        
        //取出航空公司缓存
//        [self readNSUserDefaults];
//        [self readNSUserDefaults1];
//        [self readNSUserDefaults2];
        
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
}

- (void)hideInView {
    
//    NSString *Numberstr;
//    NSString *Typestr ;
//    NSString *Modelstr;
//    
//    
//    
//    //    NSLog(@"==airline_airway==%@==shipping_space==%@==plane_type==%@",airline_airway,shipping_space,plane_type);
//    
//    if ([airline_airway isEqualToString:@"666"]) {
//        
//        Numberstr = @"";
//    }else{
//        
//        Numberstr = [numberArrM componentsJoinedByString:@","];
//        
//    }
//    
//    if ([shipping_space isEqualToString:@"666"]) {
//        
//        Typestr = @"";
//        
//    }else{
//        
//        Typestr = [TypeArrM componentsJoinedByString:@","];
//    }
//    
//    
//    if ([plane_type isEqualToString:@"666"]) {
//        
//        Modelstr = @"";
//        
//    }else{
//        
//        Modelstr = [ModelArrM componentsJoinedByString:@","];
//    }
//    
//    
//    
//    NSLog(@"==航空公司==%@==舱位==%@==机型==%@",Numberstr,Typestr,Modelstr);
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(ChangeString:Space:Type:)]) {
//        
//        
//        [_delegate ChangeString:Numberstr Space:Typestr Type:Modelstr];
//        
//    }
    
    
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

- (void)shareControl1:(UIControl *)sender{
    NSLog(@"取消");
    
    if (_delegate && [_delegate respondsToSelector:@selector(ChangeString)]) {
        
        [_delegate ChangeString];
        
    }
    
    [self hideInView];
}

- (void)shareControl2:(UIControl *)sender{
    NSLog(@"清除");
//    [self hideInView];
    
    [RecordAirManger removeAirline_airway];
    [GongSi removeAllObjects];
    [CangWei removeAllObjects];
    [JiXing removeAllObjects];
    
    
    UIImageView *line4 = (UIImageView *)[self viewWithTag:100];
    UIImageView *line5 = (UIImageView *)[self viewWithTag:101];
    UIImageView *line6 = (UIImageView *)[self viewWithTag:102];
    
    line4.image = [UIImage imageNamed:@""];
    line5.image = [UIImage imageNamed:@""];
    line6.image = [UIImage imageNamed:@""];
    
    UILabel *title = (UILabel *)[self viewWithTag:1000];
    title.textAlignment = NSTextAlignmentCenter;
    
    for (int i=0; i < _AirArray.count; i++) {
        
        UIImageView *line4 = (UIImageView *)[self viewWithTag:i+8501];
        line4.image = [UIImage imageNamed:@"未选中框"];
        
        
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+8000];
        shareControl.selected = YES;
        
    }
    
    
    for (int i=0; i < _TypeArray.count; i++) {
        
        UIImageView *line4 = (UIImageView *)[self viewWithTag:i+7501];
        line4.image = [UIImage imageNamed:@"未选中框"];
        
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+7000];
        shareControl.selected = YES;
        
    }
    
    for (int i=0; i < _ModelArray.count; i++) {
        
        UIImageView *line4 = (UIImageView *)[self viewWithTag:i+6501];
        line4.image = [UIImage imageNamed:@"未选中框"];
        
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+6000];
        shareControl.selected = YES;
        
    }
    
    
}

- (void)shareControl3:(UIControl *)sender{
    NSLog(@"确定");
 //   [self hideInView];
    
    [numberArrM removeAllObjects];
    [TypeArrM removeAllObjects];
    [ModelArrM removeAllObjects];
    
    [GongSi removeAllObjects];
    [CangWei removeAllObjects];
    [JiXing removeAllObjects];
    
    [BXGongSi removeAllObjects];
    [BXCangWei removeAllObjects];
    [BXJiXing removeAllObjects];
    
    for (int i=0; i < _AirArray.count; i++) {
        
        BianMinModel *model = _AirArray[i];
        
        if ([model.Air_selectGongsi isEqualToString:@"10"]) {
            
            NSLog(@"===航空公司不限==%@==%@==tag==%@",model.Air_name,model.Air_selectGongsi,model.GongsiTag);
            airline_airway = @"666";
            
            [BXGongSi addObject:model.GongsiTag];
            
        }else if ([model.Air_selectGongsi isEqualToString:@"1"]){
            
            NSLog(@"===航空公司选中==%@==%@==tag==%@",model.Air_name,model.Air_selectGongsi,model.GongsiTag);
            
            NSString *string = [NSString stringWithFormat:@"%@",model.Air_value];
            
            [numberArrM addObject:string];
            
            [GongSi addObject:model.GongsiTag];
            
        }
        
        
        
    }
    
    for (int i=0; i < _TypeArray.count; i++) {
        
        BianMinModel *model = _TypeArray[i];
        
        if ([model.Air_selectCangwei isEqualToString:@"10"]) {
            
            NSLog(@"===舱位不限==%@==%@==tag==%@",model.Air_name,model.Air_selectCangwei,model.CangWeiTag);
            
            
            shipping_space = @"666";
            [BXCangWei addObject:model.CangWeiTag];
            
        }else if ([model.Air_selectCangwei isEqualToString:@"1"]){
            
            NSLog(@"===舱位选中==%@==%@==tag==%@",model.Air_name,model.Air_selectCangwei,model.CangWeiTag);
            
            NSString *string = [NSString stringWithFormat:@"%@",model.Air_value];
            
            [TypeArrM addObject:string];
            
            [CangWei addObject:model.CangWeiTag];
            
        }
        
    }
    
    for (int i=0; i < _ModelArray.count; i++) {
        
        BianMinModel *model = _ModelArray[i];
        
        if ([model.Air_selectjiXing isEqualToString:@"10"]) {
            
            NSLog(@"===机型不限==%@==%@==tag==%@",model.Air_name,model.Air_selectjiXing,model.JiXingTag);
            plane_type = @"666";
            [BXJiXing addObject:model.JiXingTag];
            
        }else if ([model.Air_selectjiXing isEqualToString:@"1"]){
            
            NSLog(@"===机型选中==%@==%@==tag==%@",model.Air_name,model.Air_selectjiXing,model.JiXingTag);
            
            NSString *string = [NSString stringWithFormat:@"%@",model.Air_value];
            
            [ModelArrM addObject:string];
            
            [JiXing addObject:model.JiXingTag];
            
        }
        
    }
    
    
    
    if ([airline_airway isEqualToString:@"666"]) {
        
        NSString *HK = [BXGongSi componentsJoinedByString:@"-"];
        
        [RecordAirManger Airline_airway:HK];//缓存航空公司记录
    }else{
        
        NSString *HK = [GongSi componentsJoinedByString:@"-"];
        
        [RecordAirManger Airline_airway:HK];//缓存航空公司记录
    }
    
    if ([shipping_space isEqualToString:@"666"]) {
        
        NSString *CW = [BXCangWei componentsJoinedByString:@"-"];
        
        [RecordAirManger Shipping_space:CW];//缓存舱位记录
    }else{
        
        NSString *CW = [CangWei componentsJoinedByString:@"-"];
        
        [RecordAirManger Shipping_space:CW];//缓存舱位记录
    }
    
    if ([plane_type isEqualToString:@"666"]) {
        
        NSString *JX = [BXJiXing componentsJoinedByString:@"-"];
        
        [RecordAirManger Plane_type:JX];//缓存机型记录
    }else{
        
        NSString *JX = [JiXing componentsJoinedByString:@"-"];
        
        [RecordAirManger Plane_type:JX];//缓存机型记录
    }
    
        
    NSString *Numberstr;
    NSString *Typestr ;
    NSString *Modelstr;
    
    
    
    //    NSLog(@"==airline_airway==%@==shipping_space==%@==plane_type==%@",airline_airway,shipping_space,plane_type);
    
    if ([airline_airway isEqualToString:@"666"]) {
        
        Numberstr = @"";
        
    }else{
        
        Numberstr = [numberArrM componentsJoinedByString:@","];
        
    }
    
    if ([shipping_space isEqualToString:@"666"]) {
        
        Typestr = @"";
        
    }else{
        
        Typestr = [TypeArrM componentsJoinedByString:@","];
    }
    
    
    if ([plane_type isEqualToString:@"666"]) {
        
        Modelstr = @"";
        
    }else{
        
        Modelstr = [ModelArrM componentsJoinedByString:@","];
    }
    
    
    NSLog(@"==航空公司==%@==舱位==%@==机型==%@",Numberstr,Typestr,Modelstr);
    
        if (_delegate && [_delegate respondsToSelector:@selector(AirSelect:Space:Type:)]) {
            
            
            [_delegate AirSelect:Numberstr Space:Typestr Type:Modelstr];
            
        }
    
    [self hideInView];
    
}

- (void)shareControl4:(UIControl *)sender{
    
    if (sender.tag+999==1000) {
        
        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+999];
        label.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = (UILabel *)[self viewWithTag:1001];
        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
        UILabel *label2 = (UILabel *)[self viewWithTag:1002];
        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
//        [self initView1];
        
        RightView1.hidden = NO;
        RightView2.hidden = YES;
        RightView3.hidden = YES;
        
    }else if(sender.tag+999==1001){
        
        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+999];
        label.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = (UILabel *)[self viewWithTag:1000];
        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
        UILabel *label2 = (UILabel *)[self viewWithTag:1002];
        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
//        [self initView2];
        
        RightView1.hidden = YES;
        RightView2.hidden = NO;
        RightView3.hidden = YES;
        
    }else{
        
        UILabel *label = (UILabel *)[self viewWithTag:sender.tag+999];
        label.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = (UILabel *)[self viewWithTag:1000];
        label1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
        UILabel *label2 = (UILabel *)[self viewWithTag:1001];
        label2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
//        [self initView3];
        
        RightView1.hidden = YES;
        RightView2.hidden = YES;
        RightView3.hidden = NO;
        
    }
    
    
    NSLog(@"点击的第%ld个",(long)sender.tag);
    
}

-(void)initView1{
    
//    for (BianMinModel *model in _AirArray) {
//        
//        
//        NSLog(@"==model.Air_name==%@",model.Air_name);
//        
//    }
    
    NSLog(@"1111");
    
    
    RightView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(95, 40, UIBounds.size.width-95, 290-40)];
    RightView1.contentSize = CGSizeMake(UIBounds.size.width-95, 50*_AirArray.count);
    
    RightView1.backgroundColor = [UIColor whiteColor];
    [_shareListView addSubview:RightView1];
    
    
    for (int i=0; i < _AirArray.count; i++) {
        
        UIImageView *line4 = (UIImageView *)[self viewWithTag:i+8501];
        [line4 removeFromSuperview];
        
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+8000];
        [shareControl removeFromSuperview];
        
    }
    
    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    NSArray * myArray = [userDefaultes arrayForKey:@"airline_airway"];
    
    for (int i=0; i < _AirArray.count; i++) {
        
        
        BianMinModel *model = _AirArray[i];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-95, 50)];
        [RightView1 addSubview:view1];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-95, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view1 addSubview:line3];
        
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, (50-13)/2, 150, 13)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        shareLabel.text = model.Air_name;
        shareLabel.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:shareLabel];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-95-20-16, (50-21)/2, 20, 21)];
        line4.image = [UIImage imageNamed:@"未选中框"];
        line4.tag=i+8501;
        
        [view1 addSubview:line4];
        
        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, 50)];
        shareControl.tag = i+8000;
        shareControl.selected=YES;
        [view1 addSubview:shareControl];
        [shareControl addTarget:self action:@selector(shareControl5:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSString * HK = [userDefaultes stringForKey:@"airline_airway"];
        
        NSArray *HKArray = [HK componentsSeparatedByString:@"-"];
        
        
        NSLog(@"===HKHKHKHKHKHKHK===%@===%ld",HK,HK.length);
        
        for (int j=0; j < HKArray.count; j++) {
            
            
            if (i+8501 == [HKArray[j] intValue]) {
                
                
                line4.image = [UIImage imageNamed:@"选中"];
            }
            
            if (i+8501 == [HKArray[j] intValue]) {
                
                NSLog(@"====8501===");
                
                shareControl.selected=NO;
            }
            
            if ([HKArray containsObject:@"8501"]) {
                
                UIImageView *line4 = (UIImageView *)[self viewWithTag:100];
                line4.image = [UIImage imageNamed:@""];
                
                
                UILabel *title = (UILabel *)[self viewWithTag:1000];
                title.textAlignment = NSTextAlignmentCenter;
                
                
            }else{
                
                if(HK.length==0){
                    
                    UIImageView *line4 = (UIImageView *)[self viewWithTag:100];
                    line4.image = [UIImage imageNamed:@""];
                    
                    UILabel *title = (UILabel *)[self viewWithTag:1000];
                    title.textAlignment = NSTextAlignmentCenter;
                    
                }else{
                    
                    if (HKArray.count > 0) {
                        
                        UIImageView *line4 = (UIImageView *)[self viewWithTag:100];
                        line4.image = [UIImage imageNamed:@"icon-point"];
                        
                        UILabel *title = (UILabel *)[self viewWithTag:1000];
                        title.textAlignment = NSTextAlignmentRight;
                        
                    }
                }
            }
        }
    }
    
}

-(void)initView2{
    
    RightView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(95, 40, UIBounds.size.width-95, 290-40)];
    RightView2.contentSize = CGSizeMake(UIBounds.size.width-95, 50*5);
    
    RightView2.backgroundColor = [UIColor whiteColor];
    [_shareListView addSubview:RightView2];
    
    
    for (int i=0; i < _TypeArray.count; i++) {
        
        UIImageView *line4 = (UIImageView *)[self viewWithTag:i+7501];
        [line4 removeFromSuperview];
        
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+7000];
        [shareControl removeFromSuperview];
        
    }
    
    
    NSArray *titleArray = @[@"不限",@"经济舱",@"商务舱/头等舱"];
    
    for (int i=0; i < _TypeArray.count; i++) {
        
        
        BianMinModel *model = _TypeArray[i];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-95, 50)];
        [RightView2 addSubview:view1];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-95, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view1 addSubview:line3];
        
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, (50-13)/2, 150, 13)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        shareLabel.text = model.Air_name;
        shareLabel.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:shareLabel];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-95-20-16, (50-21)/2, 20, 21)];
        line4.image = [UIImage imageNamed:@"未选中框"];
        line4.tag=i+7501;
        
        [view1 addSubview:line4];
        
        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, 50)];
        shareControl.tag = i+7000;
        shareControl.selected=YES;
        [view1 addSubview:shareControl];
        [shareControl addTarget:self action:@selector(shareControl7:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSString * CW = [userDefaultes stringForKey:@"shipping_space"];
        
        NSArray *CWArray = [CW componentsSeparatedByString:@"-"];
        
        //    NSArray * myArray2 = [userDefaultes arrayForKey:@"plane_type"];
        
        for (int j=0; j < CWArray.count; j++) {
            
            
            if (i+7501 == [CWArray[j] intValue]) {
                
                
                line4.image = [UIImage imageNamed:@"选中"];
            }
            
            if (i+7501 == [CWArray[j] intValue]) {
                
                NSLog(@"====8501===");
                
                shareControl.selected=NO;
            }
            
            if ([CWArray containsObject:@"7501"]) {
                
                UIImageView *line4 = (UIImageView *)[self viewWithTag:101];
                line4.image = [UIImage imageNamed:@""];
                
            }else{
                
                if (CW.length == 0) {
                    
                    UIImageView *line4 = (UIImageView *)[self viewWithTag:101];
                    line4.image = [UIImage imageNamed:@""];
                    
                }else{
                    
                    if (CWArray.count > 0) {
                        
                        UIImageView *line4 = (UIImageView *)[self viewWithTag:101];
                        line4.image = [UIImage imageNamed:@"icon-point"];
                        
                    }
                }
            }
        }
    }
}
    
//机型
-(void)initView3{
    
    for (BianMinModel *model in _ModelArray) {
        
        
        NSLog(@"==model.Air_name==%@",model.Air_name);
        
    }
    
    RightView3 = [[UIScrollView alloc] initWithFrame:CGRectMake(95, 40, UIBounds.size.width-95, 290-40)];
    RightView3.contentSize = CGSizeMake(UIBounds.size.width-95, 50*_ModelArray.count);
    
    RightView3.backgroundColor = [UIColor whiteColor];
    [_shareListView addSubview:RightView3];
    
    
    for (int i=0; i < _ModelArray.count; i++) {
        
        UIImageView *line4 = (UIImageView *)[self viewWithTag:i+6501];
        [line4 removeFromSuperview];
        
        UIControl *shareControl = (UIControl *)[self viewWithTag:i+6000];
        [shareControl removeFromSuperview];
        
    }
    
    
    for (int i=0; i < _ModelArray.count; i++) {
        
        BianMinModel *model = _ModelArray[i];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, UIBounds.size.width-95, 50)];
        [RightView3 addSubview:view1];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15-95, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view1 addSubview:line3];
        
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, (50-13)/2, 150, 13)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        shareLabel.text = model.Air_name;
        shareLabel.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:shareLabel];
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-95-20-16, (50-21)/2, 20, 21)];
        line4.image = [UIImage imageNamed:@"未选中框"];
        line4.tag=i+6501;
        
        [view1 addSubview:line4];
        
        UIControl *shareControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-95, 50)];
        shareControl.tag = i+6000;
        shareControl.selected=YES;
        [view1 addSubview:shareControl];
        [shareControl addTarget:self action:@selector(shareControl6:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSString * JX = [userDefaultes stringForKey:@"plane_type"];
        
        NSArray *JXArray = [JX componentsSeparatedByString:@"-"];
        
        //    NSArray * myArray2 = [userDefaultes arrayForKey:@"plane_type"];
        
        for (int j=0; j < JXArray.count; j++) {
            
            
            if (i+6501 == [JXArray[j] intValue]) {
                
                
                line4.image = [UIImage imageNamed:@"选中"];
            }
            
            if (i+6501 == [JXArray[j] intValue]) {
                
                NSLog(@"====8501===");
                
                shareControl.selected=NO;
            }
            
            if ([JXArray containsObject:@"6501"]) {
                
                UIImageView *line4 = (UIImageView *)[self viewWithTag:102];
                line4.image = [UIImage imageNamed:@""];
                
            }else{
                
                if (JX.length == 0) {
                    
                    UIImageView *line4 = (UIImageView *)[self viewWithTag:102];
                    line4.image = [UIImage imageNamed:@""];
                    
                }else{
                    
                    if (JXArray.count > 0) {
                        
                        UIImageView *line4 = (UIImageView *)[self viewWithTag:102];
                        line4.image = [UIImage imageNamed:@"icon-point"];
                        
                    }
                }
            }
        }
    }
}

//航空公司
- (void)shareControl5:(UIControl *)sender{
    
    BianMinModel *model = _AirArray[sender.tag-8000];
    NSLog(@"===model.Air_name==%@===%@==sender.tag==%ld",model.Air_name,model.Air_value,sender.tag);
    
    UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+501];
    UIImageView *point = (UIImageView *)[self viewWithTag:100];
    
    UILabel *title = (UILabel *)[self viewWithTag:1000];
    
    if (sender.selected) {
        
        
        //不限
        if (sender.tag +1 == 8001) {
            
            for (int i=0; i < _AirArray.count; i++) {
                
                BianMinModel *model = _AirArray[i];
                model.Air_selectGongsi = @"0";
                model.GongsiTag = @"0";
                
                UIImageView *line4 = (UIImageView *)[self viewWithTag:i+8501];
                line4.image = [UIImage imageNamed:@"未选中框"];
                
                UIControl *shareControl = (UIControl *)[self viewWithTag:i+8000];
                shareControl.selected = YES;
                
            }
            
            model.Air_selectGongsi = @"10";
            label.image = [UIImage imageNamed:@"选中"];
            point.image = [UIImage imageNamed:@""];
            title.textAlignment = NSTextAlignmentCenter;
            numberisNo = 1;
            number = 0;
            NSLog(@"不限");
            
            model.GongsiTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            [GongSi removeAllObjects];
            //
            //            [GongSi addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
            
        }else{
            
            for (int i=0; i < _AirArray.count; i++) {
                
                BianMinModel *model = _AirArray[i];
                
                if (i==0) {
                    
                    model.Air_selectGongsi = @"0";
                    model.GongsiTag = @"0";
                }
                
            }
            
            UIImageView *line4 = (UIImageView *)[self viewWithTag:8501];
            line4.image = [UIImage imageNamed:@"未选中框"];
            
            UIControl *shareControl = (UIControl *)[self viewWithTag:8000];
            shareControl.selected = YES;
            
            number = number +1;
            model.Air_selectGongsi = @"1";
            label.image = [UIImage imageNamed:@"选中"];
            point.image = [UIImage imageNamed:@"icon-point"];
            title.textAlignment = NSTextAlignmentRight;
            
            model.GongsiTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            NSString *name = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            //
            //            if (![GongSi containsObject:name]) {
            //
            //                [GongSi addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
            //            }
            
            
        }
        
        
        sender.selected = !sender.selected;
        
    }else{
        
        
        //        [GongSi removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
        
        //不限
        if (sender.tag +1 == 8001) {
            
            
            model.Air_selectGongsi = @"0";
            label.image = [UIImage imageNamed:@"未选中框"];
            point.image = [UIImage imageNamed:@""];
            title.textAlignment = NSTextAlignmentCenter;
            numberisNo = 1;
            number = 0;
            NSLog(@"不限");
            
            model.GongsiTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            [RecordAirManger RemoveGongSi];
            
        }else{
            
            
            UIImageView *line4 = (UIImageView *)[self viewWithTag:8501];
            line4.image = [UIImage imageNamed:@"未选中框"];
            
            UIControl *shareControl = (UIControl *)[self viewWithTag:8000];
            shareControl.selected = YES;
            
            number = number +1;
            model.Air_selectGongsi = @"0";
            label.image = [UIImage imageNamed:@"未选中框"];
            point.image = [UIImage imageNamed:@""];
            title.textAlignment = NSTextAlignmentCenter;
            model.GongsiTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            for (int i=0; i < _AirArray.count; i++) {
                
                BianMinModel *model = _AirArray[i];
                
                NSLog(@"==Air_selectGongsi==%@",model.Air_selectGongsi);
                
                if ([model.Air_selectGongsi isEqualToString:@"1"]) {
                    
                    point.image = [UIImage imageNamed:@"icon-point"];
                    title.textAlignment = NSTextAlignmentRight;
                }
                
            }
            
        }
        
        sender.selected=YES;
        
        
    }
    
    
}

//机型
- (void)shareControl6:(UIControl *)sender{
//    number = 0;
//    Type = 0;
    
    
    BianMinModel *model = _ModelArray[sender.tag-6000];
    
    UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+501];
    UIImageView *point = (UIImageView *)[self viewWithTag:102];
    
    
    if (sender.selected) {
        
        //        NSLog(@"选中");
        
        //        [JiXing addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
        
        //不限
        if (sender.tag +1 == 6001) {
            
            for (int i=0; i < _ModelArray.count; i++) {
                
                BianMinModel *model = _ModelArray[i];
                model.Air_selectjiXing = @"0";
                model.JiXingTag = @"0";
                
                UIImageView *line4 = (UIImageView *)[self viewWithTag:i+6501];
                line4.image = [UIImage imageNamed:@"未选中框"];
                
                UIControl *shareControl = (UIControl *)[self viewWithTag:i+6000];
                shareControl.selected = YES;
                
            }
            
            label.image = [UIImage imageNamed:@"选中"];
            point.image = [UIImage imageNamed:@""];
            ModelisNo=1;
            model.Air_selectjiXing = @"10";
            
            model.JiXingTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            [JiXing removeAllObjects];
            //
            //            [JiXing addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
            
        }else{
            
            
            for (int i=0; i < _ModelArray.count; i++) {
                
                BianMinModel *model = _ModelArray[i];
                
                if (i==0) {
                    
                    model.Air_selectjiXing = @"0";
                    model.JiXingTag = @"0";
                }
                
            }
            
            UIImageView *line4 = (UIImageView *)[self viewWithTag:6501];
            line4.image = [UIImage imageNamed:@"未选中框"];
            
            UIControl *shareControl = (UIControl *)[self viewWithTag:6000];
            shareControl.selected = YES;
            
            model.Air_selectjiXing = @"1";
            label.image = [UIImage imageNamed:@"选中"];
            point.image = [UIImage imageNamed:@"icon-point"];
            
            model.JiXingTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            NSString *name = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            //
            //            if (![JiXing containsObject:name]) {
            //
            //                [JiXing addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
            //            }
            
            
        }
        
        sender.selected = !sender.selected;
        
    }else{
        
        //        NSLog(@"不选中");
        
        //        [JiXing removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
        //不限
        if (sender.tag +1 == 6001) {
            
            model.Air_selectjiXing = @"0";
            label.image = [UIImage imageNamed:@"未选中框"];
            point.image = [UIImage imageNamed:@""];
            
            NSLog(@"不限");
            
            model.JiXingTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            [RecordAirManger RemoveGongSi];
            
        }else{
            
            
            UIImageView *line4 = (UIImageView *)[self viewWithTag:6501];
            line4.image = [UIImage imageNamed:@"未选中框"];
            
            UIControl *shareControl = (UIControl *)[self viewWithTag:6000];
            shareControl.selected = YES;
            
            model.Air_selectjiXing = @"0";
            label.image = [UIImage imageNamed:@"未选中框"];
            point.image = [UIImage imageNamed:@""];
            model.JiXingTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            for (int i=0; i < _ModelArray.count; i++) {
                
                BianMinModel *model = _ModelArray[i];
                
                NSLog(@"==ir_selectjiXing==%@",model.Air_selectjiXing);
                
                if ([model.Air_selectjiXing isEqualToString:@"1"]) {
                    
                    point.image = [UIImage imageNamed:@"icon-point"];
                }
                
            }
            
        }
        
        sender.selected=YES;
        
        
    }
    
    
}

//舱位
- (void)shareControl7:(UIControl *)sender{
    
    UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+501];
    UIImageView *point = (UIImageView *)[self viewWithTag:101];
    
    BianMinModel *model = _TypeArray[sender.tag-7000];
    
    
    if (sender.selected) {
        
        //        NSLog(@"选中");
        
        //        [JiXing addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
        
        //不限
        if (sender.tag +1 == 7001) {
            
            for (int i=0; i < _TypeArray.count; i++) {
                
                BianMinModel *model = _TypeArray[i];
                model.Air_selectCangwei = @"0";
                model.CangWeiTag = @"0";
                
                UIImageView *line4 = (UIImageView *)[self viewWithTag:i+7501];
                line4.image = [UIImage imageNamed:@"未选中框"];
                
                UIControl *shareControl = (UIControl *)[self viewWithTag:i+7000];
                shareControl.selected = YES;
                
            }
            
            label.image = [UIImage imageNamed:@"选中"];
            point.image = [UIImage imageNamed:@""];
            model.Air_selectCangwei = @"10";
            
            model.CangWeiTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            [CangWei removeAllObjects];
            //
            //            [CangWei addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
            
        }else{
            
            for (int i=0; i < _TypeArray.count; i++) {
                
                BianMinModel *model = _TypeArray[i];
                
                if (i==0) {
                    
                    model.Air_selectCangwei = @"0";
                    model.CangWeiTag = @"0";
                }
                
            }
            
            UIImageView *line4 = (UIImageView *)[self viewWithTag:7501];
            line4.image = [UIImage imageNamed:@"未选中框"];
            
            UIControl *shareControl = (UIControl *)[self viewWithTag:7000];
            shareControl.selected = YES;
            
            model.Air_selectCangwei = @"1";
            label.image = [UIImage imageNamed:@"选中"];
            point.image = [UIImage imageNamed:@"icon-point"];
            
            model.CangWeiTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            NSString *name = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            //
            //            if (![CangWei containsObject:name]) {
            //
            //                [CangWei addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
            //            }
            
            
        }
        
        sender.selected = !sender.selected;
        
    }else{
        
        //        NSLog(@"不选中");
        
        //        [CangWei removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag+501]];
        //不限
        if (sender.tag +1 == 6001) {
            
            model.Air_selectCangwei = @"0";
            label.image = [UIImage imageNamed:@"未选中框"];
            point.image = [UIImage imageNamed:@""];
            
            NSLog(@"不限");
            
            model.CangWeiTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            //            [RecordAirManger RemoveGongSi];
            
        }else{
            
            
            UIImageView *line4 = (UIImageView *)[self viewWithTag:7501];
            line4.image = [UIImage imageNamed:@"未选中框"];
            
            UIControl *shareControl = (UIControl *)[self viewWithTag:7000];
            shareControl.selected = YES;
            
            model.Air_selectCangwei = @"0";
            label.image = [UIImage imageNamed:@"未选中框"];
            point.image = [UIImage imageNamed:@""];
            model.CangWeiTag = [NSString stringWithFormat:@"%ld",(long)sender.tag+501];
            
            for (int i=0; i < _TypeArray.count; i++) {
                
                BianMinModel *model = _TypeArray[i];
                
                NSLog(@"==Air_selectCangwei==%@",model.Air_selectCangwei);
                
                if ([model.Air_selectCangwei isEqualToString:@"1"]) {
                    
                    point.image = [UIImage imageNamed:@"icon-point"];
                }
                
            }
            
        }
        
        sender.selected=YES;
        
        
    }
}

-(void)huiseControlClick{
    
    if (_delegate && [_delegate respondsToSelector:@selector(ChangeString)]) {
        
        [_delegate ChangeString];
        
    }
    
    [self hideInView];
}
@end
