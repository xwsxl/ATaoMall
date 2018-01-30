//
//  MGMineMenuVc.m
//  JDSelectDemo
//
//  Created by mark on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMineMenuVc.h"
#import "MGSubSelectVc.h"
#import "ZZLimitInputManager.h"
#import "UserMessageManager.h"
#define kMGLeftSpace 50
//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//屏幕宽
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

#define WWWW ([UIScreen mainScreen].bounds.size.width-50)*0.30769
@interface MGMineMenuVc ()<UITextFieldDelegate>
{
    
    UILabel *AnTaoLabel;
    UILabel *AnTaoRedLabel;
    UIImageView *AnTaoImgView;
    UIButton *AnTaoButton;
    
    
    UILabel *OtherLabel;
    UILabel *OtherRedLabel;
    UIImageView *OtherImgView;
    UIButton *OtherButton;
    
    
    UITextField *maxTF;
    UITextField *minTF;
}
@property (nonatomic, copy) MGBasicBlock basicBlock;

@property (nonatomic, strong) NSArray *arrTitle;

@property (nonatomic, weak) UIView *upView;

@end

@implementation MGMineMenuVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.navigationController.navigationBar.hidden=YES;
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, [UIScreen mainScreen].bounds.size.height)];
    view2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.74];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view2 addGestureRecognizer:tap];
    [self.view addSubview:view2];
    self.upView = view2;
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, [UIScreen mainScreen].bounds.size.width-50, [UIScreen mainScreen].bounds.size.height)];
    
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bgView];
    
    self.rightSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    self.storeType = @"2";
    
    UIView *AnTaoView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50-200)/3, 58, 100, 30)];
    [bgView addSubview:AnTaoView];
    
    AnTaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    AnTaoLabel.textAlignment = NSTextAlignmentCenter;
    AnTaoLabel.text = @"安淘惠店铺";
    AnTaoLabel.backgroundColor =[UIColor colorWithRed:241/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    AnTaoLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    AnTaoLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    AnTaoLabel.layer.cornerRadius  = 3;
    AnTaoLabel.layer.masksToBounds = YES;
    [AnTaoView addSubview:AnTaoLabel];
    
    AnTaoRedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 30)];
    AnTaoRedLabel.textAlignment = NSTextAlignmentCenter;
    AnTaoRedLabel.text = @"安淘惠店铺";
    AnTaoRedLabel.backgroundColor =[UIColor whiteColor];
    AnTaoRedLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    AnTaoRedLabel.textColor =[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    AnTaoRedLabel.layer.cornerRadius  = 3;
    AnTaoRedLabel.layer.masksToBounds = YES;
    AnTaoRedLabel.hidden=YES;
    [AnTaoView addSubview:AnTaoRedLabel];
    
    AnTaoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 11, 22/2, 15/2)];
    AnTaoImgView.image  =[UIImage imageNamed:@"对勾"];
    AnTaoImgView.hidden=YES;
    [AnTaoView addSubview:AnTaoImgView];
    
    AnTaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    AnTaoButton.frame = CGRectMake(0, 0, 100, 30);
    
    [AnTaoButton addTarget:self action:@selector(AnTaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [AnTaoView addSubview:AnTaoButton];
    
    
    UIView *OtherView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50-200)/3*2+100, 58, 100, 30)];
    [bgView addSubview:OtherView];
    
    
    OtherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    OtherLabel.textAlignment = NSTextAlignmentCenter;
    OtherLabel.text = @"其他店铺";
    OtherLabel.backgroundColor =[UIColor colorWithRed:241/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    OtherLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    OtherLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    OtherLabel.layer.cornerRadius  = 3;
    OtherLabel.layer.masksToBounds = YES;
    [OtherView addSubview:OtherLabel];
    
    
    OtherRedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 30)];
    OtherRedLabel.textAlignment = NSTextAlignmentCenter;
    OtherRedLabel.text = @"其他店铺";
    OtherRedLabel.backgroundColor =[UIColor whiteColor];
    OtherRedLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    OtherRedLabel.textColor =[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    OtherRedLabel.layer.cornerRadius  = 3;
    OtherRedLabel.layer.masksToBounds = YES;
    OtherRedLabel.hidden=YES;
    [OtherView addSubview:OtherRedLabel];
    
    OtherImgView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 11, 22/2, 15/2)];
    OtherImgView.image  =[UIImage imageNamed:@"对勾"];
    OtherImgView.hidden=YES;
    [OtherView addSubview:OtherImgView];
    
    OtherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    OtherButton.frame = CGRectMake(0, 0, 100, 30);
    
    [OtherButton addTarget:self action:@selector(OtherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [OtherView addSubview:OtherButton];
    
    
    
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, [UIScreen mainScreen].bounds.size.width-50, 40)];
    
    [bgView addSubview:selectView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-50, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [selectView addSubview:line];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width-50, 1)];
    
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [selectView addSubview:line1];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 20)];
    title.text = @"价格区间";
    title.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [selectView addSubview:title];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50-WWWW*2-80)/3+80+WWWW, 0, ([UIScreen mainScreen].bounds.size.width-50-WWWW*2-80)/3*2+WWWW+80-([UIScreen mainScreen].bounds.size.width-50-WWWW*2-80)/3-80-WWWW, 40)];
//    lineView.backgroundColor = [UIColor redColor];
    [selectView addSubview:lineView];
    
    UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake((lineView.frame.size.width-10)/2,(40-1)/2 ,10, 1)];
    fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
    [lineView addSubview:fenge];
    
    UIView *minView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50-WWWW*2-80)/3+80, 5, WWWW, 30)];
    minView.backgroundColor =[UIColor colorWithRed:241/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    
    [selectView addSubview:minView];
    
    
    minTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WWWW, 30)];
    minTF.placeholder = @"最低价";
    minTF.delegate=self;
    minTF.tag=100;
    minTF.keyboardType = UIKeyboardTypeNumberPad;
    minTF.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    minTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    minTF.tintColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    minView.layer.cornerRadius  = 3;
    minView.layer.masksToBounds = YES;
    minTF.textAlignment=NSTextAlignmentCenter;
    [ZZLimitInputManager limitInputView:minTF maxLength:8];
    [minView addSubview:minTF];
    
    UIToolbar *bar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button1 setTitle:@"确定"forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:0];
    [button1 addTarget:self action:@selector(OKBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [bar1 addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
    [button2 setTitle:@"取消"forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    [bar1 addSubview:button2];
    [button2 addTarget:self action:@selector(CancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    minTF.inputAccessoryView = bar1;
    
    
    UIView *maxView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50-WWWW*2-80)/3*2+WWWW+80, 5, WWWW, 30)];
    maxView.backgroundColor =[UIColor colorWithRed:241/255.0 green:242/255.0 blue:246/255.0 alpha:1.0];
    maxView.layer.cornerRadius  = 3;
    maxView.layer.masksToBounds = YES;
    [selectView addSubview:maxView];
    
    UIToolbar *bar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button3 setTitle:@"确定"forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor redColor] forState:0];
    [button3 addTarget:self action:@selector(OKBtnclick1) forControlEvents:UIControlEventTouchUpInside];
    [bar2 addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
    [button4 setTitle:@"取消"forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    [bar2 addSubview:button4];
    [button4 addTarget:self action:@selector(CancleBtnclick1) forControlEvents:UIControlEventTouchUpInside];
    
    
    maxTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WWWW, 30)];
    maxTF.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    maxTF.keyboardType = UIKeyboardTypeNumberPad;
    maxTF.placeholder = @"最高价";
    maxTF.delegate=self;
    maxTF.tag=200;
    maxTF.textAlignment=NSTextAlignmentCenter;
    [ZZLimitInputManager limitInputView:maxTF maxLength:8];
    maxTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    maxTF.tintColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [maxView addSubview:maxTF];
    
    maxTF.inputAccessoryView = bar2;
    
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width-50, 1)];
    
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [bgView addSubview:line3];
    
    UIButton *Again = [UIButton buttonWithType:UIButtonTypeCustom];
    Again.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, ([UIScreen mainScreen].bounds.size.width-50)/2, 49);
    [Again setTitle:@"重置" forState:0];
    [Again setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
//    Again.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    Again.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    [Again addTarget:self action:@selector(AgainBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:Again];
    
    UIButton *Sure = [UIButton buttonWithType:UIButtonTypeCustom];
    Sure.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-50)/2, [UIScreen mainScreen].bounds.size.height-49, ([UIScreen mainScreen].bounds.size.width-50)/2, 49);
    [Sure setTitle:@"确认" forState:0];
    [Sure setTitleColor:[UIColor whiteColor] forState:0];
    Sure.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    Sure.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    [Sure addTarget:self action:@selector(SureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:Sure];
    
    
   
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    
    NSLog(@"===fenleistore===%@",[userDefaultes stringForKey:@"fenleistore"]);
    
    
    if ([[userDefaultes stringForKey:@"fenleistore"] isEqualToString:@"0"]) {
        
        self.storeType = @"0";
        
        [AnTaoButton setImage:[UIImage imageNamed:@"红kuang"] forState:0];
        
        AnTaoRedLabel.hidden=NO;
        AnTaoImgView.hidden=NO;
        AnTaoLabel.hidden=YES;
        AnTaoButton.selected=YES;
        
        [OtherButton setImage:[UIImage imageNamed:@""] forState:0];
        
        OtherRedLabel.hidden=YES;
        OtherImgView.hidden=YES;
        OtherLabel.hidden=NO;
    }else if ([[userDefaultes stringForKey:@"fenleistore"] isEqualToString:@"1"]){
        
        self.storeType = @"1";
        
        [OtherButton setImage:[UIImage imageNamed:@"红kuang"] forState:0];
        
        OtherRedLabel.hidden=NO;
        OtherImgView.hidden=NO;
        OtherLabel.hidden=YES;
        OtherButton.selected=YES;
        
        
        AnTaoRedLabel.hidden=YES;
        AnTaoImgView.hidden=YES;
        AnTaoLabel.hidden=NO;
        
        [AnTaoButton setImage:[UIImage imageNamed:@""] forState:0];
        
    }else if([[userDefaultes stringForKey:@"fenleistore"] isEqualToString:@"3"]){
        
        self.storeType = @"2";
        
        [OtherButton setImage:[UIImage imageNamed:@"红kuang"] forState:0];
        
        OtherRedLabel.hidden=NO;
        OtherImgView.hidden=NO;
        OtherLabel.hidden=YES;
        OtherButton.selected=YES;
        
        AnTaoRedLabel.hidden=NO;
        AnTaoImgView.hidden=NO;
        AnTaoLabel.hidden=YES;
        AnTaoButton.selected=YES;
        
        [AnTaoButton setImage:[UIImage imageNamed:@"红kuang"] forState:0];
        
    }else{
        
        self.storeType = @"2";
        
        [OtherButton setImage:[UIImage imageNamed:@""] forState:0];
        
        OtherRedLabel.hidden=YES;
        OtherImgView.hidden=YES;
        OtherLabel.hidden=NO;
        
        AnTaoRedLabel.hidden=YES;
        AnTaoImgView.hidden=YES;
        AnTaoLabel.hidden=NO;
        
        [AnTaoButton setImage:[UIImage imageNamed:@""] forState:0];
        
    }
    
    
    NSLog(@"==maxTF===%@====%@",[userDefaultes stringForKey:@"fenleimax"],[userDefaultes stringForKey:@"fenleimin"]);
    
    
    if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
        
        
        maxTF.text = @"";
        
        if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
            
            minTF.text = @"";
            
        }else{
            
            minTF.text = [userDefaultes stringForKey:@"fenleimin"];
        }
        
        
    }else{
        
        
        if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
            
            minTF.text = @"";
            
        }else{
            
            if ([[userDefaultes stringForKey:@"fenleimin"] integerValue] < [[userDefaultes stringForKey:@"fenleimax"] integerValue]) {
                
                minTF.text = [userDefaultes stringForKey:@"fenleimin"];
                maxTF.text = [userDefaultes stringForKey:@"fenleimax"];
                
            }else{
                
                maxTF.text = [userDefaultes stringForKey:@"fenleimin"];
                minTF.text = [userDefaultes stringForKey:@"fenleimax"];
                
            }
            
        }
        
    }
    
    
    if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
        
        minTF.text = @"";
        
        if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
            
            maxTF.text = @"";
            
        }else{
            
            maxTF.text = [userDefaultes stringForKey:@"fenleimax"];
        }
        
    }else{
        
        if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
            
            maxTF.text = @"";
            
        }else{
            
            if ([[userDefaultes stringForKey:@"fenleimin"] integerValue] < [[userDefaultes stringForKey:@"fenleimax"] integerValue]) {
                
                minTF.text = [userDefaultes stringForKey:@"fenleimin"];
                maxTF.text = [userDefaultes stringForKey:@"fenleimax"];
                
            }else{
                
                maxTF.text = [userDefaultes stringForKey:@"fenleimin"];
                minTF.text = [userDefaultes stringForKey:@"fenleimax"];
                
            }
            
        }
        
    }
    
    
}

- (void)setCancleBarItemHandle:(MGBasicBlock)basicBlock{
    
    self.basicBlock = basicBlock;
    
}

- (void)tapAction{

    if(self.basicBlock)self.basicBlock();

    if (AnTaoButton.selected && OtherButton.selected) {
        
        self.storeType = @"3";
        
    }else if (AnTaoButton.selected){
        
        self.storeType = @"0";
    }else if (OtherButton.selected){
        
        self.storeType = @"1";
    }else{
        
        self.storeType = @"2";
        
    }
    
    
    NSLog(@"=111=self.storeType===%@",self.storeType);
    
    
    if ([maxTF.text isEqualToString:@"最大值"]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
            
            self.max = @"";
            
        }else{
            
            
            self.max = [userDefaultes stringForKey:@"fenleimax"];
        }
        
    }else{
        
        self.max = maxTF.text;
    }
    
    if ([minTF.text isEqualToString:@"最小值"]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
            
            self.min = @"";
        }else{
            
            self.min = [userDefaultes stringForKey:@"fenleimin"];
        }
        
    }else{
        
        self.min = minTF.text;
    }
    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    
//    if ([userDefaultes stringForKey:@"fenleistore"].length==0) {
//        
//        
//    }else{
//        
//        self.storeType =[userDefaultes stringForKey:@"fenleistore"];
//    }
//    
//    
//    if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
//        
//        
//        
//    }else{
//        
//        
//        self.max = [userDefaultes stringForKey:@"fenleimax"];
//    }
//    
//    
//    if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
//        
//        
//    }else{
//        
//        self.min = [userDefaultes stringForKey:@"fenleimin"];
//    }
    
    
    NSLog(@"====AnTaoButton.selected==%d==OtherButton.selected=%d==maxTF.text=%@==minTF.text=%@",AnTaoButton.selected,OtherButton.selected,maxTF.text,minTF.text);
    
    if (AnTaoButton.selected==0 && OtherButton.selected==0 && [maxTF.text isEqualToString:@""] && [minTF.text isEqualToString:@""]) {
        
        self.PanDuan = @"111";
        
    }else{
        
        self.PanDuan = @"222";
        
    }
    
    //立即购买跳确认订单
    NSDictionary *dict1 =[[NSDictionary alloc] initWithObjectsAndKeys:self.storeType,@"textThree",self.min,@"textOne",self.max,@"textTwo",self.PanDuan,@"textFour",nil];
    
    
    NSNotification *notification1 = [[NSNotification alloc] initWithName:@"MGMine" object:nil userInfo:dict1];
    
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
    
    if (self.storeType.length!=0) {
        
        [UserMessageManager FenLeiStore:self.storeType];
    }
    
    if (minTF.text.length!=0) {
        
        [UserMessageManager FenLeiMin:minTF.text];
    }else{
        
        [UserMessageManager RemoveFenLeiMin];
    }
    
    if (maxTF.text.length!=0) {
        
        [UserMessageManager FenLeiMax:maxTF.text];
    }else{
        
        [UserMessageManager RemoveFenLeiMax];
    }
    
}

- (void)cancelAction{

    if(self.basicBlock)self.basicBlock();
    
}

-(void)OtherBtnClick:(UIButton *)sender
{
    
    sender.selected=!sender.selected;
//    AnTaoButton.selected=NO;
    
    if (sender.selected) {
        
//        self.storeType = @"1";
        
        [OtherButton setImage:[UIImage imageNamed:@"红kuang"] forState:0];
        
        OtherRedLabel.hidden=NO;
        OtherImgView.hidden=NO;
        OtherLabel.hidden=YES;
        
        
//        AnTaoRedLabel.hidden=YES;
//        AnTaoImgView.hidden=YES;
//        AnTaoLabel.hidden=NO;
//        
//        [AnTaoButton setImage:[UIImage imageNamed:@""] forState:0];
        
    }else{
        
//        self.storeType = @"2";
        
        [OtherButton setImage:[UIImage imageNamed:@""] forState:0];
        
        OtherRedLabel.hidden=YES;
        OtherImgView.hidden=YES;
        OtherLabel.hidden=NO;
        
//        AnTaoRedLabel.hidden=YES;
//        AnTaoImgView.hidden=YES;
//        AnTaoLabel.hidden=NO;
//        
//        [AnTaoButton setImage:[UIImage imageNamed:@""] forState:0];
        
    }
}

-(void)AnTaoBtnClick:(UIButton *)sender
{
    
    sender.selected=!sender.selected;
//    OtherButton.selected=NO;
    
    if (sender.selected) {
        
//        self.storeType = @"0";

        [AnTaoButton setImage:[UIImage imageNamed:@"红kuang"] forState:0];
        
        AnTaoRedLabel.hidden=NO;
        AnTaoImgView.hidden=NO;
        AnTaoLabel.hidden=YES;
        
//        [OtherButton setImage:[UIImage imageNamed:@""] forState:0];
//        
//        OtherRedLabel.hidden=YES;
//        OtherImgView.hidden=YES;
//        OtherLabel.hidden=NO;
        
    }else{
        
//        self.storeType = @"2";
        
        [AnTaoButton setImage:[UIImage imageNamed:@""] forState:0];
        
        AnTaoRedLabel.hidden=YES;
        AnTaoImgView.hidden=YES;
        AnTaoLabel.hidden=NO;
        
//        [OtherButton setImage:[UIImage imageNamed:@""] forState:0];
//        
//        OtherRedLabel.hidden=YES;
//        OtherImgView.hidden=YES;
//        OtherLabel.hidden=NO;
        
    }
}

-(void)CancleBtnclick
{
    
    [self.view endEditing:YES];
    minTF.text =@"";
    
}

-(void)OKBtnclick
{
    
    [self.view endEditing:YES];
}

-(void)CancleBtnclick1
{
    
    [self.view endEditing:YES];
    maxTF.text =@"";
    
}

-(void)OKBtnclick1
{
    
    [self.view endEditing:YES];
}


- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
//        NSLog(@"22222");
        if(self.basicBlock)self.basicBlock();
    
        if (AnTaoButton.selected && OtherButton.selected) {
            
            self.storeType = @"3";
            
        }else if (AnTaoButton.selected){
            
            self.storeType = @"0";
        }else if (OtherButton.selected){
            
            self.storeType = @"1";
        }else{
            
            self.storeType = @"2";
            
        }
        
        
        if ([maxTF.text isEqualToString:@"最大值"]) {
            
            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //读取数组NSArray类型的数据
            
            if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
                
                self.max = @"";
                
            }else{
                
                
                self.max = [userDefaultes stringForKey:@"fenleimax"];
            }
            
        }else{
            
            self.max = maxTF.text;
        }
        
        if ([minTF.text isEqualToString:@"最小值"]) {
            
            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //读取数组NSArray类型的数据
            
            if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
                
                self.min = @"";
            }else{
                
                self.min = [userDefaultes stringForKey:@"fenleimin"];
            }
            
        }else{
            
            self.min = minTF.text;
        }
        
        
//        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//        //读取数组NSArray类型的数据
//        
//        if ([userDefaultes stringForKey:@"fenleistore"].length==0) {
//            
//            
//        }else{
//            
//            self.storeType =[userDefaultes stringForKey:@"fenleistore"];
//        }
//        
//        
//        if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
//            
//            
//            
//        }else{
//            
//            
//            self.max = [userDefaultes stringForKey:@"fenleimax"];
//        }
//        
//        
//        if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
//            
//            
//        }else{
//            
//            self.min = [userDefaultes stringForKey:@"fenleimin"];
//        }
        
        
        NSLog(@"====AnTaoButton.selected==%d==OtherButton.selected=%d==maxTF.text=%@==minTF.text=%@",AnTaoButton.selected,OtherButton.selected,maxTF.text,minTF.text);
        
        if (AnTaoButton.selected==0 && OtherButton.selected==0 && [maxTF.text isEqualToString:@""] && [minTF.text isEqualToString:@""]) {
            
            self.PanDuan = @"111";
            
        }else{
            
            self.PanDuan = @"222";
            
        }
        
        //立即购买跳确认订单
        NSDictionary *dict1 =[[NSDictionary alloc] initWithObjectsAndKeys:self.storeType,@"textThree",self.min,@"textOne",self.max,@"textTwo",self.PanDuan,@"textFour",nil];
        
        
        NSNotification *notification1 = [[NSNotification alloc] initWithName:@"MGMine" object:nil userInfo:dict1];
        
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification1];
        
        if (self.storeType.length!=0) {
            
            [UserMessageManager FenLeiStore:self.storeType];
        }
        
        if (minTF.text.length!=0) {
            
            [UserMessageManager FenLeiMin:minTF.text];
        }else{
            
            [UserMessageManager RemoveFenLeiMin];
        }
        
        if (maxTF.text.length!=0) {
            
            [UserMessageManager FenLeiMax:maxTF.text];
        }else{
            
            [UserMessageManager RemoveFenLeiMax];
        }
        
        
    }
}

//重置
-(void)AgainBtnClick
{
    
    [UserMessageManager FenLeiRemove];
    
    minTF.text =@"";
    maxTF.text =@"";
    
    self.storeType = @"";
    self.min = @"";
    self.max = @"";
    
    AnTaoButton.selected=NO;
    OtherButton.selected=NO;
    
    [AnTaoButton setImage:[UIImage imageNamed:@""] forState:0];
    
    AnTaoRedLabel.hidden=YES;
    AnTaoImgView.hidden=YES;
    AnTaoLabel.hidden=NO;
    
    [OtherButton setImage:[UIImage imageNamed:@""] forState:0];
    
    OtherRedLabel.hidden=YES;
    OtherImgView.hidden=YES;
    OtherLabel.hidden=NO;
    
}
//确定
-(void)SureBtnClick
{
    
    if(self.basicBlock)self.basicBlock();
    
    
    
    if (AnTaoButton.selected && OtherButton.selected) {
        
        self.storeType = @"3";
        
    }else if (AnTaoButton.selected){
        
        self.storeType = @"0";
        
    }else if (OtherButton.selected){
        
        self.storeType = @"1";
    }else{
        
        self.storeType = @"2";
        
    }
    
    NSLog(@"=111=self.storeType===%@",self.storeType);
    
    
    if ([maxTF.text isEqualToString:@"最大值"]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
            
            self.max = @"";
            
        }else{
            
            
            self.max = [userDefaultes stringForKey:@"fenleimax"];
        }
        
    }else{
        
        self.max = maxTF.text;
    }
    
    if ([minTF.text isEqualToString:@"最小值"]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
       
        if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
            
            self.min = @"";
        }else{
            
            self.min = [userDefaultes stringForKey:@"fenleimin"];
        }
        
    }else{
        
        self.min = minTF.text;
    }
    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    
//    if ([userDefaultes stringForKey:@"fenleistore"].length==0) {
//        
//        
//    }else{
//        
//        self.storeType =[userDefaultes stringForKey:@"fenleistore"];
//    }
//    
//    
//    if ([userDefaultes stringForKey:@"fenleimax"].length==0) {
//        
//        
//        
//    }else{
//        
//        
//        self.max = [userDefaultes stringForKey:@"fenleimax"];
//    }
//    
//    
//    if ([userDefaultes stringForKey:@"fenleimin"].length==0) {
//        
//        
//    }else{
//        
//        self.min = [userDefaultes stringForKey:@"fenleimin"];
//    }
    
    NSLog(@"====AnTaoButton.selected==%d==OtherButton.selected=%d==maxTF.text=%@==minTF.text=%@",AnTaoButton.selected,OtherButton.selected,maxTF.text,minTF.text);
    
    
    if (AnTaoButton.selected==0 && OtherButton.selected==0 && [maxTF.text isEqualToString:@""] && [minTF.text isEqualToString:@""]) {
        
        self.PanDuan = @"111";
        
    }else{
        
        self.PanDuan = @"222";
        
    }
    //立即购买跳确认订单
    NSDictionary *dict1 =[[NSDictionary alloc] initWithObjectsAndKeys:self.storeType,@"textThree",self.min,@"textOne",self.max,@"textTwo",self.PanDuan,@"textFour",nil];
    
    
    NSNotification *notification1 = [[NSNotification alloc] initWithName:@"MGMine" object:nil userInfo:dict1];
    
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
    
    
    NSLog(@"==maxTF===%ld==minTF==%ld",maxTF.text.length,minTF.text.length);
    
    if (self.storeType.length!=0) {
        
        [UserMessageManager FenLeiStore:self.storeType];
    }
    
    if (minTF.text.length!=0) {
        
        [UserMessageManager FenLeiMin:minTF.text];
    }else{
        
        [UserMessageManager RemoveFenLeiMin];
    }
    
    if (maxTF.text.length!=0) {
        
        [UserMessageManager FenLeiMax:maxTF.text];
    }else{
        
        [UserMessageManager RemoveFenLeiMax];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag==100) {
        
        if (textField.text.length>1) {
            
            unichar ch = [textField.text characterAtIndex: 0];
            
            if (ch == '0') {
                
                self.min = [textField.text substringFromIndex:1];
                
                minTF.text = self.min;
                
            }else{
                
                self.min = textField.text;
            }
            
        }else{
            
            self.min = textField.text;
        }
        
        
    }else{
        
        
        if (textField.text.length>1) {
            
            unichar ch = [textField.text characterAtIndex: 0];
            
            if (ch == '0') {
                
                self.max = [textField.text substringFromIndex:1];
                
                maxTF.text = self.max;
                
            }else{
                
                self.max = textField.text;
            }
            
        }else{
            
            self.max = textField.text;
        }
        
    }
    
}
@end
