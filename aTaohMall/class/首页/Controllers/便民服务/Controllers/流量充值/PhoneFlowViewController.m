//
//  PhoneFlowViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PhoneFlowViewController.h"

#import "ZZLimitInputManager.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "UIView+Extension.h"
#import "ABButton.h"

#import <ContactsUI/ContactsUI.h>

#import "PhoneAndFlowPayViewController.h"
#import "UITextField+Helper.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "JRToast.h"
#import "ATHLoginViewController.h"
#import "UserMessageManager.h"
#import "BianMinModel.h"
#define ABColor(R, G, B, Alpha) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(Alpha)]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define LINECOLOR [UIColor colorWithWhite:0.8 alpha:0.5]
#define ABButtonMargin 10.0

@interface PhoneFlowViewController ()<UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate,CNContactPickerDelegate,LoginMessageDelegate>
{
    
    UITextField *PhoneTF;
    UILabel *phoneLabel;
    UIView *view;
    NSMutableArray *_datas;
    NSMutableArray *_ArrM;
    UIView *ShuoMingView;
    UIView *ShuoMingView1;
    UIView *PhoneView;
    UIView *PayView;
    UIView *view10;
    UIScrollView *_scrollerView;
    
}

@end

@implementation PhoneFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //    self.navigationController.navigationBar.hidden=NO;
    
    self.view.backgroundColor = [UIColor whiteColor];//======//
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    _scrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    _scrollerView.showsVerticalScrollIndicator = NO;
    
    _scrollerView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_scrollerView];
    
    view10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    view10.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [_scrollerView addSubview:view10];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    _datas = [NSMutableArray new];
    
    _ArrM =[NSMutableArray new];
    
//    [self initNav];
    
    
    
    //创建电话视图
    [self initPhoneView];
    
    //创建充值视图
    [self initNumberView];
    
    
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
    
    label.text = @"流量充值";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)QurtBtnClick
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
    
    self.tabBarController.selectedIndex=0;
    
}

-(void)initPhoneView
{
    PhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 65-65+10, [UIScreen mainScreen].bounds.size.width, 80)];
    [_scrollerView addSubview:PhoneView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [PhoneView addSubview:line];
    
    PhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(25, 26, [UIScreen mainScreen].bounds.size.width-100, 28)];
    PhoneTF.placeholder = @"请输入手机号";
    PhoneTF.delegate=self;
    PhoneTF.keyboardType = UIKeyboardTypeNumberPad;
    PhoneTF.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PhoneTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:30];
    [ZZLimitInputManager limitInputView:PhoneTF maxLength:11];
    [PhoneView addSubview:PhoneTF];
    
    UIToolbar *bar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button1 setTitle:@"确定"forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:0];
    [button1 addTarget:self action:@selector(OKBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [bar1 addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
    [button2 setTitle:@"取消"forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    [bar1 addSubview:button2];
    [button2 addTarget:self action:@selector(CancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    PhoneTF.inputAccessoryView = bar1;
    
    
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, [UIScreen mainScreen].bounds.size.width-100, 14)];
    phoneLabel.text = @"请输入正确的手机号";
    phoneLabel.hidden=YES;
    phoneLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    phoneLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [PhoneView addSubview:phoneLabel];
    
    UIButton *User = [UIButton buttonWithType:UIButtonTypeCustom];
    User.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-50, (80-21)/2, 21, 21);
    [User setBackgroundImage:[UIImage imageNamed:@"用户中心"] forState:0];
    [User addTarget:self action:@selector(UserBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PhoneView addSubview:User];
    
    
    PayView = [[UIView alloc] initWithFrame:CGRectMake(15, 667-49-38-40-65+10, [UIScreen mainScreen].bounds.size.width-30, 38)];
    PayView.layer.cornerRadius = 3;
    PayView.layer.masksToBounds = YES;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [PayView.layer addSublayer:gradientLayer];
    
    [_scrollerView addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"支付" forState:0];
    Pay.layer.cornerRadius = 3;
    Pay.layer.masksToBounds = YES;
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
    
    
}

-(void)initNumberView
{
    
    NSArray *MianZhi = @[@"10M",@"20M",@"30M",@"50M",@"70M",@"100M",@"150M",@"200M",@"300M",@"500M",@"1G",@"2G"];
    NSArray *TagArr = @[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888",@"999",@"1010",@"1111",@"1212"];
    
    for (int i = 0; i < 12; i++) {
        
        UIButton *button = (UIButton *)[self.view viewWithTag:[TagArr[i] integerValue]];
        [button removeFromSuperview];
        
        [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
        [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        
    }
    
    
    for (int i = 0; i < 12; i++) {
        
        UIButton *abBtn = [[UIButton alloc] init];
        abBtn.tag = [TagArr[i] integerValue];
        [abBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
        [abBtn setTitle:MianZhi[i] forState:0];
        [abBtn setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
       // abBtn.enabled=NO;
      //  abBtn.layer.borderWidth=1;
        abBtn.layer.cornerRadius=2.5;
        abBtn.size = CGSizeMake((SCREEN_WIDTH-60)/3, 58);
        int col = i % 3;
        abBtn.x = col * (abBtn.width + ABButtonMargin)+20;
        int row = i / 3;
        abBtn.y = row * (abBtn.height + ABButtonMargin)+165-65+10;
        
        [_scrollerView addSubview:abBtn];
        if ([PhoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
            [abBtn addTarget:self action:@selector(plzInputPhoneNum) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    [ShuoMingView removeFromSuperview];
    
    ShuoMingView =[[UIView alloc] initWithFrame:CGRectMake(0, 460-65+10, [UIScreen mainScreen].bounds.size.width, 20)];
    [_scrollerView addSubview:ShuoMingView];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, (20-12)/2, 12, 12)];
    imgView1.image = [UIImage imageNamed:@"选中425"];
    [ShuoMingView addSubview:imgView1];
    
    UILabel *ShuoMingLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, [UIScreen mainScreen].bounds.size.width-40, 20)];
    ShuoMingLabel.text = @"全国通用，即时生效，当月有效";
    ShuoMingLabel.textColor=[UIColor blackColor];
    ShuoMingLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    
    NSString *string4 = @"全国";
    
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:ShuoMingLabel.text];
    //
    NSRange range4 = [ShuoMingLabel.text rangeOfString:string4];
    
    [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range4];
    ShuoMingLabel.attributedText=mAttStri1;
    [ShuoMingView addSubview:ShuoMingLabel];
    
}

-(void)plzInputPhoneNum
{
    [TrainToast showWithText:@"请先输入手机号" duration:2.0];
}
-(void)chargePhone:(ABButton*)sender{
    
    NSArray *TagArr = @[@"10",@"20",@"30",@"50",@"70",@"100",@"150",@"200",@"300",@"500",@"1024",@"2048"];
    
    for (int i = 0; i < 12; i++) {
        
        UIButton *button = (UIButton *)[self.view viewWithTag:[TagArr[i] integerValue]];
        
        [button setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
        [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        button.layer.borderColor=[RGB(51, 51, 51) CGColor];
        for (int j =0; j < _datas.count; j++) {
            
            BianMinModel *model = _datas[j];
            
            
            if (sender.tag ==[TagArr[i] integerValue]) {
                
                UIButton *btn= [self.view viewWithTag:sender.tag];
                [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
                btn.layer.borderColor=[RGB(255, 93, 94) CGColor];
                if ([model.v isEqualToString:TagArr[i]]) {
                    
                    self.flow_id = model.Id;
                    self.flow_size = model.v;
                    self.Price = model.inprice;
                    
                }
            }
        }
    }
}

-(void)chargePhone1:(ABButton*)sender{
    
    
    NSLog(@"=======%ld",sender.tag);
    
    for (int i = 0; i < _datas.count; i++) {
        
        BianMinModel *model = _datas[i];
        
        UIButton *button = (UIButton *)[self.view viewWithTag:[_ArrM[i] integerValue]];
        
        [button setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
        [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        button.layer.borderColor=[RGB(51, 51, 51) CGColor];
        
        if (sender.tag == [_ArrM[i] integerValue]) {
            
            NSLog(@"====%@",_ArrM[i]);
            
            UIButton *btn= [self.view viewWithTag:sender.tag];
            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
            [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
            btn.layer.borderColor=[RGB(255, 93, 94) CGColor];
            if ([model.v isEqualToString:_ArrM[i]]) {
                
                self.flow_id = model.Id;
                self.flow_size = model.v;
                self.Price = model.inprice;
                
            }
            
        }
    }
}


-(void)CancleBtnclick
{
    PhoneTF.text=@"";
    
    [self.view endEditing:YES];
    

}

-(void)OKBtnclick
{
    if ([UITextField numberToNormalNumTextField:PhoneTF].length==0) {
        phoneLabel.hidden=YES;
    }
    else if (![[UITextField numberToNormalNumTextField:PhoneTF] phoneNumberIsCorrect]) {
        phoneLabel.hidden=NO;
        phoneLabel.text=@"请输入正确的手机号";
    }
    [self.view endEditing:YES];
}


//获取联系人
-(void)UserBtnClick
{
    CNContactPickerViewController * vc = [[CNContactPickerViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate



-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    NSLog(@"联系人的资料:===1111%@",contact);
    
    // 1.获取联系人的姓名
    NSString *lastname = contact.familyName;
    NSString *firstname = contact.givenName;
    NSLog(@"%@ %@", lastname, firstname);
    
    // 2.获取联系人的电话号码
    NSArray *phoneNums = contact.phoneNumbers;
    for (CNLabeledValue *labeledValue in phoneNums) {
        // 2.1.获取电话号码的KEY
        NSString *phoneLabel = labeledValue.label;
        
        // 2.2.获取电话号码
        CNPhoneNumber *phoneNumer = labeledValue.value;
        NSString *phoneValue = phoneNumer.stringValue;
        
        NSLog(@"==%@==%@", phoneLabel, phoneValue);
        
        
        if ([phoneNumer.stringValue rangeOfString:@"+86"].location !=NSNotFound) {
            
            NSString *cca2 = [phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"+86"withString:@""];//删除
            
            if([cca2 rangeOfString:@"-"].location !=NSNotFound)//_roaldSearchText
            {
                NSLog(@"yes");
                
                PhoneTF.text =[UITextField numberToNormalNumString:cca2];
                
            }
            else
            {
                
                NSMutableString* str1=[[NSMutableString alloc] initWithString:cca2];//存在堆区，可变字符串
                NSLog(@"str1:%@",str1);
                if (str1.length > 3) {
                    
                    [str1 insertString:@"-"atIndex:3];//把一个字符串插入另一个字符串中的某一个位置
                    
                    if (str1.length >8){
                        
                        [str1 insertString:@"-"atIndex:8];
                        
                        
                        PhoneTF.text =[UITextField numberToNormalNumString:str1];
                        
                        
                    }else{
                        
                        PhoneTF.text = [UITextField numberToNormalNumString:str1];
                    }
                    
                }else{
                    
                    
                    PhoneTF.text = str1;
                    
                }
                
                
                NSLog(@"str1:%@",str1);
                
                
            }
            
            
            
            
        }else{
            
            if([phoneNumer.stringValue rangeOfString:@"-"].location !=NSNotFound)//_roaldSearchText
            {
                NSLog(@"yes");
                
                PhoneTF.text =[UITextField numberToNormalNumString:phoneNumer.stringValue];
                
            }
            else
            {
                
                NSMutableString* str1=[[NSMutableString alloc] initWithString:phoneNumer.stringValue];//存在堆区，可变字符串
                NSLog(@"str1:%@",str1);
                if (str1.length > 3) {
                    
                    [str1 insertString:@"-"atIndex:3];//把一个字符串插入另一个字符串中的某一个位置
                    
                    if (str1.length >8){
                        
                        [str1 insertString:@"-"atIndex:8];
                        
                        
                        PhoneTF.text =[UITextField numberToNormalNumString:str1];
                        
                        
                    }else{
                        
                        PhoneTF.text = [UITextField numberToNormalNumString:str1];
                    }
                    
                }else{
                    
                    
                    PhoneTF.text = str1;
                    
                }
                
                
                NSLog(@"str1:%@",str1);
                
                
            }
            
            
        }
        
        
//        NSArray *TagArr = @[@"10",@"20",@"30",@"50",@"70",@"100",@"150",@"200",@"300",@"500",@"1024",@"2048"];
        
//        for (int i = 0; i < _datas.count; i++) {
//            
//            UIButton *button = (UIButton *)[self.view viewWithTag:[_ArrM[i] integerValue]];
//            button.enabled=YES;
//            
//            [button setTitleColor:[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0] forState:0];
//            [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
//            
//            
//        }
        
        [self getDatas1];
        
    }
    
}


-(void)PayBtnCLick
{
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    NSLog(@"=====self.sigen===%@",self.sigen);
    
    
    NSString *bankNo=[UITextField numberToNormalNumTextField:PhoneTF];
    if ([bankNo isEqualToString:@""]) {
        [TrainToast showWithText:@"请输入正确的手机号" duration:2.0];
        return;
    }
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
    BOOL isMatch1 = [pred1 evaluateWithObject:bankNo];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:bankNo];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    
    BOOL isMatch3 = [pred3 evaluateWithObject:bankNo];
    
    if (!(isMatch1 || isMatch2 || isMatch3)) {
        
        phoneLabel.hidden=NO;
        
        phoneLabel.text = @"请输入正确的手机号";
        
    }else{
        
        
        NSLog(@"=====话费金额==%@",self.Price);
        
        if (self.sigen.length==0) {
            
            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            vc.delegate=self;
            vc.backString=@"426";
            vc.BianMinType = @"0";
            vc.BianMinPhone =bankNo;
            vc.BianMinPrice = self.Price;
            vc.TitleString=@"100";
            vc.BianMinFlow_size = self.flow_size;
            vc.BianMinFlow_id = self.flow_id;
            
            [self.navigationController pushViewController:vc animated:NO];
            
            self.navigationController.navigationBar.hidden=YES;
            
        }else{
            
            [self submitMoneyPay];
            
        }
        
    }
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
//    if ((unsigned long)range.location == 0) {
//        
//        phoneLabel.hidden=NO;
//        phoneLabel.text = @"";
//        
//        for (UIView *view1 in _scrollerView.subviews) {
//            if ((view1==PayView)||(view1==PhoneView)) {
//                
//            }else
//            {
//                [view1 removeFromSuperview];
//            }
//        }
//        
//
//        
//        [self initNumberView];
//
//    }
    

    
    return [self phoneNumberFormatTextField:PhoneTF shouldChangeCharactersInRange:range replacementString:string];
    
}
-(BOOL)phoneNumberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField text];
    // 只能输入数字
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound)
    {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 如果是电话号码格式化，需要添加这三行代码
    NSMutableString *temString = [NSMutableString stringWithString:text];
    [temString insertString:@" " atIndex:0];
    text = temString;
    
    
    NSString *newString = @"";
    
    while (text.length > 0)
    {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4)
        {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    // 号码14 银行卡 24
    if (newString.length >= 14)
    {
        return NO;
    }
    
    [textField setText:newString];
    
    [self textFieldDidChange];
    return NO;
}
-(void)textFieldDidChange{
    //转换格式、去掉手机号码中的空格
    NSString *phoneNum=[UITextField numberToNormalNumTextField:PhoneTF];
    //
    if ([phoneNum phoneNumberIsCorrect]) {
       
        [self.view endEditing:YES];
        [self getDatas1];
    }else
    {
        
        phoneLabel.hidden=NO;
        phoneLabel.text = @"";
        
        for (UIView *view1 in _scrollerView.subviews) {
            if ((view1==PayView)||(view1==PhoneView)||(view1==view10)) {
                
            }else
            {
                [view1 removeFromSuperview];
            }
        }
        
        
        
        [self initNumberView];
        
        if (phoneNum.length==11)
        {
            phoneLabel.hidden=NO;
            phoneLabel.text=@"请输入正确的手机号";
        }
        
    }
    NSLog(@"phone=%@",phoneNum);
    
}

-(void)getDatas1
{
    
    for (UIView *view1 in _scrollerView.subviews) {
        if ((view1==PayView)||(view1==PhoneView)||(view1==view10)) {
            
        }else
        {
            [view1 removeFromSuperview];
        }
    }
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    NSString *bankNo=[UITextField numberToNormalNumTextField:PhoneTF];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getFaceValue_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    
    NSDictionary *dic = @{@"type":@"1",@"phone":bankNo};
    
NSLog(@"dic=%@",dic);
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr======%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"dianhuahaoma===%@",dic);
            
            
            
            view.hidden=YES;
            
            
            
            //            NSLog(@"=======%@",dic[@"result"]);
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                //先清空数据源
                [_datas removeAllObjects];
                
                [_ArrM removeAllObjects];
                
                phoneLabel.hidden=NO;
                phoneLabel.text = [NSString stringWithFormat:@"(%@)",dic[@"game_area"]];
                
                NSArray *array =dic[@"result"];
                
                for (NSDictionary *dict1 in array) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.Id = dict1[@"id"];
                    model.p = dict1[@"p"];
                    model.v = dict1[@"v"];
                    model.inprice = dict1[@"inprice"];
                    
                    [_datas addObject:model];
                    
                    [_ArrM addObject:[NSString stringWithFormat:@"%@",dict1[@"v"]]];
                    
                    
                }
                
                UIButton *abBtn;
                
                    for (int j =0; j < _datas.count; j++) {
                        
                        BianMinModel *model = _datas[j];
                        
                     
                        abBtn = [[UIButton alloc] init];
                        abBtn.tag = [_ArrM[j] integerValue];
                        abBtn.layer.borderWidth=1;
                        abBtn.layer.borderColor=[RGB(51, 51, 51) CGColor];
                        abBtn.layer.cornerRadius=4;
                        [abBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
                        if ([model.p isEqualToString:@"2048M"]) {
                            
                            [abBtn setTitle:@"2G" forState:0];
                            
                        }else{
                            
                            [abBtn setTitle:model.p forState:0];
                        }
                        
                        [abBtn setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
                        abBtn.enabled=YES;
                        
                        if (j==0) {
                        
                            self.flow_id = model.Id;
                            self.flow_size = model.v;
                            self.Price = model.inprice;
                            abBtn.layer.borderColor=[RGB(255, 93, 94) CGColor];
                            [abBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                            [abBtn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
                            
                        }
                        abBtn.size = CGSizeMake((SCREEN_WIDTH-60)/3, 58);
                        int col = j % 3;
                        abBtn.x = col * (abBtn.width + ABButtonMargin)+20;
                        int row = j / 3;
                        abBtn.y = row * (abBtn.height + ABButtonMargin)+165-65+10;
                            
                        [_scrollerView addSubview:abBtn];
                        [abBtn addTarget:self action:@selector(chargePhone1:) forControlEvents:UIControlEventTouchUpInside];
                        
                }
                
                [ShuoMingView1 removeFromSuperview];
                
                ShuoMingView1 =[[UIView alloc] initWithFrame:CGRectMake(0, abBtn.y+80+10, [UIScreen mainScreen].bounds.size.width, 20)];
                [_scrollerView addSubview:ShuoMingView1];
                
                UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, (20-12)/2, 12, 12)];
                imgView1.image = [UIImage imageNamed:@"选中425"];
                [ShuoMingView1 addSubview:imgView1];
                
                UILabel *ShuoMingLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, [UIScreen mainScreen].bounds.size.width-40, 20)];
                ShuoMingLabel.text = @"全国通用，即时生效，当月有效";
                ShuoMingLabel.textColor=[UIColor blackColor];
                ShuoMingLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
                
                NSString *string4 = @"全国";
                
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:ShuoMingLabel.text];
                //
                NSRange range4 = [ShuoMingLabel.text rangeOfString:string4];
                
                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range4];
                ShuoMingLabel.attributedText=mAttStri1;
                [ShuoMingView1 addSubview:ShuoMingLabel];
                
                
                
            }else{
                
                phoneLabel.hidden=NO;
                phoneLabel.text = @"请输入正确的手机号";
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
                [ShuoMingView1 removeFromSuperview];
                
                
                for (int j =0; j < _datas.count; j++) {
                    
                    BianMinModel *model = _datas[j];
                    
                    UIButton *button = (UIButton *)[self.view viewWithTag:[_ArrM[j] integerValue]];
                    
                    [button removeFromSuperview];
                    
                    
                }
                
                [ShuoMingView removeFromSuperview];
                
                [self initNumberView];
                
            }
            
            
            [hud dismiss:YES];
            
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        [hud dismiss:YES];
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)getDatas
{
    //先清空数据源
    [_datas removeAllObjects];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    NSString *bankNo=[UITextField numberToNormalNumTextField:PhoneTF];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getFaceValue_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    
    NSDictionary *dic = @{@"type":@"1",@"phone":bankNo};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
                        NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"分类查看更多书局=%@",dic);
            
            
            
            view.hidden=YES;
            
            
            
//            NSLog(@"=======%@",dic[@"result"]);
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                phoneLabel.hidden=NO;
                phoneLabel.text = [NSString stringWithFormat:@"(%@)",dic[@"game_area"]];
                
                NSArray *array =dic[@"result"];
                
                for (NSDictionary *dict1 in array) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.Id = dict1[@"id"];
                    model.p = dict1[@"p"];
                    model.v = dict1[@"v"];
                    model.inprice = dict1[@"inprice"];
                    
                    [_datas addObject:model];
                    
                    
                }
                
                
                NSArray *TagArr = @[@"10",@"20",@"30",@"50",@"70",@"100",@"150",@"200",@"300",@"500",@"1024",@"2048"];
                
                
                for (int i = 0; i < 12; i++) {
                    
                    UIButton *button = (UIButton *)[self.view viewWithTag:[TagArr[i] integerValue]];
                    button.enabled=NO;
                    
                    [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204255.0 blue:204/255.0 alpha:1.0] forState:0];
                    [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
                    
                    for (int j =0; j < _datas.count; j++) {
                        
                        BianMinModel *model = _datas[j];
                        
                        
                        if ([model.v isEqualToString:TagArr[i]]) {
                            
                            UIButton *btn= [self.view viewWithTag:[TagArr[i] integerValue]];
                            btn.enabled=YES;
                            
                            if (j==0) {
                                
                                self.flow_id = model.Id;
                                self.flow_size = model.v;
                                self.Price = model.inprice;
                                
                                [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                               [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
                            }
                           
                        }
                        
                    }
                    
                    
                }
                
                
            }else{
                
                phoneLabel.hidden=NO;
                phoneLabel.text = @"请输入正确的手机号";
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
                
                
            }
            
            
            [hud dismiss:YES];
            
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        [hud dismiss:YES];
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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

-(void)loadData{
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
   WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas1];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{


    
}

-(void)submitMoneyPay
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    NSString *bankNo=[UITextField numberToNormalNumTextField:PhoneTF];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@submitMoneyPay_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSLog(@"===self.sigen==%@",self.sigen);
    NSLog(@"===bankNo==%@",bankNo);
    NSLog(@"===self.Price==%@",self.Price);
    NSLog(@"===self.flow_size==%@",self.flow_size);
    NSLog(@"===self.flow_id==%@",self.flow_id);
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"type":@"1",@"phone":bankNo,@"price":self.Price,@"flow_size":self.flow_size,@"flow_id":self.flow_id,@"clientId":@"3"};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
                        NSLog(@"分类查看更多书局=%@",dic);
            
            view.hidden=YES;
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                PhoneAndFlowPayViewController *vc=[[PhoneAndFlowPayViewController alloc] init];
                
                vc.Sigen=self.sigen;
                vc.integral = [NSString stringWithFormat:@"%@",dic[@"integral"]];
                vc.orderno = [NSString stringWithFormat:@"%@",dic[@"orderno"]];
                vc.pay_integral = [NSString stringWithFormat:@"%@",dic[@"pay_integral"]];
                vc.pay_money = [NSString stringWithFormat:@"%@",dic[@"pay_money"]];
                vc.price = [NSString stringWithFormat:@"%@",dic[@"price"]];
                vc.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
                vc.sta = [NSString stringWithFormat:@"%@",dic[@"sta"]];
                vc.Phone =bankNo;
                vc.title = @"流量充值";
                vc.proportion = [NSString stringWithFormat:@"%@",dic[@"proportion"]];
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController pushViewController:vc animated:NO];
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
            
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hud dismiss:YES];
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

@end
