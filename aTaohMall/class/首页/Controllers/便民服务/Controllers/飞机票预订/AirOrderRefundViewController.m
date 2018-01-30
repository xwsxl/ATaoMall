//
//  AirOrderRefundViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirOrderRefundViewController.h"

#import "TuiKuanShuoMingView.h"
#import "TrainRetuenSuccessViewController.h"

#import "BianMinModel.h"

#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"
#import "WKProgressHUD.h"
#import "JRToast.h"
#import "TrainToast.h"

#import "AirNoticeView.h"
@interface AirOrderRefundViewController ()<UIAlertViewDelegate,AirNoticeViewDelegate>
{
    
    TuiKuanShuoMingView *_tuiView;
    UIScrollView *_titleScroll;
    AirNoticeView *_notice;
    
}
@end

@implementation AirOrderRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _notice = [[AirNoticeView alloc] init];
    [self.view addSubview:_notice];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    [self initNav];
    
    
    _titleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
//    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+300);
    
    [self.view addSubview:_titleScroll];
    
    [self initView];
    
    
    _tuiView = [[TuiKuanShuoMingView alloc] init];
    
    [self.view addSubview:_tuiView];
    
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
    
    label.text = [NSString stringWithFormat:@"申请退款"];
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
    
    UIButton *Tui = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Tui.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-17-15, 34+KSafeTopHeight, 17, 17);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Tui setImage:[UIImage imageNamed:@"提示111"] forState:0];
    
    
    [Tui addTarget:self action:@selector(TuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Tui];
    
    
}

-(void)initView{
    
    
    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 70*_ManArray.count);
    
    for (int i = 0; i < _ManArray.count; i++) {
        
        BianMinModel *model = _ManArray[i];
        
        UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*i, [UIScreen mainScreen].bounds.size.width, 70)];
        ManView.backgroundColor = [UIColor whiteColor];
        [_titleScroll addSubview:ManView];
        
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 100, 13)];
        NameLabel.text = model.username;
        NameLabel.numberOfLines=1;
        NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [ManView addSubview:NameLabel];
        
        UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 18, [UIScreen mainScreen].bounds.size.width-90, 14)];
        IdLabel.text = [NSString stringWithFormat:@"%@ %@",model.time,model.name];
        IdLabel.numberOfLines=1;
        IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [ManView addSubview:IdLabel];
        
        
        UILabel *IdLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(90, 39, [UIScreen mainScreen].bounds.size.width-90, 13)];
        IdLabel1.text = [NSString stringWithFormat:@"%@ %@",model.airport_name,model.airport_flight];
        IdLabel1.numberOfLines=1;
        IdLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        IdLabel1.font  =[UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [ManView addSubview:IdLabel1];
        
        
        if (i==1) {
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 1)];
            line.image = [UIImage imageNamed:@"分割线-拷贝"];
            [ManView addSubview:line];
            
        }else{
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 69, [UIScreen mainScreen].bounds.size.width-15, 1)];
            line.image = [UIImage imageNamed:@"分割线-拷贝"];
            [ManView addSubview:line];
        }
        
    }
    
    UIView *MoneyView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*_ManArray.count + 10, [UIScreen mainScreen].bounds.size.width, 50)];
    MoneyView.backgroundColor = [UIColor whiteColor];
//    [_titleScroll addSubview:MoneyView];
    
    UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    IdLabel.text = @"预计退还金额";
    IdLabel.numberOfLines=1;
    IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [MoneyView addSubview:IdLabel];
    
    UILabel *Price = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-220, (50-14)/2, 200, 14)];
    Price.text = @"￥230";
    Price.numberOfLines=1;
    Price.textAlignment = NSTextAlignmentRight;
    Price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    Price.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [MoneyView addSubview:Price];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [MoneyView addSubview:line1];
    
    NSString *stringForColor1 = @"￥";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:Price.text];
    //
    NSRange range1 = [Price.text rangeOfString:stringForColor1];
    
    [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range1];
    Price.attributedText=mAttStri1;
    
    
    UIView *IntgerView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*_ManArray.count + 60, [UIScreen mainScreen].bounds.size.width, 50)];
    IntgerView.backgroundColor = [UIColor whiteColor];
//    [_titleScroll addSubview:IntgerView];
    
    UILabel *IntgerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    IntgerLabel.text = @"预计退还积分";
    IntgerLabel.numberOfLines=1;
    IntgerLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IntgerLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IntgerView addSubview:IntgerLabel];
    
    UILabel *Intger = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-220, (50-14)/2, 200, 14)];
    Intger.text = [NSString stringWithFormat:@"%@积分",self.payintegral];
    Intger.numberOfLines=1;
    Intger.textAlignment = NSTextAlignmentRight;
    Intger.textColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:94/255.0 alpha:1.0];
    Intger.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IntgerView addSubview:Intger];
    
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [IntgerView addSubview:line2];
    
    
    UIView *OtherView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*_ManArray.count + 70+50, [UIScreen mainScreen].bounds.size.width, 100)];
    OtherView.backgroundColor = [UIColor whiteColor];
//    [_titleScroll addSubview:OtherView];
    
    
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 100, 14)];
    Label1.text = @"实付款";
    Label1.numberOfLines=1;
    Label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Label1.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OtherView addSubview:Label1];
    
    UILabel *AllPrice = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-225, 19, 210, 14)];
    AllPrice.text = @"￥240+50积分";
    AllPrice.numberOfLines=1;
    AllPrice.textAlignment = NSTextAlignmentRight;
    AllPrice.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    AllPrice.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OtherView addSubview:AllPrice];
    
    NSString *stringForColor2 = @"￥";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri2 = [[NSMutableAttributedString alloc] initWithString:AllPrice.text];
    //
    NSRange range2 = [AllPrice.text rangeOfString:stringForColor2];
    
    [mAttStri2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range2];
    AllPrice.attributedText=mAttStri2;
    
    UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 51, 100, 14)];
    Label2.text = @"预估手续费";
    Label2.numberOfLines=1;
    Label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Label2.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OtherView addSubview:Label2];
    
    UILabel *AllIntger = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-225, 51, 210, 14)];
    AllIntger.text = [NSString stringWithFormat:@"￥%@+%@积分",self.paymoney,self.payintegral];
    AllIntger.numberOfLines=1;
    AllIntger.textAlignment = NSTextAlignmentRight;
    AllIntger.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    AllIntger.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OtherView addSubview:AllIntger];
    
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99, [UIScreen mainScreen].bounds.size.width, 1)];
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [OtherView addSubview:line3];
    
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, 70*_ManArray.count + 10, [UIScreen mainScreen].bounds.size.width-30, 38)];
    PayView.layer.cornerRadius = 3;
    PayView.layer.masksToBounds = YES;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [PayView.layer addSublayer:gradientLayer];
    
    [_titleScroll addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"确认退票" forState:0];
    Pay.layer.cornerRadius = 3;
    Pay.layer.masksToBounds = YES;
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
    
}

-(void)AirNoticeViewRelodate
{
    
    [self getDatas];
    
}
-(void)PayBtnCLick
{

    [self GetTime];
    
}


-(void)GetTime{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@airRefundDateJudge_mob.shtml",URL_Str];
    
    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==判断是否可以退票==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                _notice.delegate=self;
                [_notice showInView:self.view];
                
            }else if ([dic[@"status"] isEqualToString:@"10006"])
            {
                [UIAlertTools showAlertWithTitle:@"" message:dic[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                    
                }];
            }
            else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:dic[@"message"] message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    if (buttonIndex == 1) {
//        
//        [self getDatas];
//    }
//}

-(void)getDatas
{
    
    //WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@sureRefundAirOrder_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"order":self.orderno};
    
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==退款状态==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"%@",dic);
            
            
                
                if ([dic[@"status"] isEqualToString:@"10000"]) {
                    
                    TrainRetuenSuccessViewController *vc = [[TrainRetuenSuccessViewController alloc] init];
            
                    vc.sigen=self.sigen;
                    vc.jindu = self.jindu;
                    vc.weidu = self.weidu;
                    vc.MapStartAddress = self.MapStartAddress;
                     vc.orderno=self.orderno;
                    [self.navigationController pushViewController:vc animated:NO];
                    self.navigationController.navigationBar.hidden=YES;
                    
                    
                }else{
                    
                    
                    [JRToast showWithText:dic[@"message"] duration:2.0f];
                    
                }
            
            [hud dismiss:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [hud dismiss:YES];
        
        
        NSLog(@"%@",error);
    }];
}

-(void)TuiBtnClick
{
    _tuiView.Text = self.refund_instructions;
    
    [_tuiView showInView:self.view Text:self.refund_instructions];
    
    
}
-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
@end
