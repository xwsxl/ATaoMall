//
//  TrainAddKidViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/7/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainAddKidViewController.h"

#import "TrainToast.h"

#import "AFNetworking.h"
#import "TrainToast.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"
#import "ZHPickView.h"

#import "APNumberPad.h"
#import "APDarkPadStyle.h"
#import "APBluePadStyle.h"
#import "WKProgressHUD.h"
#import "ZZLimitInputManager.h"
#import "TrainKidTextViewController.h"
#import "UICustomDatePicker.h"

@interface TrainAddKidViewController ()<ZHPickViewDelegate>
{
    
    UITextField *IdTF;
    UITextField *NameTF;
    UILabel *TypeNameLabel;
    
}

@end

@implementation TrainAddKidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    [self initNav];
    
    [self initOtherView];
    
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
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"添加随行儿童";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}

-(void)initOtherView
{
    
    UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, 70+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 100)];
    ManView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ManView];
    
    UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    NameView.backgroundColor = [UIColor whiteColor];
    [ManView addSubview:NameView];
    
    UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    NameLabel.text = @"儿童姓名";
    NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [NameView addSubview:NameLabel];
    
    NameTF = [[UITextField alloc] initWithFrame:CGRectMake(90, (50-13)/2, [UIScreen mainScreen].bounds.size.width-90, 13)];
    NameTF.placeholder = @"请输入随行儿童姓名";
    [ZZLimitInputManager limitInputView:NameTF maxLength:11];
    NameTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    
    [NameView addSubview:NameTF];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    imgView.image = [UIImage imageNamed:@"分割线-拷贝"];
    [NameView addSubview:imgView];
    
    UIView *TypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
    TypeView.backgroundColor = [UIColor whiteColor];
    [ManView addSubview:TypeView];
    
    UILabel *TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    TypeLabel.text = @"出生日期";
    TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    TypeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [TypeView addSubview:TypeLabel];
    
    TypeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, (50-13)/2, 200, 13)];
    TypeNameLabel.attributedText=NameTF.attributedPlaceholder;
    TypeNameLabel.text = @"请输入随行儿童出生日期";
    
    NSLog(@"placehodle=%@",[NameTF valueForKeyPath:@"_placeholderLabel.textColor"]);
    TypeNameLabel.textColor=[NameTF valueForKeyPath:@"_placeholderLabel.textColor"];
   // TypeNameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    TypeNameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [TypeView addSubview:TypeNameLabel];
    
    UIButton *TypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    TypeButton.frame  =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    [TypeView addSubview:TypeButton];
    [TypeButton addTarget:self action:@selector(DateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    imgView1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [TypeView addSubview:imgView1];
    
    
    UILabel *TextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 180+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 35)];
    TextLabel.text = @"*请确保随行儿童身高1.5米以下，超过1.5米请购买成人票（若无有效证件请到车站窗口购票）。";
    TextLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    TextLabel.numberOfLines = 2;
    TextLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self.view addSubview:TextLabel];
    
    UIButton *TextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    TextButton.frame = CGRectMake(15, 210+KSafeTopHeight, 70, 38);
    [TextButton setTitle:@"儿童购票说明" forState:0];
    [TextButton setTitleColor:[UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0] forState:0];
    TextButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11.5];
    TextButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:TextButton];
    
    [TextButton  addTarget:self action:@selector(TextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(15, 271+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 38)];
    redView.layer.cornerRadius = 3.0f;
    redView.layer.masksToBounds = YES;
    [self.view addSubview:redView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [redView.layer addSublayer:gradientLayer];
    
    UIButton *Add = [UIButton buttonWithType:UIButtonTypeCustom];
    Add.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [Add setTitle:@"添加" forState:0];
    [Add setTitleColor:[UIColor whiteColor] forState:0];
    Add.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [redView addSubview:Add];
    [Add  addTarget:self action:@selector(AddBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)AddBtnClick
{
    if (NameTF.text.length==0) {
        
        [TrainToast showWithText:@"请输入儿童姓名" duration:2.0f];
        
    }else{
        
        //用户名是否为汉字
        NSString *CM_NUM = @"^[·\u4e00-\u9fa5]{0,}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:NameTF.text];
        
        if (!isMatch1) {
            
            [TrainToast showWithText:@"请输入11汉字以内姓名" duration:2.0f];
            
        }else{
            
            
            if ([TypeNameLabel.text isEqualToString:@"请输入随行儿童出生日期"]) {
                
                [TrainToast showWithText:@"请输入出生日期" duration:2.0f];
                
            }else{
                
                [self getDatas];
            }
        }
    }
    
}

-(void)getDatas
{
    
 //   WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@addTrainChildrenPassengers_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"sigen":self.sigen,@"id":self.IId,@"passportseno":self.passportseno,@"username":NameTF.text,@"date":TypeNameLabel.text};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=新增儿童=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"乘车人信息=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict in dic[@"list"]) {
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(TrainKid:Name:Passportseno:Index:)]) {
                        
                        [_delegate TrainKid:[NSString stringWithFormat:@"%@",dict[@"id"]] Name:[NSString stringWithFormat:@"%@",dict[@"username"]] Passportseno:[NSString stringWithFormat:@"%@",dict[@"passportseno"]] Index:self.Index];
                        
                    }
                    
                }
                
                
                [self.navigationController popViewControllerAnimated:NO];
                
            }else{
                
                
                [TrainToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hud dismiss:YES];
        NSLog(@"%@",error);
        
        
    }];
    
}

//儿童票说明
-(void)TextButtonClick
{
    TrainKidTextViewController *vc = [[TrainKidTextViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
    
}

-(void)DateBtnClick
{
    
    [self.view endEditing:YES];
    
    __weak TrainAddKidViewController *vc = self;
    [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
        __strong TrainAddKidViewController *ss = vc;
        
        NSLog(@"current Date:%@",date);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        //将NSDate转换成指定格式的字符串
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *dateString = [formatter stringFromDate:date];
        
        NSLog(@"===格式化日期==%@",dateString);
        TypeNameLabel.text = dateString;
        TypeNameLabel.textColor = RGB(51, 51, 51);
        
    } cancelBlock:^{
        
        TypeNameLabel.text = @"请输入随行儿童出生日期";
        TypeNameLabel.textColor =[NameTF valueForKeyPath:@"_placeholderLabel.textColor"];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
