//
//  YTChangeViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTChangeViewController.h"
#import "STPickerArea.h"
#import "UIView+RGSize.h"
#import "JSAddressPickerView.h"
#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UserMessageManager.h"


#import "GetGoodsAddressViewController.h"//收货地址界面

#import "WKProgressHUD.h"

#import "ZZLimitInputManager.h"

#import "YTAddressManngerViewController.h"
#import "JRToast.h"
@interface YTChangeViewController ()<JSAddressPickerDelegate>
{
    UIAlertController *alertCon;
    UIView *view;
}

@property (strong, nonatomic) UIView *maskView;

@property (nonatomic, strong) JSAddressPickerView *pickerView;


@end

@implementation YTChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.MoRen isEqualToString:@"1"]) {
        [self.YTSwitch setOn:YES animated:NO];
    }
    //获取数据
    [self getDatas];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [hud dismiss:YES];
    });
    
    //用户名
    [ZZLimitInputManager limitInputView:self.YTNameTF maxLength:20];
    
    //手机
    [ZZLimitInputManager limitInputView:self.YTPhoneTF maxLength:11];

    [ZZLimitInputManager limitInputView:self.YTDetailTF maxLength:30];
}


-(void)getDatas
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getReceiptAddressByID_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigens,@"aid":self.aid};
    
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
            
            NSLog(@"%@",dic);
            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                for (NSDictionary *dict2 in dict1[@"addresslist"]) {
                    
                    NSString *address=dict2[@"address"];
                    NSString *name=dict2[@"name"];
                    NSString *detailaddress=dict2[@"detailaddress"];
                    NSString *phone=dict2[@"phone"];
                    //                    NSLog(@"%@   %@",address,detailaddress);
                    
                    self.aaid=dict2[@"id"];
                    
                    self.city=dict2[@"city"];
                    self.province=dict2[@"province"];
                    self.county=dict2[@"county"];
                    
                    self.YTNameTF.text=name;
                    self.YTPhoneTF.text=phone;
                    self.YTAddressLabel.text=[NSString stringWithFormat:@"%@%@%@",dict2[@"province"],dict2[@"city"],dict2[@"county"]];
                    self.YTDetailTF.text=detailaddress;
                    self.defaultstate=dict2[@"defaultstate"];
//                    if ([detailaddress isEqualToString:@"1"]) {
//                        [self.YTSwitch isOn];
//                    }
                    
                    if ([self.defaultstate isEqualToString:@"1"]) {
                        [self.YTSwitch isOn];
                    }
                    
                }
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        NSLog(@"%@",error);
    }];
}


- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)ChangBtnClick:(UIButton *)sender {
    
    
    [self.YTNameTF resignFirstResponder];
    [self.YTPhoneTF resignFirstResponder];
    [self.YTDetailTF resignFirstResponder];
    
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
    
    [self getDatas];
    
}
- (IBAction)saveBtnClick:(UIButton *)sender {
    
    if (self.YTNameTF.text.length == 0) {
        
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先填写收货人" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
        
        [JRToast showWithText:@"请填写收货人" duration:3.0f];
        
    }else{
        
//        if (self.YTNameTF.text.length < 2) {
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
//            BOOL isMatch1 = [pred1 evaluateWithObject:self.YTNameTF.text];
//            
//            if (!isMatch1) {
//                
//                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货人姓名只能为汉字" preferredStyle:UIAlertControllerStyleAlert];
//                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                [self presentViewController: alertCon animated: YES completion: nil];
//                
//                
//            }else{
        
                if (self.YTPhoneTF.text.length == 0) {
                    
//                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入手机号码" preferredStyle:UIAlertControllerStyleAlert];
//                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                    [self presentViewController: alertCon animated: YES completion: nil];
                    
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
                    BOOL isMatch1 = [pred1 evaluateWithObject:self.YTPhoneTF.text];
                    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                    BOOL isMatch2 = [pred2 evaluateWithObject:self.YTPhoneTF.text];
                    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                    
                    BOOL isMatch3 = [pred3 evaluateWithObject:self.YTPhoneTF.text];
                    
                    if (!(isMatch1 || isMatch2 || isMatch3)) {
                        
//                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"您输入手机号码有误" preferredStyle:UIAlertControllerStyleAlert];
//                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                        [JRToast showWithText:@"手机号码只能为11位数字" duration:3.0f];
                        
                        
                    }else{
                        
                        if (self.YTAddressLabel.text.length==4) {
                            
//                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择您所在的省市区" preferredStyle:UIAlertControllerStyleAlert];
//                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                            [JRToast showWithText:@"请选择所在地区" duration:3.0f];
                            
                        }else{
                            
                            if (self.YTDetailTF.text.length == 0) {
                                

                                
                                [JRToast showWithText:@"请填写详细地址" duration:3.0f];
                                
                            }else if (self.YTDetailTF.text.length >30) {
                                self.YTDetailTF.text=[self.YTDetailTF.text substringToIndex:30];
                                [JRToast showWithText:@"详细地址最多可填写30字" duration:3.0f];

                            }else{

                                    //添加
                                    
                                    NSLog(@"=======");
                                    
                                    NSLog(@"1==%@",self.sigens);
                                    NSLog(@"2==%@",self.YTNameTF.text);
                                    NSLog(@"3==%@",self.YTPhoneTF.text);
                                    NSLog(@"4==%@",self.province);
                                    NSLog(@"5==%@",self.city);
                                    NSLog(@"6==%@",self.county);
                                    NSLog(@"7==%@",self.YTDetailTF.text);
                                    NSLog(@"8==%@",self.defaultstate);
                                    
                                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                                    
                                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                                    
                                    //        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

                                    NSString *url = [NSString stringWithFormat:@"%@updateReceiptAddress_mob.shtml",URL_Str];
                                    
                                    NSDictionary *dic = @{@"sigen":self.sigens,@"id":self.aaid,@"name":self.YTNameTF.text,@"phone":self.YTPhoneTF.text,@"province":self.province,@"city":self.city,@"county":self.county,@"address":self.YTDetailTF.text,@"defaultstate":self.defaultstate};
                                    
                                    NSLog(@"%@",self.sigens);
                                    NSLog(@"%@",self.YTNameTF.text);
                                    NSLog(@"%@",self.YTPhoneTF.text);
                                    NSLog(@"%@",self.province);
                                    NSLog(@"%@",self.city);
                                    NSLog(@"%@",self.county);
                                    NSLog(@"%@",self.YTDetailTF.text);
                                    NSLog(@"%@",self.defaultstate);
                                    
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
                                            
                                            NSLog(@"%@",dic);
                                            view.hidden=YES;
                                            for (NSDictionary *dict1 in dic) {
                                                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                                                    
                                                    
//                                                   YTAddressManngerViewController  *vc=[[YTAddressManngerViewController alloc] init];
//                                                    
////                                                    vc.back=@"20";
//                                                    
//                                                    vc.back=@"100";
//                                                    
//                                                    [self.navigationController pushViewController:vc animated:NO];
//                                                    
//                                                    self.navigationController.navigationBar.hidden=YES;
                                                    
                                                    
                                                    if (_delegate && [_delegate respondsToSelector:@selector(YTAddressReload)]) {
                                                        
                                                        [_delegate YTAddressReload];
                                                    };
                                                    
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                }else{
                                                    
                                                    [JRToast showWithText:dict1[@"message"] duration:3.0f];
                                                    
                                                }
                                            }
                                        }
                                        
                                        
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"%@",error);
                                        
                                        [self NoWebSeveice];
                                    }];
                                    
//                                }
                            }
                        }
                    }
                }
            }
        }
//    }
//}


//键盘回收
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
    
    [self.YTNameTF resignFirstResponder];
    [self.YTDetailTF resignFirstResponder];
    [self.YTPhoneTF resignFirstResponder];
    
    [self.view endEditing:YES];
}

@end
