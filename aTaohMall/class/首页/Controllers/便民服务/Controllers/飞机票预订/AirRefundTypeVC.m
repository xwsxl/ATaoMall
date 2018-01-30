//
//  AirRefundTypeVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirRefundTypeVC.h"
#import "AirRefundUploadImgVC.h"
#import "AirNoticeView.h"
#import "TrainRetuenSuccessViewController.h"
#import "RequestServiceVC.h"
@interface AirRefundTypeVC ()<AirNoticeViewDelegate,AirRefundUploadImgDelegate>
{
    UIScrollView *_titleScroll;
    AirNoticeView *_notice;
    NSString *uploadString;
}
@end

@implementation AirRefundTypeVC
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    
    
    
}
-(void)setUI
{
    //导航栏
    [self initNav];
    _notice=[[AirNoticeView alloc]init];
    [self.view addSubview:_notice];
    
    self.view.backgroundColor=RGB(244, 244, 244);
    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    //Button的高
    
    _titleScroll.showsVerticalScrollIndicator = NO;
    
    
    [self.view addSubview:_titleScroll];
    
    NSArray *arr=@[@"自愿退票",@"非自愿退票"];
    NSArray *arr1=@[@"2-7个工作日内返还退款",@"10-20个工作日内返还退款"];
    //乘车人信息
    for (int i=0; i<2; i++) {
        UIButton * view=[UIButton buttonWithType:UIButtonTypeCustom];
        [view setBackgroundColor:[UIColor whiteColor]];
        view.frame=CGRectMake(0, 5+70*i, kScreen_Width, 70);
        view.tag=100+i;
        [view addTarget:self action:@selector(ziYuanBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [_titleScroll addSubview:view];
        
//        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 5+75*i, kScreen_Width, 75)];
//        view.backgroundColor = [UIColor whiteColor];
//        [_titleScroll addSubview:view];
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreen_Width, 14)];
        lab.font=KNSFONT(14);
        lab.textColor=RGB(51, 51, 51);
        lab.text=arr[i];
        [view addSubview:lab];
        
        UILabel * TimeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 43, kScreen_Width-30, 12)];
        TimeLab.font=KNSFONT(13);
        TimeLab.textColor=RGB(102, 102, 102);
        TimeLab.text=arr1[i];
        [view addSubview:TimeLab];
        
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-27, 29, 12, 12)];
        IV.image=KImage(@"");
        IV.tag=200+i;
        [view addSubview:IV];
        
        
        UIImageView *lineIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 69, kScreen_Width, 1)];
        lineIV.image=KImage(@"分割线-拷贝");
        [view addSubview:lineIV];
        if (i==0) {
            view.selected=YES;
            IV.image=KImage(@"选中94");
        }
        
    }
    
    UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(15, 5+70*2+10, 12, 12)];
    IV.image=[UIImage imageNamed:@"icon_prompt"];
    [_titleScroll addSubview:IV];

    UIButton *blueBut=[UIButton buttonWithType:UIButtonTypeCustom];
    blueBut.frame=CGRectMake(32, 5+70*2+10, 160, 12);
    [blueBut setTitle:@"自愿退款与非自愿退款的区别" forState:UIControlStateNormal];
    [blueBut setTitleColor:RGB(43, 143, 255) forState:UIControlStateNormal];
    blueBut.titleLabel.font=KNSFONT(12);
    [blueBut addTarget:self action:@selector(tuiKauntips:) forControlEvents:UIControlEventTouchUpInside];
    [_titleScroll addSubview:blueBut];
    
    UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(15, 5+70*2+50, kScreen_Width-30, 37);
    [but setTitle:@"确定退款" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setBackgroundColor:RGB(255, 93, 94)];
    [but addTarget:self action:@selector(GoNextStep:) forControlEvents:UIControlEventTouchUpInside];
    [_titleScroll addSubview:but];
    
    
    
    //下一步按钮
    
}
-(void)AirNoticeViewRelodate
{
    UIButton *but=[self.view viewWithTag:100];
    NSString *retType=@"";
    if (but.selected)
    {
        retType=@"0";
    }else
    {
        retType=@"1";
    }
    if (!uploadString) {
        uploadString=@"";
    }
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"orderno":self.orderno,@"upload":uploadString,@"reftype":retType};
    [ATHRequestManager requestForSureRefundAirOrderWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10006"]) {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                
            }];
        }else if ([responseObj[@"status"] isEqualToString:@"10000"])
        {
            TrainRetuenSuccessViewController *vc = [[TrainRetuenSuccessViewController alloc] init];
            vc.sigen=self.sigen;
            vc.jindu = self.jindu;
            vc.weidu = self.weidu;
            vc.MapStartAddress = self.MapStartAddress;
            vc.orderno=self.orderno;
            
            [self.navigationController pushViewController:vc animated:NO];
            self.navigationController.navigationBar.hidden=YES;
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        
        
    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:error.localizedDescription duration:2.0];
    }];
    
}
-(void)uploadImgSuccessWithUploadString:(NSString *)uploadStr
{
            UIButton *but=[self.view viewWithTag:100];
            but.selected=NO;
            UIImageView *IV=[self.view viewWithTag:200];
            IV.image=KImage(@"");
            UIButton *but1=[self.view viewWithTag:101];
            but1.selected=YES;
            UIImageView *IV1=[self.view viewWithTag:201];
            IV1.image=KImage(@"选中94");
    uploadString=uploadStr;
    [self GoNextStep:nil];
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
                _notice.delegate=self;
                [_notice showInView:self.view];
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
    
    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:error.localizedDescription duration:2.0];
    }];
}
-(void)tuiKauntips:(id)sender
{
    
    RequestServiceVC *vc=[[RequestServiceVC alloc]initWithURLStr:JMSHTServiceAirRefundInstructionStr withTitle:@"退票说明"];

    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    NSLog(@"tuikuanxuzhi");
}
-(void)ziYuanBtn:(UIButton *)sender
{
    if (sender.tag==100) {
        NSLog(@"ziyuan");
        UIButton *but=[self.view viewWithTag:100];
        but.selected=YES;
        UIImageView *IV=[self.view viewWithTag:200];
        IV.image=KImage(@"选中94");
        UIButton *but1=[self.view viewWithTag:101];
        but1.selected=NO;
        UIImageView *IV1=[self.view viewWithTag:201];
        IV1.image=KImage(@"");
    }
    else
    {
        
        AirRefundUploadImgVC *VC=[[AirRefundUploadImgVC alloc]init];
        VC.orderno=self.orderno;
        VC.delegate=self;
        [self.navigationController pushViewController:VC animated:NO];
//        NSLog(@"feiziyuan");
//        UIButton *but=[self.view viewWithTag:100];
//        but.selected=NO;
//        UIImageView *IV=[self.view viewWithTag:200];
//        IV.image=KImage(@"");
//        UIButton *but1=[self.view viewWithTag:101];
//        but1.selected=YES;
//        UIImageView *IV1=[self.view viewWithTag:201];
//        IV1.image=KImage(@"icon_selected");
    }
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
    
    label.text = @"退票类型";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
//    UIButton *Tui = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    Tui.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-17-15, 34, 17, 17);
//    
//    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
//    
//    [Tui setImage:[UIImage imageNamed:@"提示111"] forState:0];
//    
//    
//    [Tui addTarget:self action:@selector(TuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [titleView addSubview:Tui];
    
    
}

-(void)TuiBtnClick
{
    NSLog(@"提示");
    //    _tuiView.Text = self.refund_instructions;
    //
    //    [_tuiView showInView:self.view Text:self.refund_instructions];
    
    
}

-(void)QurtBtnClick{
    
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
