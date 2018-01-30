//
//  AirApplyRefundVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirApplyRefundVC.h"
#import "AirRefundTypeVC.h"
#import "AirChengCheRenModel.h"
#import "TuiKuanShuoMingView.h"
@interface AirApplyRefundVC ()
{
    UIScrollView *_titleScroll;
    TuiKuanShuoMingView *shuoMingView;
}

@end

@implementation AirApplyRefundVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}


-(void)getData
{

    NSDictionary *dic = @{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"orderno":self.orderno};
    [ATHRequestManager requestForCanRefundInfoWithParams:dic successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {

            NSArray *temp=responseObj[@"list1"];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            for (NSDictionary *dic in temp) {
                AirChengCheRenModel *model=[[AirChengCheRenModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [arr addObject:model];

            }

            NSArray *array=responseObj[@"list3"];
            NSDictionary *dict=array[0];
            self.dataArr=arr;
            self.tuiKuanStr=dict[@"refund_instructions"];

        }else if ([responseObj[@"status"] isEqualToString:@"10006"])
        {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

            }];
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [self setUI];
    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:error.localizedDescription duration:2.0];
    }];

}

-(void)setUI
{
    //导航栏
     [self initNav];
    self.view.backgroundColor=RGB(244, 244, 244);
    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    //Button的高
    
    _titleScroll.showsVerticalScrollIndicator = NO;
    
    
    [self.view addSubview:_titleScroll];
    
    //乘车人信息
    for (int i=0; i<self.dataArr.count; i++) {
        AirChengCheRenModel *model=_dataArr[i];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0+75*i, kScreen_Width, 75)];
        view.backgroundColor = [UIColor whiteColor];
        [_titleScroll addSubview:view];

        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 18, 50, 14)];
        lab.font=KNSFONT(14);
        lab.textColor=RGB(51, 51, 51);
        lab.text=model.username;
        [view addSubview:lab];
        
        UILabel * TimeLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 18, kScreen_Width-105, 14)];
        TimeLab.font=KNSFONT(14);
        TimeLab.textColor=RGB(51, 51, 51);
        TimeLab.text=[NSString stringWithFormat:@"%@  %@",model.time,model.name];
        [view addSubview:TimeLab];
        
        UILabel * flightLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, kScreen_Width-105, 14)];
        flightLab.font=KNSFONT(14);
        flightLab.textColor=RGB(51, 51, 51);
        flightLab.text=[NSString stringWithFormat:@"%@  %@",model.airport_name,model.airport_flight];
        [view addSubview:flightLab];
        UIImageView *lineIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 74, kScreen_Width, 1)];
        lineIV.image=KImage(@"分割线-拷贝");
        [view addSubview:lineIV];
        
    }
    
    
    UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(15, 75*_dataArr.count+50, kScreen_Width-30, 37);
    [but setTitle:@"下一步" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setBackgroundColor:RGB(255, 93, 94)];
    [but addTarget:self action:@selector(GoNextStep:) forControlEvents:UIControlEventTouchUpInside];
    [_titleScroll addSubview:but];

    
    
    //下一步按钮
    
}

-(void)GoNextStep:(id)sender
{
    [ATHRequestManager requestForRefundDataConfirmSuccessBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10006"]) {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                
            }];
        }
        else if([responseObj[@"status"] isEqualToString:@"10000"])
        {
            AirRefundTypeVC *VC=[[AirRefundTypeVC alloc]init];
            VC.orderno=self.orderno;
            VC.sigen=self.sigen;
            VC.jindu = self.jindu;
            VC.weidu = self.weidu;
            VC.MapStartAddress = self.MapStartAddress;
            
            [self.navigationController pushViewController:VC animated:NO];
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        
    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:error.localizedDescription duration:2.0];
    }];
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
    
    label.text = @"申请退票";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    UIButton *Tui = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Tui.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-17-15, 34, 17, 17);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Tui setImage:[UIImage imageNamed:@"提示111"] forState:0];
    
    
    [Tui addTarget:self action:@selector(TuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Tui];
    
    
}
-(void)TuiBtnClick
{
    if (!shuoMingView) {
        shuoMingView=[[TuiKuanShuoMingView alloc]init];
        [self.view addSubview:shuoMingView];
    }
    NSString *string = [self.tuiKuanStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    shuoMingView.Text=string;
    [shuoMingView showInView:self.view Text:string];
    NSLog(@"提示");

}
-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
@end
