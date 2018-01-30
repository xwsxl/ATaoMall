//
//  PhoneAndFlowPayViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PhoneAndFlowPayViewController.h"
#import "FTPopOverMenu.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "JRToast.h"

#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "PersonalBMDetailVC.h"
#import "PersonalAllDanVC.h"
#import "AppDelegate.h"


@interface PhoneAndFlowPayViewController ()<UIAlertViewDelegate>
{
    
    UILabel *ScoreLabel;
    UIButton *WenHao;
    UIView *wenhaoView;
    NSString *string2;
    UILabel *GoOnlabel;
    UILabel *InterLabel;
    UISwitch *Switch;
    
}
@end

@implementation PhoneAndFlowPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self initNav];
    
    [self initMoneyView];
    
    [self initInterView];
    
    [self initZhiFuBao];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultStatus:) name:@"resultStatus" object:nil];
    
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
    
    label.text = self.title;
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initMoneyView
{
    
    UIView *MoneyView =[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    MoneyView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:MoneyView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 20)];
    label.text=@"订单金额";
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [MoneyView addSubview:label];
    
    UILabel *Price = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, [UIScreen mainScreen].bounds.size.width-120, 20)];
    Price.text=[NSString stringWithFormat:@"￥%.02f",[self.price floatValue]];
    Price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    Price.textAlignment=NSTextAlignmentRight;
    Price.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [MoneyView addSubview:Price];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [MoneyView addSubview:line];
    
}

-(void)initInterView
{
    UIView *InterView = [[UIView alloc] initWithFrame:CGRectMake(0, 125+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 61)];
    InterView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:InterView];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [InterView addSubview:line1];
    
    string2 = [NSString stringWithFormat:@"￥%.02f",[self.pay_integral floatValue]];
    
    InterLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, [UIScreen mainScreen].bounds.size.width-100, 14)];
    InterLabel.text=[NSString stringWithFormat:@"积分支付%@",string2];
    InterLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    InterLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
    [InterView addSubview:InterLabel];
    
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:InterLabel.text];
    //
    
    NSRange range2 = [InterLabel.text rangeOfString:string2];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range2];
    
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range2];
    
    InterLabel.attributedText=mAttStri;
    
    NSString *string3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
    
    ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 37, [UIScreen mainScreen].bounds.size.width-100, 14)];
    ScoreLabel.text=[NSString stringWithFormat:@"可用安淘惠积分%@积分",string3];
    ScoreLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ScoreLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [InterView addSubview:ScoreLabel];
    
    // 创建对象.
    NSMutableAttributedString *mAttStri3 = [[NSMutableAttributedString alloc] initWithString:ScoreLabel.text];
    //
    
    NSRange range3 = [ScoreLabel.text rangeOfString:string3];
    
    [mAttStri3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range3];
    
    [mAttStri3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:11] range:range3];
    
    ScoreLabel.attributedText=mAttStri3;
    
    
    Switch =[[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 15, 50, 30)];
    
    NSLog(@"===self.sta==%@",self.sta);
    
    if ([self.sta isEqualToString:@"1"]) {
        
        Switch.on = YES;//设置初始为ON的一边
        
    }else{
        
        Switch.on = NO;//设置初始为ON的一边
        Switch.enabled=NO;
        
    }
    
    
    [Switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    
    [InterView addSubview:Switch];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [InterView addSubview:line];
    
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(0, 186+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 61)];
    PayView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:PayView];
    
    GoOnlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 24, [UIScreen mainScreen].bounds.size.width-30, 14)];
    GoOnlabel.text=[NSString stringWithFormat:@"你还需支付￥%.02f",[self.pay_money floatValue]];
    GoOnlabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GoOnlabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [PayView addSubview:GoOnlabel];
    
    NSString *string4 = [NSString stringWithFormat:@"￥%.02f",[self.pay_money floatValue]];
    
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:GoOnlabel.text];
    //
    NSRange range4 = [GoOnlabel.text rangeOfString:string4];
    
    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0] range:range4];
    [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range4];
    GoOnlabel.attributedText=mAttStri1;
    
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [PayView addSubview:line2];
    
    CGRect tempRect = [ScoreLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:12]} context:nil];
    
   
    
    WenHao =[UIButton buttonWithType:UIButtonTypeCustom];
    WenHao.frame =CGRectMake(15+tempRect.size.width, 40, 11, 11);
    [WenHao setBackgroundImage:[UIImage imageNamed:@"提示"] forState:0];
    [WenHao addTarget:self action:@selector(WenHaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [InterView addSubview:WenHao];
    
    
    
    
}

-(void)WenHaoBtnClick:(UIButton *)sender
{
    CGRect tempRect = [ScoreLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:12]} context:nil];

    wenhaoView = [[UIView alloc] initWithFrame:CGRectMake(15+tempRect.size.width+5.5-40, 176+KSafeTopHeight, 80, 40)];
//    wenhaoView.backgroundColor=[UIColor orangeColor];
    
    UIImageView *wenhaoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    wenhaoImg.image = [UIImage imageNamed:@"提示框425"];
    
    [wenhaoView addSubview:wenhaoImg];
    
//    wenhaoView.transform = CGAffineTransformMakeTranslation(200, 0);
//        [UIView animateWithDuration:0.5 animations:^{
//            wenhaoView.transform = CGAffineTransformMakeTranslation(1.0,1.0);
//        }];
    
    
    UILabel *wenhaoLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 70, 40)];
    wenhaoLabel.textColor=[UIColor colorWithRed:93/255.0 green:143/255.0 blue:255/255.0 alpha:1.0];
    wenhaoLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    wenhaoLabel.text =[NSString stringWithFormat:@"积分只能代付总金额的%@",self.proportion];
    wenhaoLabel.numberOfLines=2;
    [wenhaoView addSubview:wenhaoLabel];
    
    [self.view addSubview:wenhaoView];
    
    

    

    

}
-(void)initZhiFuBao
{
    UIView *ZhiFuBao = [[UIView alloc] initWithFrame:CGRectMake(0, 257+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 71)];
    ZhiFuBao.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:ZhiFuBao];
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [ZhiFuBao addSubview:line3];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (71-18)/2, 70, 18)];
    imgView.image = [UIImage imageNamed:@"支付宝"];
    [ZhiFuBao addSubview:imgView];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, (71-20)/2, 20, 20)];
    imgView1.image = [UIImage imageNamed:@"选中523"];
    [ZhiFuBao addSubview:imgView1];
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, [UIScreen mainScreen].bounds.size.height-49-38, [UIScreen mainScreen].bounds.size.width-30, 38)];
    PayView.layer.cornerRadius = 3;
    PayView.layer.masksToBounds = YES;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [PayView.layer addSublayer:gradientLayer];
    
    [self.view addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"立即支付" forState:0];
    Pay.layer.cornerRadius = 3;
    Pay.layer.masksToBounds = YES;
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line4.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [ZhiFuBao addSubview:line4];
    
}

-(void)submitMoneyPay
{
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@phoneSubmitOrder_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    if (Switch.on == YES) {
        
        NSLog(@"开");
        
    }else{
        
        NSLog(@"关");
        self.pay_integral = @"";
        
    }
    
    NSLog(@"===self.sigen==%@",self.Sigen);
    NSLog(@"===self.Phone==%@",self.Phone);
    NSLog(@"===self.type==%@",self.type);
    NSLog(@"===self.pay_integral==%@",self.pay_integral);
    
    
    NSDictionary *dic = @{@"sigen":self.Sigen,@"orderno":self.orderno,@"type":self.type,@"phone":self.Phone,@"pay_integral":self.pay_integral};
    
    NSNull *null = [[NSNull alloc] init];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==立即支付==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"分类查看更多书局=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                self.PayType = dic[@"type"];
                
                self.Status=dic[@"status"];
                
                self.successurl=dic[@"successurl"];
                
                self.APP_ID = dic[@"APP_ID"];
                
                self.SELLER = dic[@"SELLER"];
                
                self.RSA_PRIVAT = dic[@"RSA_PRIVAT"];
                
                self.Pay_orderno = dic[@"orderno"];
                
                self.Notify_url = dic[@"notify_url"];
                
                self.PPay_money = dic[@"pay_money"];
                
                self.Money_url = dic[@"money"];
                
                self.Return_url = dic[@"returnurl"];
                
                if ([dic[@"type"] isEqualToString:@"2"] && ![dic[@"money"] isEqualToString:@""] && ![dic[@"money"] isEqual:null]){//组合支付
                    
                    
                    //调用支付宝支付
                    
                    [self saveAlipayRecord];
                    
                    
                    
                }
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
            
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hud dismiss:YES];
//        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
}

-(void)PayBtnCLick
{
    
    [self submitMoneyPay];
    
    
}

-(void)switchAction:(id)sender
{
    [wenhaoView removeFromSuperview];
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        GoOnlabel.text=[NSString stringWithFormat:@"你还需支付￥%.02f",[self.pay_money floatValue]];
        InterLabel.text=[NSString stringWithFormat:@"积分支付%@",[NSString stringWithFormat:@"￥%.02f",[self.pay_integral floatValue]]];
        
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:InterLabel.text];
        //
        
        NSRange range2 = [InterLabel.text rangeOfString:[NSString stringWithFormat:@"￥%.02f",[self.pay_integral floatValue]]];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range2];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range2];
        
        InterLabel.attributedText=mAttStri;
        
        
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:GoOnlabel.text];
        //
        NSRange range4 = [GoOnlabel.text rangeOfString:[NSString stringWithFormat:@"￥%.02f",[self.pay_money floatValue]]];
        
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0] range:range4];
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range4];
        GoOnlabel.attributedText=mAttStri1;
        
        
        
    }else {
        NSLog(@"关");
        GoOnlabel.text=[NSString stringWithFormat:@"你还需支付￥%.02f",[self.pay_money floatValue]+[self.pay_integral floatValue]];
        InterLabel.text=[NSString stringWithFormat:@"积分支付%@",[NSString stringWithFormat:@"￥0.00"]];
        
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:InterLabel.text];
        //
        
        NSRange range2 = [InterLabel.text rangeOfString:[NSString stringWithFormat:@"￥0.00"]];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range2];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range2];
        
        InterLabel.attributedText=mAttStri;
        
        
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:GoOnlabel.text];
        //
        NSRange range4 = [GoOnlabel.text rangeOfString:[NSString stringWithFormat:@"￥%.02f",[self.pay_money floatValue]+[self.pay_integral floatValue]]];
        
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0] range:range4];
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range4];
        GoOnlabel.attributedText=mAttStri1;
        
        
    }
}

-(void)QurtBtnClick
{
    [wenhaoView removeFromSuperview];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"就只有一步完成购买" message:nil delegate:self cancelButtonTitle:@"待会再买" otherButtonTitles:@"继续付款", nil];
    alert.delegate=self;
    
    [alert show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        NSLog(@"继续付款");
        
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        
        [vc selectedDingDanType:@"1" AndIndexType:1];
       // self.type;
        NSString *type=@"2";
        if ([self.title isEqualToString:@"话费充值"]) {
            type=@"1";
        }

        PersonalBMDetailVC *vc2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:self.orderno AndOrderType:type];
        vc2.delegate=vc;

        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
        [self.navigationController pushViewController:vc2 animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
        
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [wenhaoView removeFromSuperview];
    
    
}

-(void)saveAlipayRecord
{
    
    NSLog(@"====self.Pay_orderno=====%@",self.Pay_orderno);
    NSLog(@"====self.Money_url=====%@",self.Money_url);
    NSLog(@"====self.Return_url=====%@",self.Return_url);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@saveAlipayRecord.shtml",URL_Str1];
    //saveUserExchange_mob.shtml
    
    
    NSDictionary *dic = @{@"pay_order":self.Pay_orderno,@"pay_money":self.Money_url,@"clientId":@"10003",@"describe":@"IOS",@"returnurl":self.Return_url};
    
    //        NSDictionary *dic=nil;
    //        NSDictionary *dic = @{@"classId":@"129"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"========保存支付宝信息==%@",dic);
            
            for (NSDictionary *dict1 in dic) {
                
                self.Alipay_Goods_name =dict1[@"goods_name"];
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                    
                    [self GoALiPay];
                    
                    
                }else{
                    
                    [JRToast showWithText:dict1[@"message"] duration:2.0f];
                }
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        //        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    

    
    
    
    
}

-(void)GoALiPay
{
    
    
    
    //    [UserMessageManager removeUserWord];
    
    NSLog(@"===self.APP_ID===%@===self.SELLER=%@===self.RSA_PRIVAT=%@==self.Pay_money===%@==self.Pay_orderno===%@==self.Notify_url==%@",self.APP_ID,self.SELLER,self.RSA_PRIVAT,self.PPay_money,self.Pay_orderno,self.Notify_url);
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    //    NSString *appID = @"2016102002254231";
    
    NSString *appID = self.APP_ID;
    
    //    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMTmGiHlcAdESK9KcP7vmvSS8uO75JBW+O5ruS1SD+iuWRfFiBplBkZJ57a/LFRwZDvaC/7klSXTRhn4KbHuVfIGXc3j6F1BpWkh7Cks8FOGb86o5wHbbsLWC6JmMAhTIypcIuREKWQ5a9219GTzG/PhBeNdg+EklvlFyr3rCBlRAgMBAAECgYEAsWNoma8eDb3sCdh0EomFPeCB6L/nPE7Ot+XfD8CFyqgAZhU0+CqZy4tbsV1sL6qN8woPkpUW9dvwpQbZcY76Z5uQ29w6NyXn20rqlcw2qNUPCgxagHAKVohQSFpMl3hj2L2Nw1q3KapwVkZ918r5ksLUBrlb3cCBo9WdxtyAGB0CQQDpgsz4TPAXA4jFfAD3FMxoom3Xdy+AJC43sGflUTyureqL0g/xHTB4CQW9n2ygGn9qk+Now08tV0J6RRrJ7zNjAkEA19yhy90/NwdHBpOK/6dGzweSud+hZx7UYNy4JhC9pppVP5ECNnJC7rnN3BIMuIKSkr8DwKi6HSn5Bgo7uRkwuwJAT9kEUdutNZFl0XHHurWH+Deiq8z7lyvICg7uWAHhaDHcRBd+kApVKpabOe4r7MtiyoTrfEVc67os5zZ+JJMA1QJAM83PRo2iTiKA+SMPiKssYyL+I313zrenYFeYGgqKeSEwtECot0hUp9YPgXETfHRZmL4euG3FvJoGGVz7WECjYQJBAL8W1pQpZcUgLppoSwgsjitLv1Xe0GNWJm0vql7zCLsAMF7+w1fY3LHuJP/RfHDX5aswfSa/s7Ox6iV5MSlgGnk=";
    
    NSString *privateKey = self.RSA_PRIVAT;
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    
    //回调
    order.notify_url=self.Notify_url;
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"2.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    order.return_url = self.successurl;
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"安淘惠";
    order.biz_content.subject = self.Alipay_Goods_name;
    
    NSLog(@"==self.Alipay_Goods_name==%@",self.Alipay_Goods_name);
    
    //    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.out_trade_no = self.Pay_orderno; //订单ID（由商家自行制定）
    
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.02f", [self.PPay_money floatValue]]; //商品价格
if (ISTEXTPRICE) {
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.02f", 0.01]; //商品价格
}
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"aTaohPay";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            
            
            NSLog(@"reslut = %@",resultDic);
            WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:@"" animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud dismiss:YES];
                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {

                    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                    //读取数组NSArray类型的数据

                    PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                    [vc selectedDingDanType:@"1" AndIndexType:2];

                    NSString *type=@"2";
                    if ([self.title isEqualToString:@"话费充值"]) {
                        type=@"1";
                    }
                    PersonalBMDetailVC *vc2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:self.orderno AndOrderType:type];
                    vc2.delegate=vc;
                    self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
                    [self.navigationController pushViewController:vc2 animated:NO];



                }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){

                    [JRToast showWithText:@"正在处理中" duration:2.0f];


                }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){


                    [JRToast showWithText:@"订单支付失败" duration:2.0f];

                }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){

                    [JRToast showWithText:@"用户中途取消" duration:2.0f];
                    PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                    [vc selectedDingDanType:@"1" AndIndexType:1];
                    NSString *type=@"2";
                    if ([self.title isEqualToString:@"话费充值"]) {
                        type=@"1";
                    }

                    PersonalBMDetailVC *vc2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:self.orderno AndOrderType:type];
                    vc2.delegate=vc;
                    self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
                    [self.navigationController pushViewController:vc2 animated:NO];
                    self.navigationController.navigationBar.hidden=YES;

                }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){

                    [JRToast showWithText:@"网络连接出错" duration:2.0f];
                }
            });

            
            
        }];
        //
        
        
        
    }
    
    
}


-(void)resultStatus:(NSNotification *)text
{
    
    WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:@"" animated:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"1" AndIndexType:2];
        NSString *type=@"2";
        if ([self.title isEqualToString:@"话费充值"]) {
            type=@"1";
        }

        PersonalBMDetailVC *vc2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:self.orderno AndOrderType:type];
        vc2.delegate=vc;
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
        [self.navigationController pushViewController:vc2 animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){
        
        [JRToast showWithText:@"正在处理中" duration:2.0f];
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){
        
        
        [JRToast showWithText:@"订单支付失败" duration:2.0f];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){
        
        [JRToast showWithText:@"用户中途取消" duration:2.0f];

        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"1" AndIndexType:1];
        NSString *type=@"2";
        if ([self.title isEqualToString:@"话费充值"]) {
            type=@"1";
        }

        PersonalBMDetailVC *vc2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:self.orderno AndOrderType:type];
        vc2.delegate=vc;
        self.tabBarController.tabBar.hidden=YES;
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
        [self.navigationController pushViewController:vc2 animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){
        
        [JRToast showWithText:@"网络连接出错" duration:2.0f];
    }
    });
}

-(void)HuoQuanXian
{
    
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    //    NSString *pid = @"2088712201847501";
    //    NSString *appID = @"2016102002254231";
    //    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMTmGiHlcAdESK9KcP7vmvSS8uO75JBW+O5ruS1SD+iuWRfFiBplBkZJ57a/LFRwZDvaC/7klSXTRhn4KbHuVfIGXc3j6F1BpWkh7Cks8FOGb86o5wHbbsLWC6JmMAhTIypcIuREKWQ5a9219GTzG/PhBeNdg+EklvlFyr3rCBlRAgMBAAECgYEAsWNoma8eDb3sCdh0EomFPeCB6L/nPE7Ot+XfD8CFyqgAZhU0+CqZy4tbsV1sL6qN8woPkpUW9dvwpQbZcY76Z5uQ29w6NyXn20rqlcw2qNUPCgxagHAKVohQSFpMl3hj2L2Nw1q3KapwVkZ918r5ksLUBrlb3cCBo9WdxtyAGB0CQQDpgsz4TPAXA4jFfAD3FMxoom3Xdy+AJC43sGflUTyureqL0g/xHTB4CQW9n2ygGn9qk+Now08tV0J6RRrJ7zNjAkEA19yhy90/NwdHBpOK/6dGzweSud+hZx7UYNy4JhC9pppVP5ECNnJC7rnN3BIMuIKSkr8DwKi6HSn5Bgo7uRkwuwJAT9kEUdutNZFl0XHHurWH+Deiq8z7lyvICg7uWAHhaDHcRBd+kApVKpabOe4r7MtiyoTrfEVc67os5zZ+JJMA1QJAM83PRo2iTiKA+SMPiKssYyL+I313zrenYFeYGgqKeSEwtECot0hUp9YPgXETfHRZmL4euG3FvJoGGVz7WECjYQJBAL8W1pQpZcUgLppoSwgsjitLv1Xe0GNWJm0vql7zCLsAMF7+w1fY3LHuJP/RfHDX5aswfSa/s7Ox6iV5MSlgGnk=";
    
    NSString *pid = self.SELLER;
    NSString *appID = self.APP_ID;
    NSString *privateKey = self.RSA_PRIVAT;
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少pid或者appID或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //生成 auth info 对象
    APAuthV2Info *authInfo = [APAuthV2Info new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"aTaohPay";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:authInfoStr];
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, @"RSA"];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               
                                               
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    }
    
}


@end
