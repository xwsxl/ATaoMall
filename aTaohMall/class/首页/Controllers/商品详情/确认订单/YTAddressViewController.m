//
//  YTAddressViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/11.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTAddressViewController.h"
#import "JSAddressPickerView.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#import "STPickerArea.h"
#import "UIView+RGSize.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UserMessageManager.h"

#import "WKProgressHUD.h"

#import "ZZLimitInputManager.h"

#import "JRToast.h"

#import "QueDingDingDanViewController.h"
@interface YTAddressViewController ()<JSAddressPickerDelegate>
{
    UIView *view;
    UIAlertController *alertCon;
}
@property (strong, nonatomic) UIView *maskView;

@property (nonatomic, strong) JSAddressPickerView *pickerView;

@end

@implementation YTAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.defaultstate=@"0";
    
    if ([self.YTString isEqualToString:@"100"]) {
        
        [self.YTSwitch setOn:YES animated:NO];
        self.defaultstate=@"1";
    }
    
    
    NSLog(@"%@",self.defaultstate);
    
    
    //用户名
    [ZZLimitInputManager limitInputView:self.YTUserNameTF maxLength:20];
    
    //手机
    [ZZLimitInputManager limitInputView:self.YTUSerPhoneTF maxLength:11];

    [ZZLimitInputManager limitInputView:self.YTDeatilTF maxLength:30];
    
    
}

- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//判断是否为手机号
+ (NSString *)valiMobile:(NSString *)mobile{
    
    if (mobile.length < 11)
    {
        return @"手机号长度只能是11位";
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
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的*****号码";
        }
    }
    return nil;
    
}


- (IBAction)YTChoseBtnClick:(UIButton *)sender {
    
    [self.YTDeatilTF resignFirstResponder];
    [self.YTUserNameTF resignFirstResponder];
    [self.YTUSerPhoneTF resignFirstResponder];
    
    
    if (self.pickerView) {
        self.pickerView.hidden = NO;
        return;
    }
    self.pickerView = [[JSAddressPickerView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [self.pickerView updateAddressAtProvince:@"湖南省" city:@"常德市" town:@"石门县"];
    self.pickerView.delegate = self;
    self.pickerView.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:self.pickerView];
}

- (IBAction)YTSwitch:(UISwitch *)sender {
    
    if (sender.isOn) {
        self.defaultstate=@"1";
        NSLog(@"%@",self.defaultstate);
    }else{
        self.defaultstate=@"0";
        NSLog(@"%@",self.defaultstate);
    }
    
}


- (IBAction)YTSaveBtnClick:(UIButton *)sender {
    
    if (self.YTUserNameTF.text.length == 0) {
        
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写收货人" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
        
        [JRToast showWithText:@"请填写收货人" duration:3.0f];
        
        
    }else{
        
//        if (self.YTUserNameTF.text.length < 2) {
//            
//            //用户名长度小于4
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货人姓名不能为单个字" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//        }else{
//            
//            //用户名是否为汉字
//            NSString *CM_NUM = @"^[\u4e00-\u9fa5]{0,}$";
//            
//            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//            
//            BOOL isMatch1 = [pred1 evaluateWithObject:self.YTUserNameTF.text];
//            
//            if (!isMatch1) {
//                
//                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货人姓名只能为汉字" preferredStyle:UIAlertControllerStyleAlert];
//                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                [self presentViewController: alertCon animated: YES completion: nil];
//                
//                
//            }else{
        
                if (self.YTUSerPhoneTF.text.length == 0) {


                    [JRToast showWithText:@"请添加手机号码" duration:3.0f];
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
                    BOOL isMatch1 = [pred1 evaluateWithObject:self.YTUSerPhoneTF.text];
                    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                    BOOL isMatch2 = [pred2 evaluateWithObject:self.YTUSerPhoneTF.text];
                    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                    
                    BOOL isMatch3 = [pred3 evaluateWithObject:self.YTUSerPhoneTF.text];
                    
                    if (self.YTUSerPhoneTF.text.length<11) {
                        
//                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号码只能为11位数字" preferredStyle:UIAlertControllerStyleAlert];
//                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                         [JRToast showWithText:@"手机号码只能为11位数字" duration:3.0f];
                        
                        
                    }else{
                        
                        NSLog(@"=======*****====%ld",self.YTAddressLabel.text.length);
                        
                        if (self.YTAddressLabel.text.length==4) {
                            
//                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择所在地区" preferredStyle:UIAlertControllerStyleAlert];
//                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                            [JRToast showWithText:@"请选择所在地区" duration:3.0f];
                            
                            
                        }else{
                            
                            if (self.YTDeatilTF.text.length == 0) {
                                
//                                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写详细地址" preferredStyle:UIAlertControllerStyleAlert];
//                                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                                [self presentViewController: alertCon animated: YES completion: nil];
                                
                                [JRToast showWithText:@"请填写详细地址" duration:3.0f];
                                
                                
                            }else if (self.YTDeatilTF.text.length >30) {
                                self.YTDeatilTF.text=[self.YTDeatilTF.text substringToIndex:30];
                                [JRToast showWithText:@"详细地址最多可填写30字" duration:3.0f];

                            }else{
                                
//                                NSString *CM_NUM = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
//                                
//                                NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//                                
//                                BOOL isMatch1 = [pred1 evaluateWithObject:self.YTDeatilTF.text];
//                                
//                                if (!isMatch1) {
//                                    
//                                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货地址只能是数字/字母/汉字" preferredStyle:UIAlertControllerStyleAlert];
//                                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                                    [self presentViewController: alertCon animated: YES completion: nil];
//                                }else{
                                
                                    //添加
                                    [self TianJiaBtnClick];

//                                }
                            }
                        }
                    }
                }
            }
        }
 //   }
//}


-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:view];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-82)/2, 100, 82, 68)];
    
    image.image=[UIImage imageNamed:@"网络连接失败"];
    
    [view addSubview:image];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, view.frame.size.width-200, 20)];
    
    label1.text=@"网络连接失败";
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label2.text=@"请检查你的网络";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label2];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self TianJiaBtnClick];
    
}
//添加地址
-(void)TianJiaBtnClick
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        //获取数据
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSString *url = [NSString stringWithFormat:@"%@addReceiptAddress_mob.shtml",URL_Str];
        
        
        
        NSLog(@"=====%@",self.defaultstate);
        
        
        NSDictionary *dic = @{@"sigen":self.sigens,@"name":self.YTUserNameTF.text,@"phone":self.YTUSerPhoneTF.text,@"province":self.province,@"city":self.city,@"county":self.county,@"address":self.YTDeatilTF.text,@"defaultstate":self.defaultstate};
        
        NSLog(@">>>>>>>>>self.sigens>>>>>>>>%@",self.sigens);
        NSLog(@">>>>>>>>>self.NameTextField.text>>>>>>>>%@",self.YTUserNameTF.text);
        NSLog(@">>>>>>>>>self.PhoneTextField.text>>>>>>>>%@",self.YTUSerPhoneTF.text);
        NSLog(@">>>>>>>>>self.province>>>>>>>>%@",self.province);
        NSLog(@">>>>>>>>>self.city>>>>>>>>%@",self.city);
        NSLog(@">>>>>>>>>self.county>>>>>>>>%@",self.county);
        NSLog(@">>>>>>>>>self.self.DetailTextField.text>>>>>>>>%@",self.self.YTDeatilTF.text);
        NSLog(@">>>>>>>>>self.defaultstate>>>>>>>>%@",self.defaultstate);
        
        [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
            NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
            
            if (codeKey && content) {
                NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                //NSLog(@"xmlStr%@",xmlStr);
                
                
                NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
                
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"===xinzeng==%@",dic);
                view.hidden=YES;
                for (NSDictionary *dict in dic) {
                    
                    if ([dict[@"status"] isEqualToString:@"10000"]) {
                        
                        if ([self.YTString isEqualToString:@"200"] && [dict[@"defaultstate"] isEqualToString:@"1"]) {
                            
                            NSArray *vcArray = self.navigationController.viewControllers;
                            
                            
                            for(UIViewController *vc in vcArray)
                            {
                                if ([vc isKindOfClass:[QueDingDingDanViewController class]]){
                                    
                                    //创建一个消息对象
                                    NSNotification * notice =[NSNotification notificationWithName:@"YTNotice" object:nil userInfo:@{@"name":self.YTUserNameTF.text,@"phone":self.YTUSerPhoneTF.text,@"address":[NSString stringWithFormat:@"%@%@%@%@",self.province,self.city,self.county,self.YTDeatilTF.text],@"type":@"888",@"ID":dict[@"aid"],@"AddressReload":@"0"}];
                                    //发送消息
                                    [[NSNotificationCenter defaultCenter]postNotification:notice];
                                    
                                    [self.navigationController popToViewController:vc animated:YES];
                                    
                                }
                            }
                            
                        }else{
                            
                            //实现反向传值
                            if (_delegate && [_delegate respondsToSelector:@selector(reshData)]) {
                                [_delegate reshData];
                            }
                            
                            //                       实现反向传值
                            if (_delegate && [_delegate respondsToSelector:@selector(YTData)]) {
                                [_delegate YTData];
                            }
                            
                            if (_delegate && [_delegate respondsToSelector:@selector(setUserName:andPhone:andDetailAddress:andType:andID:andAddressReload:)]) {
                                
                                [_delegate setUserName:self.YTUserNameTF.text andPhone:self.YTUSerPhoneTF.text andDetailAddress:[NSString stringWithFormat:@"%@%@%@%@",self.province,self.city,self.county,self.YTDeatilTF.text] andType:@"888" andID:dict[@"aid"] andAddressReload:@"0"];
                            }
                            [self.navigationController popViewControllerAnimated:YES];

                            
                        }
                    }
                }
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
//            [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
            
            [self NoWebSeveice];
            NSLog(@"%@",error);
        }];
        
        
        [hud dismiss:YES];
    });

}
- (void)JSAddressCancleAction:(id)senter {
    self.pickerView.hidden = YES;
}

- (void)JSAddressPickerRerurnBlockWithProvince:(NSString *)province city:(NSString *)city town:(NSString *)town {
    self.pickerView.hidden = YES;
    
    self.YTAddressLabel.text=[NSString stringWithFormat:@"%@%@%@",province,city,town];
    self.province=province;
    self.city=city;
    self.county=town;
    
    NSLog(@"%@  %@  %@",province,city,town);
    
    
}

- (void)setPickerView:(JSAddressPickerView *)pickerView {
    if (!_pickerView) {
        
    }
    _pickerView = pickerView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.pickerView.hidden = YES;
    
    [self.view endEditing:YES];
}

@end
