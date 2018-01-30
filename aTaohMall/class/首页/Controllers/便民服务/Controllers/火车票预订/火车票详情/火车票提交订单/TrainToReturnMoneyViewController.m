//
//  TrainToReturnMoneyViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/16.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainToReturnMoneyViewController.h"

#import "TrainTuiKuanViewController.h"
#import "TrainRetuenSuccessViewController.h"
#import "BianMinModel.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"
#import "RecordAirManger.h"
#import "BianMinModel.h"
#import "AFNetworking.h"
#import "WKProgressHUD.h"
#import "JRToast.h"
#import "UserMessageManager.h"
#import "TrainToast.h"

@interface TrainToReturnMoneyViewController ()
{
    
    UIScrollView *_titleScroll;
}
@end

@implementation TrainToReturnMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    self.view.frame=[UIScreen mainScreen].bounds;

    [self getdata];

    
}
-(void)setUI
{
    [self initNav];

    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];

    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    //Button的高

    //    _titleScroll.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_titleScroll];

    [self initView];
}

-(void)getdata
{
    NSMutableArray *_ManArrM=[[NSMutableArray alloc] init];
    [_ManArrM removeAllObjects];

    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{


    });

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url = [NSString stringWithFormat:@"%@trainToApplyRefund_mob.shtml",URL_Str];

    NSDictionary *dic = @{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"orderno":self.ordrno};


    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];


        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"xmlStr==火车票退款信息==%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            //            NSLog(@"%@",dic);



            if ([dic[@"status"] isEqualToString:@"10000"]) {


                for (NSDictionary *dict2 in dic[@"list_user"]) {

                    BianMinModel *model = [[BianMinModel alloc] init];

                    model.Commit_passengersename = [NSString stringWithFormat:@"%@",dict2[@"user_name"]];
                    model.Commit_piaotypename = [NSString stringWithFormat:@"%@",dict2[@"start_time"]];
                    model.Commit_passportseno = [NSString stringWithFormat:@"%@",dict2[@"train_name"]];
                    model.Commit_seat_type_name = [NSString stringWithFormat:@"%@",dict2[@"checi"]];


                    [_ManArrM addObject:model];


                }

                for (NSDictionary *dict2 in dic[@"list_money"]) {


                  //  NSString *Train_orderno = [NSString stringWithFormat:@"%@",dict2[@"orderno"]];
                    NSString *Train_refundmoney = [NSString stringWithFormat:@"%@",dict2[@"refundmoney"]];            //预计退还金额
                    NSString *Train_refundintegral = [NSString stringWithFormat:@"%@",dict2[@"refundintegral"]];            //预计退还积分
                    NSString *Train_shouxumoney = [NSString stringWithFormat:@"%@",dict2[@"shouxumoney"]];            //预估手续费
                    NSString *Train_shouxuintegral = [NSString stringWithFormat:@"%@",dict2[@"shouxuintegral"]];            //预估手续积分
                    NSString *Train_paymoney = [NSString stringWithFormat:@"%@",dict2[@"paymoney"]];            //火车票价 金额
                    NSString *Train_payintegral = [NSString stringWithFormat:@"%@",dict2[@"payintegral"]];    //火车票价 积分

                    self.refund_amount = Train_refundmoney;
                    self.integral_amount = Train_refundintegral;
                    self.bsr_type = [NSString stringWithFormat:@"￥%@+%@积分",Train_shouxumoney,Train_shouxuintegral];
                    self.Price = [NSString stringWithFormat:@"￥%@+%@积分",Train_paymoney,Train_payintegral];
                }
                self.ManArray = _ManArrM;

            }else{

                [TrainToast showWithText:dic[@"message"] duration:2.0f];

            }

            [hud dismiss:YES];

        }
        [self setUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [hud dismiss:YES];

        NSLog(@"%@",error);
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
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    UIButton *Qurt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-17-15, 34+KSafeTopHeight, 17, 17);
    
    [Qurt1 setImage:[UIImage imageNamed:@"提示111"] forState:0];
    
    
    [Qurt1 addTarget:self action:@selector(QurtBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt1];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"申请退票";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}

-(void)initView{
    
    UILabel *TopLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 12)];
    TopLabel.text = @"*退票手续费及最终退款金额以铁道部门实际退还为准";
    TopLabel.numberOfLines=1;
    TopLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    TopLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [_titleScroll addSubview:TopLabel];
    
    NSString *stringForColor = @"*";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:TopLabel.text];
    //
    NSRange range = [TopLabel.text rangeOfString:stringForColor];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
    TopLabel.attributedText=mAttStri;
    
    
    for (int i = 0; i < self.ManArray.count; i++) {
        
        BianMinModel *model = self.ManArray[i];
        
        UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 + 50*i, [UIScreen mainScreen].bounds.size.width, 50)];
        ManView.backgroundColor = [UIColor whiteColor];
        [_titleScroll addSubview:ManView];
        
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
        NameLabel.text = model.Commit_passengersename;
        NameLabel.numberOfLines=1;
        NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [ManView addSubview:NameLabel];
        
        
        UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, (50-14)/2, [UIScreen mainScreen].bounds.size.width-90, 14)];
        IdLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.Commit_piaotypename,model.Commit_passportseno,model.Commit_seat_type_name];
        IdLabel.numberOfLines=1;
        IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [ManView addSubview:IdLabel];
        
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width-15, 1)];
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [ManView addSubview:line];
    }
    
    UIView *MoneyView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 + 50*self.ManArray.count + 10, [UIScreen mainScreen].bounds.size.width, 50)];
    MoneyView.backgroundColor = [UIColor whiteColor];
    [_titleScroll addSubview:MoneyView];
    
    UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    IdLabel.text = @"预计退还金额";
    IdLabel.numberOfLines=1;
    IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [MoneyView addSubview:IdLabel];
    
    UILabel *Price = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-220, (50-14)/2, 200, 14)];
    Price.text = [NSString stringWithFormat:@"￥%@",self.refund_amount];
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
    
    
    UIView *IntgerView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 + 50*self.ManArray.count + 60, [UIScreen mainScreen].bounds.size.width, 50)];
    IntgerView.backgroundColor = [UIColor whiteColor];
    [_titleScroll addSubview:IntgerView];
    
    UILabel *IntgerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    IntgerLabel.text = @"预计退还积分";
    IntgerLabel.numberOfLines=1;
    IntgerLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IntgerLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IntgerView addSubview:IntgerLabel];
    
    UILabel *Intger = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-220, (50-14)/2, 200, 14)];
    Intger.text = [NSString stringWithFormat:@"%@积分",self.integral_amount];
    Intger.numberOfLines=1;
    Intger.textAlignment = NSTextAlignmentRight;
    Intger.textColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:94/255.0 alpha:1.0];
    Intger.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IntgerView addSubview:Intger];
    
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [IntgerView addSubview:line2];
    
    
    UIView *OtherView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 + 50*self.ManArray.count + 70+50, [UIScreen mainScreen].bounds.size.width, 100)];
    OtherView.backgroundColor = [UIColor whiteColor];
    [_titleScroll addSubview:OtherView];
    
    
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 100, 14)];
    Label1.text = @"火车票价";
    Label1.numberOfLines=1;
    Label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Label1.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OtherView addSubview:Label1];
    
    UILabel *AllPrice = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-225, 19, 210, 14)];
    AllPrice.text = self.Price;
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
    AllIntger.text = self.bsr_type;
    AllIntger.numberOfLines=1;
    AllIntger.textAlignment = NSTextAlignmentRight;
    AllIntger.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    AllIntger.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OtherView addSubview:AllIntger];
    
    UILabel *Label3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 71, 200, 10)];
    Label3.text = @"(开车前15天(不含)以上，无手续费)";
    Label3.numberOfLines=1;
    Label3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    Label3.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [OtherView addSubview:Label3];
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99, [UIScreen mainScreen].bounds.size.width, 1)];
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [OtherView addSubview:line3];
    
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, 30 + 50*self.ManArray.count + 70+50+140, [UIScreen mainScreen].bounds.size.width-30, 38)];
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

-(void)PayBtnCLick
{
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@trainSureRefund_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"orderno":self.ordrno};
    
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==火车票退款信息==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"%@",dic);
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                TrainRetuenSuccessViewController *vc = [[TrainRetuenSuccessViewController alloc] init];
                
                vc.sigen=self.sigen;
                
                vc.Train = @"100";
                
                vc.orderno = self.ordrno;
                
                if (_delegate && [_delegate respondsToSelector:@selector(TrainToReturnMoney)]) {
                    
                    [_delegate TrainToReturnMoney];
                    
                }
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden=YES;
                
            }else if ([dic[@"status"] isEqualToString:@"10004"])
            {
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:dic[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"取消");
                }]];
                [self presentViewController:alert animated:NO completion:nil];
                
            }
            else{
                
                [TrainToast showWithText:dic[@"message"] duration:2.0f];
                
                
            }
            
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hud dismiss:YES];
        NSLog(@"%@",error);
        
    }];
    
}
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)QurtBtnClick1
{
    TrainTuiKuanViewController *vc = [[TrainTuiKuanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
}
@end
