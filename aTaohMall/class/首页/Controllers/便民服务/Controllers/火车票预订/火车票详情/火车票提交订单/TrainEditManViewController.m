//
//  TrainEditManViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/7/13.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainEditManViewController.h"

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

#import "ZZLimitInputManager.h"

#import "WKProgressHUD.h"
@interface TrainEditManViewController ()<ZHPickViewDelegate,APNumberPadDelegate,UIAlertViewDelegate>
{
    
    UITextField *IdTF;
    UITextField *NameTF;
    
}

@end

@implementation TrainEditManViewController

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
    
    label.text = @"编辑乘车人";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}

-(void)initOtherView
{
    
    UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, 70+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 200)];
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
    
    NameTF = [[UITextField alloc] initWithFrame:CGRectMake(90, (50-13)/2, [UIScreen mainScreen].bounds.size.width-90, 13)];
    NameTF.placeholder = @"请输入完整姓名";
    NameTF.text = self.Username;
    [ZZLimitInputManager limitInputView:NameTF maxLength:11];
    NameTF.textColor = RGB(51, 51, 51);
    NameTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [NameView addSubview:NameTF];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    imgView.image = [UIImage imageNamed:@"分割线-拷贝"];
    [NameView addSubview:imgView];
    
    UIView *TypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
    TypeView.backgroundColor = [UIColor whiteColor];
    [ManView addSubview:TypeView];
    
    UILabel *TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    TypeLabel.text = @"证件类型";
    TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    TypeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [TypeView addSubview:TypeLabel];
    
    UILabel *TypeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, (50-13)/2, 100, 13)];
    TypeNameLabel.text = @"身份证";
    TypeNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    TypeNameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [TypeView addSubview:TypeNameLabel];
    
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    imgView1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [TypeView addSubview:imgView1];
    
    
    UIView *IdView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    IdView.backgroundColor = [UIColor whiteColor];
    [ManView addSubview:IdView];
    
    UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    IdLabel.text = @"证件号码";
    IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IdView addSubview:IdLabel];
    
    IdTF = [[UITextField alloc] initWithFrame:CGRectMake(90, (50-13)/2, [UIScreen mainScreen].bounds.size.width-150, 13)];
    IdTF.placeholder = @"请输入证件号码";
    IdTF.text = self.PassId;
    [ZZLimitInputManager limitInputView:IdTF maxLength:18];
    IdTF.textColor = RGB(51, 51, 51);
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
    
    UIView *OldView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 50)];
    OldView.backgroundColor = [UIColor whiteColor];
    [ManView addSubview:OldView];
    
    UILabel *OldLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    OldLabel.text = @"乘客类型";
    OldLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    OldLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OldView addSubview:OldLabel];
    
    UILabel *OldNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, (50-13)/2, 100, 13)];
    OldNameLabel.text = @"成人";
    OldNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    OldNameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OldView addSubview:OldNameLabel];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    imgView3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [OldView addSubview:imgView3];
    
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width/2, 49)];
    //    redView.layer.cornerRadius = 3.0f;
    //    redView.layer.masksToBounds = YES;
    [self.view addSubview:redView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 49);
    [redView.layer addSublayer:gradientLayer];
    
    UIButton *Add = [UIButton buttonWithType:UIButtonTypeCustom];
    Add.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 49);
    [Add setTitle:@"确定" forState:0];
    [Add setTitleColor:[UIColor whiteColor] forState:0];
    Add.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
    [redView addSubview:Add];
    [Add  addTarget:self action:@selector(AddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *Delete = [UIButton buttonWithType:UIButtonTypeCustom];
    Delete.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width/2, 49);
    Delete.backgroundColor = [UIColor whiteColor];
    [Delete setTitle:@"删除" forState:0];
    [Delete setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    Delete.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
    [self.view addSubview:Delete];
    [Delete  addTarget:self action:@selector(DeleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
            
            
            if (IdTF.text.length == 0) {
                
                [TrainToast showWithText:@"身份证号码错误" duration:2.0f];
                
            }else{
                
                //验证身份证
                NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
                
                NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
                
                BOOL ret = [identityCardPredicate evaluateWithObject:IdTF.text];
                
                if (!ret) {
                    
                    [TrainToast showWithText:@"身份证号码错误" duration:2.0f];
                    
                }else{
                    
                    
                    [self getDatas];
                    
                }
            }
        }
    }
    
}


-(void)DeleteBtnClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要删除该乘车人？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        
    }else{
        
        [self Delete];
        
    }
}

//编辑
-(void)Delete
{
    
    
  //  WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
   WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@deleteTrainPassengers_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"sigen":self.sigen,@"id":self.ManId};
    
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
                
                if (_delegate && [_delegate respondsToSelector:@selector(TrainEditData)]) {
                    
                    [_delegate TrainEditData];
                }
                
                [self.navigationController popViewControllerAnimated:NO];
                
                
            }else{
                
                [TrainToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            
            
            [hud dismiss:YES];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        [hud dismiss:YES];
        
        
    }];
    
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
    
    NSString *url = [NSString stringWithFormat:@"%@editorTrainPassengers_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"sigen":self.sigen,@"id":self.ManId,@"username":NameTF.text,@"passportseno":IdTF.text,@"passporttypeseid":@"1",@"air_passenger":@"1"};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=修改乘车人=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"乘车人信息=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                if (_delegate && [_delegate respondsToSelector:@selector(TrainEditData)]) {
                    
                    [_delegate TrainEditData];
                    
                }
                
                [self.navigationController popViewControllerAnimated:NO];
                
            }else{
                
                
                [TrainToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        [hud dismiss:YES];
        
    }];
    
}

#pragma mark - APNumberPadDelegate

- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    if ([textInput isEqual:IdTF]) {
        [functionButton setTitle:[functionButton.currentTitle stringByAppendingString:@""] forState:UIControlStateNormal];
        [textInput insertText:@"X"];
    }
    
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
