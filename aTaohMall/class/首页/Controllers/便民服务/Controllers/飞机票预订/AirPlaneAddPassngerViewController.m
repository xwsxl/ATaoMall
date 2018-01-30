//
//  AirPlaneAddPassngerViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneAddPassngerViewController.h"

#import "AirManTypeView.h"
#import "TrainToast.h"
#import "AirPlaneNameShowView.h"
#import "AirPlaneTeShuView.h"

#import "ZHPickView.h"

#import "APNumberPad.h"
#import "APDarkPadStyle.h"
#import "APBluePadStyle.h"

#import "ZZLimitInputManager.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"

#import "WKProgressHUD.h"

#import "JRToast.h"
@interface AirPlaneAddPassngerViewController ()<AirManTypeDelegate,ZHPickViewDelegate,APNumberPadDelegate>
{
    
    AirManTypeView *_manTypeView;
    AirPlaneNameShowView *_nameShowView;
    AirPlaneTeShuView *_teshuView;
    UILabel *TypeNameLabel;
    UITextField *IdTF;
    UITextField *NameTF;
    UITextField *PhoneTF;
}
@end

@implementation AirPlaneAddPassngerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    [self initNav];
    
    [self initOtherView];
    
    _manTypeView = [[AirManTypeView alloc] init];
    _manTypeView.delegate=self;
    [self.view addSubview:_manTypeView];
    
    _nameShowView = [[AirPlaneNameShowView alloc] init];
    [self.view addSubview:_nameShowView];
    
    _teshuView = [[AirPlaneTeShuView alloc] init];
    [self.view addSubview:_teshuView];
    
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
    
    label.text = @"新增乘机人";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initOtherView
{
    
    UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, 70+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 150)];
    ManView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ManView];
    
    UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    NameView.backgroundColor = [UIColor whiteColor];
    [ManView addSubview:NameView];
    
    UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    NameLabel.text = @"乘客姓名";
    NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [NameView addSubview:NameLabel];
    
    NameTF = [[UITextField alloc] initWithFrame:CGRectMake(90, (50-13)/2, [UIScreen mainScreen].bounds.size.width-150, 13)];
    NameTF.placeholder = @"与乘机人证件一致";
    [ZZLimitInputManager limitInputView:NameTF maxLength:11];
    NameTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    NameTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [NameView addSubview:NameTF];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    imgView.image = [UIImage imageNamed:@"分割线-拷贝"];
    [NameView addSubview:imgView];
    
    
    UIButton *WenHao = [UIButton buttonWithType:UIButtonTypeCustom];
    WenHao.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30, (50-15)/2, 15, 15);
    [WenHao setImage:[UIImage imageNamed:@"icon-question"] forState:0];
    [NameView addSubview:WenHao];
    [WenHao  addTarget:self action:@selector(WenHaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIView *TypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
//    TypeView.backgroundColor = [UIColor whiteColor];
//    [ManView addSubview:TypeView];
//    
//    UILabel *TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
//    TypeLabel.text = @"证件类型";
//    TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    TypeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
//    [TypeView addSubview:TypeLabel];
//    
//    TypeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, (50-13)/2, 100, 13)];
////    TypeNameLabel.text = @"身份证";
//    TypeNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    TypeNameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
//    [TypeView addSubview:TypeNameLabel];
//    
//    UIImageView *online = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-20, (50-14)/2, 8, 14)];
//    online.image = [UIImage imageNamed:@"icon_more"];
//    [TypeView addSubview:online];
//    
//    UIButton *TypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    TypeButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
//    [TypeButton addTarget:self action:@selector(TypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [TypeView addSubview:TypeButton];
    
//    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
//    imgView1.image = [UIImage imageNamed:@"分割线-拷贝"];
//    [TypeView addSubview:imgView1];
    
    
    UIView *IdView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
    IdView.backgroundColor = [UIColor whiteColor];
    [ManView addSubview:IdView];
    
    UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    IdLabel.text = @"证件号码";
    IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IdView addSubview:IdLabel];
    
    IdTF = [[UITextField alloc] initWithFrame:CGRectMake(90, (50-13)/2, [UIScreen mainScreen].bounds.size.width-150, 13)];
    IdTF.placeholder = @"请输入证件号码";
    [ZZLimitInputManager limitInputView:IdTF maxLength:18];
    IdTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    IdTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IdView addSubview:IdTF];
    
    IdTF.inputView = ({
        APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self];
        
        [numberPad.leftFunctionButton setTitle:@"X" forState:UIControlStateNormal];
        numberPad.leftFunctionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        numberPad;
    });
    
    
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    imgView2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [IdView addSubview:imgView2];
    
    UIView *OldView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    OldView.backgroundColor = [UIColor whiteColor];
    [ManView addSubview:OldView];
    
    UILabel *PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    PhoneLabel.text = @"手机号";
    PhoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PhoneLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OldView addSubview:PhoneLabel];
    
    PhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(90, (50-13)/2, [UIScreen mainScreen].bounds.size.width-150, 13)];
    PhoneTF.keyboardType = UIKeyboardTypeNumberPad;
    PhoneTF.placeholder = @"用于接收航班通知";
    PhoneTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    PhoneTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [ZZLimitInputManager limitInputView:PhoneTF maxLength:11];
    [OldView addSubview:PhoneTF];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    imgView3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [OldView addSubview:imgView3];
    
    
    UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 230, 12, 12)];
    ImgView.image = [UIImage imageNamed:@"icon_tip-blue"];
    [self.view addSubview:ImgView];
    
    
    UIButton *TeShu = [UIButton buttonWithType:UIButtonTypeCustom];
    TeShu.frame = CGRectMake(15, 230+KSafeTopHeight, 200, 12);
    //    [TeShu setImage:[UIImage imageNamed:@"icon_tip-blue"] forState:0];
    [self.view addSubview:TeShu];
    [TeShu  addTarget:self action:@selector(TeShuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *TeShuLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 230+KSafeTopHeight, 100, 12)];
    TeShuLabel.text = @"特殊乘客购票须知";
    TeShuLabel.textColor = [UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0];
    TeShuLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self.view addSubview:TeShuLabel];
    
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(15, 220+50+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 38)];
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

//代理方法
-(void)AirManType:(NSString *)type
{
    
    TypeNameLabel.text = type;
}
-(void)TypeBtnClick
{
    [self.view endEditing:YES];
    
    [_manTypeView showInView:self.view];
    
    
}

-(void)TeShuBtnClick
{
    [_teshuView showInView:self.view];
    
    
}
-(void)WenHaoBtnClick
{
    
    [_nameShowView showInView:self.view];
    
}
-(void)AddBtnClick
{
    if (NameTF.text.length==0) {
        
        [TrainToast showWithText:@"请输入11汉字以内姓名" duration:2.0f];
        
    }else{
        
        
        //用户名是否为汉字
        NSString *CM_NUM = @"^[\u4e00-\u9fa5]{0,}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:NameTF.text];
        
        if (!isMatch1) {
        
            [TrainToast showWithText:@"请输入11汉字以内姓名" duration:2.0f];
            
        }else{
        
//            if (TypeNameLabel.text.length==0) {
//                
//                [TrainToast showWithText:@"请选择证件类型" duration:2.0f];
//                
//            }else{
            
                if (IdTF.text.length == 0) {
                    
                    [TrainToast showWithText:@"请填写身份证号码" duration:2.0f];
                    
                }else{
                    
                    //验证身份证
                    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
                    
                    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
                    
                    BOOL ret = [identityCardPredicate evaluateWithObject:IdTF.text];
                    
                    if (!ret) {
                        
                        [TrainToast showWithText:@"身份证号码错误" duration:2.0f];
                        
                    }else{
                        
                        if (PhoneTF.text.length == 0) {
                            
                            [TrainToast showWithText:@"手机号格式错误" duration:2.0f];
                            
                        }else{
                            
                            /**
                             * 移动号段正则表达式
                             */
                            NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
                            /**
                             * 联通号段正则表达式
                             */
                            NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
                            /**
                             * 电信号段正则表达式
                             */
                            NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
                            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
                            BOOL isMatch1 = [pred1 evaluateWithObject:PhoneTF.text];
                            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                            BOOL isMatch2 = [pred2 evaluateWithObject:PhoneTF.text];
                            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                            
                            BOOL isMatch3 = [pred3 evaluateWithObject:PhoneTF.text];
                            
                            if (!(isMatch1 || isMatch2 || isMatch3)) {
                                
                                
                                 [TrainToast showWithText:@"手机号格式错误" duration:2.0f];
                                
                              }else{
                                
                                  NSLog(@"=====%@",NameTF.text);
                                  NSLog(@"=====%@",TypeNameLabel.text);
                                  NSLog(@"=====%@",IdTF.text);
                                  NSLog(@"=====%@",PhoneTF.text);
                                  
                                  [self getDatas];
                        }
                    }
//                }
             }
          }
       }
    }
}


-(void)getDatas
{
    
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@addAirPassenger_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSString *string;
    if ([TypeNameLabel.text isEqualToString:@"身份证"]) {
        
        string = @"1";
        
    }else if([TypeNameLabel.text isEqualToString:@"户口簿"]){
        
        string = @"7";
        
    }
    NSDictionary *dict = @{@"sigen":self.sigen,@"passenger_name":NameTF.text,@"certificate_number":IdTF.text,@"passenger_phone":PhoneTF.text};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"分类查看更多书局=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                if (_delegate && [_delegate respondsToSelector:@selector(AirPlaneAddPassnger)]) {
                    
                    [_delegate AirPlaneAddPassnger];
                    
                }
                
                [self.navigationController popViewControllerAnimated:NO];
                
                
            }else{
                
                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            
            
            [hud dismiss:YES];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        [hud dismiss:YES];
        
        
    }];
    
}


-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - APNumberPadDelegate

- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    if ([textInput isEqual:IdTF]) {
        [functionButton setTitle:[functionButton.currentTitle stringByAppendingString:@""] forState:UIControlStateNormal];
        [textInput insertText:@"X"];
    }
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
@end
