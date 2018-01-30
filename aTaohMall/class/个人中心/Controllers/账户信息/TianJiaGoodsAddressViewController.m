//
//  TianJiaGoodsAddressViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/4.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "TianJiaGoodsAddressViewController.h"

#import "STPickerArea.h"
#import "UIView+RGSize.h"

#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))


#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UserMessageManager.h"

#import "WKProgressHUD.h"

#import "ZZLimitInputManager.h"
@interface TianJiaGoodsAddressViewController ()<STPickerAreaDelegate>

{
    UIView *view;
    UIAlertController *alertCon;
}
@property (weak, nonatomic) IBOutlet UIPickerView *MyPicker;

@property (strong, nonatomic) IBOutlet UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;


//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@end

@implementation TianJiaGoodsAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.defaultstate=@"0";
    NSLog(@"%@",self.defaultstate);
    
    
    //用户名
    [ZZLimitInputManager limitInputView:self.NameTextField maxLength:16];
    
    //手机
    [ZZLimitInputManager limitInputView:self.PhoneTextField maxLength:18];
}
//返回
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
//保存
- (IBAction)saveBtnClick:(UIButton *)sender {
    
    if (self.NameTextField.text.length == 0) {
        
        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入收货人姓名" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
        [self presentViewController: alertCon animated: YES completion: nil];
    }else{
        
        if (self.NameTextField.text.length < 2) {
            
            //用户名长度小于4
            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货人姓名不能为单个字" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
            [self presentViewController: alertCon animated: YES completion: nil];
        }else{
            
            //用户名是否为汉字
            NSString *CM_NUM = @"^[\u4e00-\u9fa5]{0,}$";
            
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            
            BOOL isMatch1 = [pred1 evaluateWithObject:self.NameTextField.text];
            
            if (!isMatch1) {
                
                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货人姓名只能为汉字" preferredStyle:UIAlertControllerStyleAlert];
                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                [self presentViewController: alertCon animated: YES completion: nil];
                
                
            }else{
                
                if (self.PhoneTextField.text.length == 0) {
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入手机号码" preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
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
                    BOOL isMatch1 = [pred1 evaluateWithObject:self.PhoneTextField.text];
                    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                    BOOL isMatch2 = [pred2 evaluateWithObject:self.PhoneTextField.text];
                    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                    
                    BOOL isMatch3 = [pred3 evaluateWithObject:self.PhoneTextField.text];
                    
                    if (!(isMatch1 || isMatch2 || isMatch3)) {
                        
                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"您输入手机号码有误" preferredStyle:UIAlertControllerStyleAlert];
                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                    }else{
                        
                        if (self.AddressLabel.text.length == 0) {
                            
                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择您所在的省市区" preferredStyle:UIAlertControllerStyleAlert];
                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                        }else{
                            
                            if (self.DetailTextField.text.length == 0) {
                                
                                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入详细的收货地址" preferredStyle:UIAlertControllerStyleAlert];
                                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                [self presentViewController: alertCon animated: YES completion: nil];
                                
                            }else{
                                
                                NSString *CM_NUM = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
                                
                                NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
                                
                                BOOL isMatch1 = [pred1 evaluateWithObject:self.NameTextField.text];
                                
                                if (!isMatch1) {
                                    
                                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"收货地址只能是数字/字母/汉字" preferredStyle:UIAlertControllerStyleAlert];
                                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                    [self presentViewController: alertCon animated: YES completion: nil];
                                }else{
                                    
                                    //添加
                                    [self TianJiaBtnClick];
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
//    if (self.PhoneTextField.text.length < 11) {
//        
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"手机号长度只能是11位" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
//    }else{
//        
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:self.PhoneTextField.text];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:self.PhoneTextField.text];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        
//        BOOL isMatch3 = [pred3 evaluateWithObject:self.PhoneTextField.text];
//        
//        if (isMatch1 || isMatch2 || isMatch3) {
////            return nil;
//            
//            
//            
//        }else{
//            
//            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alertView show];
//            
//        }
//    }
//    
    
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

//添加地址
-(void)TianJiaBtnClick
{
//    if (self.NameTextField.text.length==0 || self.PhoneTextField.text==0 || self.AddressLabel.text.length==0 || self.DetailTextField.text.length==0) {
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请完善资料!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
//    }else{
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
            
            
            NSDictionary *dic = @{@"sigen":self.sigens,@"name":self.NameTextField.text,@"phone":self.PhoneTextField.text,@"province":self.province,@"city":self.city,@"county":self.county,@"address":self.DetailTextField.text,@"defaultstate":self.defaultstate};
            
            NSLog(@">>>>>>>>>self.sigens>>>>>>>>%@",self.sigens);
            NSLog(@">>>>>>>>>self.NameTextField.text>>>>>>>>%@",self.NameTextField.text);
            NSLog(@">>>>>>>>>self.PhoneTextField.text>>>>>>>>%@",self.PhoneTextField.text);
            NSLog(@">>>>>>>>>self.province>>>>>>>>%@",self.province);
            NSLog(@">>>>>>>>>self.city>>>>>>>>%@",self.city);
            NSLog(@">>>>>>>>>self.county>>>>>>>>%@",self.county);
            NSLog(@">>>>>>>>>self.self.DetailTextField.text>>>>>>>>%@",self.self.DetailTextField.text);
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
                    
                    NSLog(@"%@",dic);
                    view.hidden=YES;
                    for (NSDictionary *dict in dic) {
                        
                        if ([dict[@"status"] isEqualToString:@"10000"]) {
                            
                            //实现反向传值
                            if (_delegate && [_delegate respondsToSelector:@selector(reshData)]) {
                                [_delegate reshData];
                            }
                        }
                    }
                    
                    
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
 //               [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
                NSLog(@"%@",error);
                
                [self NoWebSeveice];
                
            }];
            [self.navigationController popViewControllerAnimated:YES];
            
            [hud dismiss:YES];
        });
//    }
}

-(void)loadData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self TianJiaBtnClick];
    
//    [self getDatas];
}
//修改地址按钮
- (IBAction)changeBtnClick:(UIButton *)sender {
    
    [self.PhoneTextField endEditing:YES];
    
    [self.PhoneTextField resignFirstResponder];
    [self.NameTextField resignFirstResponder];
    [self.DetailTextField resignFirstResponder];
    
    STPickerArea *pickerArea = [[STPickerArea alloc]init];
    [pickerArea setDelegate:self];
    [pickerArea setContentMode:STPickerContentModeCenter];
    [pickerArea show];
}

//键盘回收
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    if ([province isEqualToString:@"北京"] || [province isEqualToString:@"上海"] || [province isEqualToString:@"天津"] || [province isEqualToString:@"重庆"]) {
        
        NSString *text = [NSString stringWithFormat:@"%@%@市%@区", province, province, city];
        
        self.province=[NSString stringWithFormat:@"%@%@市",province,province];
        self.city=[NSString stringWithFormat:@"%@区",city];
        self.AddressLabel.text = text;
    }else if ([province isEqualToString:@"香港"] || [province isEqualToString:@"澳门"]){
        
        NSString *text = [NSString stringWithFormat:@"%@特别行政区%@", province, city];
        
        self.province=[NSString stringWithFormat:@"%@特别行政区",province];
        self.city=[NSString stringWithFormat:@"%@",city];
        self.AddressLabel.text = text;
        
    }else if ([province isEqualToString:@"广西"]){
        
        NSString *text = [NSString stringWithFormat:@"%@壮族自治区%@市%@", province, city, area];
        
        self.province=[NSString stringWithFormat:@"%@壮族自治区",province];
        self.city=[NSString stringWithFormat:@"%@市",city];
        self.AddressLabel.text = text;
        
    }else if([province isEqualToString:@"内蒙古"]){
        
        NSString *text = [NSString stringWithFormat:@"%@自治区%@市%@", province, city, area];
        
        self.province=[NSString stringWithFormat:@"%@自治区",province];
        self.city=[NSString stringWithFormat:@"%@市",city];
        self.AddressLabel.text = text;
    }else if([province isEqualToString:@"西藏"]){
        NSString *text = [NSString stringWithFormat:@"%@自治区%@市%@", province, city, area];
        
        self.province=[NSString stringWithFormat:@"%@自治区",province];
        self.city=[NSString stringWithFormat:@"%@市",city];
        self.AddressLabel.text = text;
    }else if([province isEqualToString:@"宁夏"]){
        NSString *text = [NSString stringWithFormat:@"%@回族自治区%@市%@", province, city, area];
        
        self.province=[NSString stringWithFormat:@"%@回族自治区",province];
        self.city=[NSString stringWithFormat:@"%@市",city];
        self.AddressLabel.text = text;
    }else if([province isEqualToString:@"新疆"]){
        NSString *text = [NSString stringWithFormat:@"%@维吾尔自治区%@市%@", province, city, area];
        
        self.province=[NSString stringWithFormat:@"%@维吾尔自治区",province];
        self.city=[NSString stringWithFormat:@"%@市",city];
        self.AddressLabel.text = text;
    }else if ([province isEqualToString:@"国外"]){
        NSString *text = [NSString stringWithFormat:@"%@", city];
        
        self.province=[NSString stringWithFormat:@""];
        self.city=[NSString stringWithFormat:@"%@",city];
        self.AddressLabel.text = text;
        
    }else{
        
        NSString *text = [NSString stringWithFormat:@"%@省%@市%@", province, city, area];
        
        self.province=[NSString stringWithFormat:@"%@省",province];
        self.city=[NSString stringWithFormat:@"%@市",city];
        self.AddressLabel.text = text;
    }
    
    if ([area isEqualToString:@""]) {
        self.county=@"";
    }else{
        self.county=area;
    }
    
    
    NSLog(@"==%@==%@==%@",self.province,self,city,self.county);
}

- (IBAction)setingClick:(UISwitch *)sender {
    
    
    if (sender.isOn) {
        self.defaultstate=@"1";
        NSLog(@"%@",self.defaultstate);
    }else{
        self.defaultstate=@"0";
        NSLog(@"%@",self.defaultstate);
    }
}

@end
