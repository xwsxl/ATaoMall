//
//  QueDingDingDanViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "QueDingDingDanViewController.h"

#import "UsingJiFenCell.h"//使用积分

#import "DingDanDetailCell.h"//订单详情

#import "QueRenDingDanHeader.h"//确认订单头部地址

#import "NewAddAddressViewController.h"//新增地址

#import "QueDingPayViewController.h"//确定支付

#import "TianJiaGoodsAddressViewController.h"

#import "QuerenDingDanAddressCell.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "QueRenDingDanModel.h"
#import "DingDanAddressModel.h"


#import "PersonalAllDanVC.h"
//弹出视图
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"
#import "CustomActionSheet.h"

#import "GetGoodsAddressViewController.h"

#import "WKProgressHUD.h"

#import "UIImageView+WebCache.h"

#import "XSInfoView.h"
#import "JRToast.h"

#import "UserMessageManager.h"

//蒙版效果
#import "SVProgressHUD.h"

#import "DuiHuanFailureViewController.h"//兑换失败

#import "DuiHuanSuccessViewController.h"

#import "YTAddressViewController.h"

#import "YTAddressManngerViewController.h"

#import "PersonalShoppingDanDetailVC.h"

//获得iOS版本
#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue]


#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "AppDelegate.h"

@interface QueDingDingDanViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,CustomActionSheetDelagate,GetGoodsAdddressDelegate,UITextFieldDelegate,UITextViewDelegate,YTDelwgate>
{
    UITableView *_tableView;
    
    UILabel *label2;//实付金额
    
    NSString *str;
    
    float jifen;
    
    DingDanDetailCell *cell;
    
    UsingJiFenCell *cell1;
    
    NSMutableArray *_addressArrM;
    NSMutableArray *_datas;
    
    NSInteger count;
    
    NSMutableArray *_countArrM;
    
    NSString *_ShiFuMoney;
    
    BOOL isButtonOn;
    
    CGRect textField_rect;
    
    float UserJiFen;//用户积分
    float MaxUseJiFen;//最多使用积分
    
    float FinishJiFen;//用户最终可使用积分
    
    //判断开关初始状态
    NSString *BegainStr;
    
    UIButton *button;
    
    QuerenDingDanAddressCell *cell5;
    UIView *view;
    
    NSArray *YTarray;
    
}
@property (nonatomic,strong)NSString *HealthyScore;
@end

@implementation QueDingDingDanViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
//    cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    
    
    NSLog(@"===6====++==%@==%ld",[userDefaultes stringForKey:@"userWord"],[userDefaultes stringForKey:@"userWord"].length);
    
    if ([userDefaultes stringForKey:@"userWord"].length>0) {
        
        
        cell.WordTextField.text =[userDefaultes stringForKey:@"userWord"];
        
    }else{
        
        cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.ShiYongJiFen=@"0";
    self.view.frame=[UIScreen mainScreen].bounds;
    
//    cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    
    
    NSLog(@"=======++==%@==%ld",[userDefaultes stringForKey:@"userWord"],[userDefaultes stringForKey:@"userWord"].length);
    
    if ([userDefaultes stringForKey:@"userWord"].length>0) {
        
        
        cell.WordTextField.text =[userDefaultes stringForKey:@"userWord"];
    }else{
        
        cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
        
    }
    
    NSLog(@"qqqqqqqq=%@===%@,%@,%@,%@",self.yunfei,self.exchange,self.detailId,self.attributenum,self.MoneyType);
    
    self.UserID=@"0";
    self.UserPhone=@"0";
    self.type = self.MoneyType;
    if (self.detailId.length !=0) {
        
        _num = [self.attributenum integerValue];
        
    }else{
        
        self.detailId=@"";
        _num=1;
        
    }
    BegainStr=@"1";
    
    _addressArrM=[NSMutableArray new];
    
    _datas=[NSMutableArray new];
    
    _countArrM=[NSMutableArray new];
    
    //创建
    [self initTableView];
    
    
    if ([self.UserType isEqualToString:@"888"]) {
        
        
        
    }else{
        //获取数据
        [self getDatas];
        
//        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//            [hud dismiss:YES];
//        });
    }
    
    
    NSLog(@"+++++商品类型===%@",self.Goods_Type_Switch);
    
    //纯积分商品开关不能关
    
    if ([self.Goods_Type_Switch isEqualToString:@"1"]) {
        
        cell1.UseJiFenSwitch.enabled=NO;
        
        cell1.UseJiFenTF.enabled=NO;
        
        cell1.UseJiFenSwitch.userInteractionEnabled = NO;
    }else{
        
        cell1.UseJiFenSwitch.enabled=YES;
        
        cell1.UseJiFenTF.enabled=YES;
        
    }
    
    
  //  [self getUserMessage];
    
    
    cell.NumberLabel.text=@"1";
    
    //******************************************************************
    
    cell.YTNumberTF.text=@"1";
    
    //******************************************************************
    
    
//    self.AddressReloadString=@"0";
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘的掉下
 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultStatus:) name:@"resultStatus" object:nil];
    
    //注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(address:) name:@"address" object:nil];
    
    
    //获取通知中心
    NSNotificationCenter * center =[NSNotificationCenter defaultCenter];
    
    //添加观察者 Observer表示观察者  reciveNotice:表示接收到的消息  name表示再通知中心注册的通知名  object表示可以相应的对象 为nil的话表示所有对象都可以相应
    
    [center addObserver:self selector:@selector(reciveNotice:) name:@"YTNotice" object:nil];
    
    
}

- (void)reciveNotice:(NSNotification *)notification{
    
    NSLog(@"收到消息啦!!!");
    
//    [NSNotification notificationWithName:@"YTNotice" object:nil userInfo:@{@"name":self.YTUserNameTF.text,@"phone":self.YTUSerPhoneTF.text,@"address":[NSString stringWithFormat:@"%@%@%@%@",self.province,self.city,self.county,self.YTDeatilTF.text],@"type":@"888",@"ID":dict[@"aid"],@"AddressReload":@"0"}];
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    
    NSLog(@"====2===++==%@==%ld",[userDefaultes stringForKey:@"userWord"],[userDefaultes stringForKey:@"userWord"].length);
    
    if ([userDefaultes stringForKey:@"userWord"].length>0) {
        
        
        cell.WordTextField.text =[userDefaultes stringForKey:@"userWord"];
    }else{
        
        cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
        
    }
    
    
//    cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
    
    self.UserName=[notification.userInfo objectForKey:@"name"];
    self.UserAddress=[notification.userInfo objectForKey:@"address"];
    self.UserPhone=[notification.userInfo objectForKey:@"phone"];
    
    self.UserType=[notification.userInfo objectForKey:@"type"];
    self.UserID=[notification.userInfo objectForKey:@"ID"];
    
    self.AddressReloadString=[notification.userInfo objectForKey:@"AddressReload"];
    
    NSLog(@"======>>%@",self.UserAddress);
    NSLog(@"======>>%@",self.UserName);
    NSLog(@"======>>%@",self.UserPhone);
    NSLog(@"======>>%@",self.UserType);
    NSLog(@"======>>%@",self.UserID);
    
    //    if (_addressArrM.count==0) {
    
    [_addressArrM removeAllObjects];
    
    [_datas removeAllObjects];
    
    [self getDatas];
    //    }
    [_tableView reloadData];
    
    
    
}


-(void)setUserName:(NSString *)name andPhone:(NSString *)phone andDetailAddress:(NSString *)address andType:(NSString *)type andID:(NSString *)addressID andAddressReload:(NSString *)reload
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    
    NSLog(@"====3===++==%@==%ld",[userDefaultes stringForKey:@"userWord"],[userDefaultes stringForKey:@"userWord"].length);
    
    if ([userDefaultes stringForKey:@"userWord"].length>0) {
        
        
        cell.WordTextField.text =[userDefaultes stringForKey:@"userWord"];
    }else{
        
        cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
        
    }
//    cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
    
    self.UserName=name;
    self.UserAddress=address;
    self.UserPhone=phone;
    
    self.UserType=type;
    self.UserID=addressID;
    
    self.AddressReloadString=reload;
    
    NSLog(@"======>>%@",self.UserAddress);
    NSLog(@"======>>%@",self.UserName);
    NSLog(@"======>>%@",self.UserPhone);
    NSLog(@"======>>%@",self.UserType);
    NSLog(@"======>>%@",self.UserID);
    
    //    if (_addressArrM.count==0) {
    
    [_addressArrM removeAllObjects];
    
    [_datas removeAllObjects];
    
    [self getDatas];
    //    }
    [_tableView reloadData];
    
}

- (void)tongzhi:(NSNotification *)text{
    
    
    //    [_datas removeAllObjects];
    
    
 //   [self getUserMessage];
    
}

-(void)address:(NSNotification *)text{
    
    
    self.UserType=@"666";
    
    [_addressArrM removeAllObjects];
    
    [_datas removeAllObjects];
    [_countArrM removeAllObjects];
    
    [self getDatas];
    [_tableView reloadData];
    
}
//获取收货地址反向值
-(void)setUserNameWithString:(NSString *)name andPhoneWithString:(NSString *)phone andDetailAddressWithString:(NSString *)address andType:(NSString *)type andIDWithString:(NSString *)addressID andAddressReloadString:(NSString *)reload
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    
    NSLog(@"===4====++==%@==%ld",[userDefaultes stringForKey:@"userWord"],[userDefaultes stringForKey:@"userWord"].length);
    
    if ([userDefaultes stringForKey:@"userWord"].length>0) {
        
        
        cell.WordTextField.text =[userDefaultes stringForKey:@"userWord"];
    }else{
        
        cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
        
    }
//    cell.WordTextField.text =@"选填，有什么小要求在这提醒卖家";
    
    self.UserName=name;
    self.UserAddress=address;
    self.UserPhone=phone;
    
    self.UserType=type;
    self.UserID=addressID;
    
    self.AddressReloadString=reload;
    
    NSLog(@"======>>%@",self.UserAddress);
    NSLog(@"======>>%@",self.UserName);
    NSLog(@"======>>%@",self.UserPhone);
    NSLog(@"======>>%@",self.UserType);
    NSLog(@"======>>%@",self.UserID);
    
//    if (_addressArrM.count==0) {
    
    [_addressArrM removeAllObjects];
    
        [_datas removeAllObjects];
        
        [self getDatas];
   // [_tableView reloadData];
    
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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
    
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label3.text=@"请检查你的网络";
    
    label3.textAlignment=NSTextAlignmentCenter;
    
    label3.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label3.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label3];
    
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button1 setTitle:@"重新加载" forState:0];
    button1.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button1 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button1];
    
    [button1 addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadData
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    
    [self getDatas];
  //  [self getUserMessage];
    
}

-(void)AddressReload:(NSInteger)count
{
    
    NSLog(@"=========返回地址条数===%ld",count);
    
[_tableView reloadData];
    
}
-(void)AddressReload
{
    
    self.UserPhone=@"";
    self.UserName=@"";
    self.UserAddress=@"";
    self.UserType=@"";
    self.UserID=@"";
    self.AddressReloadString=@"1";
    
    
    cell5.PhoneLabel.hidden=YES;
    
    cell5.UserAddressAndPhoneLabel.hidden=YES;
    
    cell5.UserAddressLabel.hidden=YES;
    
    cell5.ShuoMingLabel.hidden=NO;
    
    NSLog(@"======冲冲偶们1如==%@=“0",self.AddressReloadString);
    [_addressArrM removeAllObjects];
    
    [_datas removeAllObjects];
    [_countArrM removeAllObjects];
    
    [self getDatas];
    
    self.phone=@"";
//    [_addressArrM removeAllObjects];
    
    [_tableView reloadData];
}
//获取确认订单数据
-(void)getDatas
{
     WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    NSNull *null=[[NSNull alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getConfirmOrderInfo_mob.shtml",URL_Str];
    
    NSLog(@"=====self.sigen===%@======",self.sigen);
    NSLog(@"=====self.midddd===%@======",self.midddd);
    NSLog(@"=====self.gid===%@======",self.gid);
    NSLog(@"=====self.logo===%@======",self.logo);
    NSLog(@"=====self.storename===%@======",self.storename);
    NSLog(@"=====self.detailId===%@======",self.detailId);
    
    
        NSDictionary *dic = @{@"sigen":self.sigen,@"mid":self.midddd,@"gid":self.gid,@"logo":@"",@"storename":self.storename,@"detailId":self.detailId};
 //logo可能为空报错
   
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr==%@",xmlStr);
            //关闭菊花；
            [hud dismiss:YES];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=======商品信息%@",dic);
            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                
                //支付需要参数
                self.bankList=dict1[@"bankList"];
                
                self.integer=dict1[@"integral"];
                self.HealthyScore=[NSString stringWithFormat:@"%@",dict1[@"healthy_integral"]];
                if ([self.HealthyScore isEqualToString:@""]||[self.HealthyScore containsString:@"null"]) {
                    self.HealthyScore=@"0.00";
                }
                self.logo=self.logo;//dict1[@"logo"];
                self.path=dict1[@"path"];
                self.storename=dict1[@"storename"];
                
                self.YTStorename=dict1[@"storename"];
                
                self.YTLogo=dict1[@"logo"];
                
                self.stuts=dict1[@"status"];
                
                YTarray=dict1[@"addresslist"];
                
                
                NSLog(@"=====dict1@====%ld",YTarray.count);
                
                if (YTarray.count==0) {
                    
                    DingDanAddressModel *model=[[DingDanAddressModel alloc] init];
                    
                    model.address=@"";
                    
                    //收货地址id
                    
                    //aid用于支付
                    
                    self.aid=@"";
                    
                    model.id=@"";
                    model.name=@"";
                    model.phone=@"";
                    model.defaultstate=@"";
                    self.phone=@"";
                    
                    [_addressArrM addObject:model];
                    
                }else{
                    
                    for (NSDictionary *dict2 in dict1[@"addresslist"]) {
                        DingDanAddressModel *model=[[DingDanAddressModel alloc] init];
                        
                        model.address=dict2[@"address"];
                        
                        //收货地址id
                        
                        //aid用于支付
                        
                        self.aid=dict2[@"id"];
                        
                        model.id=dict2[@"id"];
                        model.name=dict2[@"name"];
                        model.phone=dict2[@"phone"];
                        model.defaultstate=dict2[@"defaultstate"];
                        
                        if ([dict2[@"phone"] isEqual:null]) {
                            
                            self.phone=@"";
                            
                        }else{
                            
                           self.phone=dict2[@"phone"];
                        }
                        
                        
                        [_addressArrM addObject:model];
                        
                        
                        
                        
                    }
                    
                }
                
                
                NSLog(@"PPPPPPPPPPPPPP==%ld",_addressArrM.count);
                
                for (NSDictionary *dict3 in dict1[@"list"]) {
                    
                    NSLog(@"dic3=%@",dict3);
                    
                    QueRenDingDanModel *model=[[QueRenDingDanModel alloc] init];
                    
                    model.amount=dict3[@"amount"];
                    model.brand=dict3[@"brand"];
                    model.freight=dict3[@"freight"];
                    
                    self.freight=dict3[@"freight"];
                    model.good_type=dict3[@"good_type"];
                    if ([model.good_type isEqualToString:@"8"]) {
                        self.integer=dict1[@"healthy_integral"];
                    }
                    model.id=dict3[@"id"];
                    
                    model.is_attribute=dict3[@"is_attribute"];
                    self.ID=dict3[@"id"];
                    
                    model.integral=dict3[@"integral"];
                    model.mid=dict3[@"mid"];
                    model.attribute_str=dict3[@"attribute_str"];
                    model.name=dict3[@"name"];
                    model.note=dict3[@"note"];
                    model.pay_integer=dict3[@"pay_integer"];
                    
                    self.pay_integer=dict3[@"pay_integer"];
                    
                    model.pay_maney=dict3[@"pay_maney"];
                    
                    self.pay_maney=dict3[@"pay_maney"];
                    
                    model.pice=dict3[@"pice"];
                    model.scopeimg=dict3[@"scopeimg"];
                    model.status=dict3[@"status"];
                    model.stock=dict3[@"stock"];//库存
                    
                    self.stock=dict3[@"stock"];
                    
                    model.type=dict3[@"type"];
                    
                    
                    model.total_money=dict3[@"total_money"];
                    
                    self.good_type=dict3[@"good_type"];
                    self.count=dict3[@"count"];
                    
                    self.money=dict3[@"pice"];
                    self.mid=dict3[@"mid"];
                    self.number=dict3[@"note"];
                    
                    //判断支付方式
//                    self.type=dict3[@"type"];
                    
                    [_datas addObject:model];
                    
                    
                    NSLog(@"---->%@",self.money);
                    NSLog(@"---->%@",self.type);
                    NSLog(@"---->%@",self.gid);
                    NSLog(@"---->%@",self.phone);
                    NSLog(@"---->%@",self.mid);
                    
                    
                }
            }
            
            [_tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-50-KSafeAreaBottomHeight) style:UITableViewStyleGrouped];
    
    _tableView.backgroundColor=[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"DingDanDetailCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"UsingJiFenCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"QueRenDingDanHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"QuerenDingDanAddressCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 49+KSafeAreaBottomHeight)];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 20)];
    label1.text=@"实付金额:";
//    [view1 addSubview:label1];
    
    label2=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, view1.frame.size.width-130, 20)];
    
    label2.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
//    label2.text=@"￥30.00";
    
    label2.textAlignment=NSTextAlignmentRight;
    
    [view1 addSubview:label2];
    
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 49);
    [button setTitle:@"提交订单" forState:0];
    button.titleLabel.font=[UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
    [button addTarget:self action:@selector(NowBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view1 addSubview:button];
}

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return 2;
        
    }else{
        
       return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0) {
        return 115;
    }else if (indexPath.section==0 && indexPath.row==1) {
        return 423;
    }
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNull *null=[[NSNull alloc] init];
    
    if (indexPath.section==0 && indexPath.row==0) {
        
        cell5=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
//        cell5.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
        
        NSLog(@"====阳涛====%@=“0",self.AddressReloadString);
        
        if ([self.AddressReloadString isEqualToString:@"1"]) {
            
            cell5.ShuoMingLabel.hidden=NO;
            
            
        }else{
        
            for (DingDanAddressModel *model in _addressArrM) {
                //判断收货人信息是否为空
                if ([model.name isEqual:null] || [model.phone isEqual:null] || [model.address isEqual:null] || [model.name isEqualToString:@""] || [model.phone isEqualToString:@""] || [model.address isEqualToString:@""]) {
                    
                    cell5.ShuoMingLabel.hidden=NO;
                    
                   
                    
                    NSLog(@"$$$$$$$$$$$$$%@",self.UserPhone);
                    NSLog(@"$$$$$$$$$$$$$%@",self.UserName);
                    NSLog(@"$$$$$$$$$$$$$%@",self.UserAddress);
                }else{
                    cell5.ShuoMingLabel.hidden=YES;
                    
                    
                    if ([self.UserType isEqualToString:@"888"]) {
                        
                        
                        NSLog(@"^^^^^^^^^^^^^^%@",self.UserPhone);
                        NSLog(@"^^^^^^^^^^^^^^%@",self.UserName);
                        NSLog(@"^^^^^^^^^^^^^^%@",self.UserAddress);
                        
                        NSLog(@"!!!!!!!!!!!!!%@",model.phone);
                        NSLog(@"!!!!!!!!!!!!!%@",model.name);
                        NSLog(@"!!!!!!!!!!!!!%@",model.address);
                        
                        
                        cell5.PhoneLabel.hidden=NO;
                        
                        cell5.UserAddressAndPhoneLabel.hidden=NO;
                        
                        cell5.UserAddressLabel.hidden=NO;
                        
                        cell5.ShuoMingLabel.hidden=YES;
                        
                        cell5.PhoneLabel.text=[NSString stringWithFormat:@"%@",self.UserPhone];
                        
                        cell5.UserAddressAndPhoneLabel.text=[NSString stringWithFormat:@"收货人:%@",self.UserName];
                        
                        cell5.UserAddressLabel.text=[NSString stringWithFormat:@"收货地址:%@",self.UserAddress];
                        self.aid=model.id;
                    }else{
                        
                        if ([model.defaultstate isEqualToString:@"1"]) {
                            
                            NSLog(@"&&&&&&&&&&&&&%@",model.phone);
                            NSLog(@"&&&&&&&&&&&&&%@",model.name);
                            NSLog(@"&&&&&&&&&&&&&%@",model.address);
                            
                            cell5.PhoneLabel.text=[NSString stringWithFormat:@"%@",model.phone];
                            
                            cell5.UserAddressAndPhoneLabel.text=[NSString stringWithFormat:@"收货人:%@",model.name];
                            
                            cell5.UserAddressLabel.text=[NSString stringWithFormat:@"收货地址:%@",model.address];
                            self.aid=model.id;
                            break;
                        }else{
                            
                            NSLog(@"************%@",model.phone);
                            NSLog(@"************%@",model.name);
                            NSLog(@"************%@",model.address);
                            cell5.PhoneLabel.text=[NSString stringWithFormat:@"%@",model.phone];
                            
                            cell5.UserAddressAndPhoneLabel.text=[NSString stringWithFormat:@"收货人:%@",model.name];
                            
                            cell5.UserAddressLabel.text=[NSString stringWithFormat:@"收货地址:%@",model.address];
                            self.aid=model.id;
                        }
                    }
                }
            }
        }
        
        
        
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell5;
        
    }else if(indexPath.section==0 && indexPath.row==1){
       
        cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (QueRenDingDanModel *model in _datas) {
//            [cell.LogoImageView sd_setImageWithURL:[NSURL URLWithString:self.logo]];
            [cell.ShopNameButton setTitle:[NSString stringWithFormat:@"%@",self.storename] forState:0];
//            [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            
            [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            
            cell.GoodsNameLabel.text=model.name;
            cell.GoodsShuXingLabel.text=model.attribute_str;
            cell.GoodsNumberLabel.text=[NSString stringWithFormat:@"x1"];
            
            

                
                if (model.attribute_str.length==0) {
                    
                    cell.GoodsPriceLabel.hidden=YES;
                    cell.NewGoodsPriceLabel.hidden=NO;
                    cell.NewGoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];
                    
                    NSString *stringForColor = @"积分";
                    
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:cell.GoodsPriceLabel.text];
                    //
                    NSRange range = [cell.GoodsPriceLabel.text rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range];
                    
                    cell.GoodsPriceLabel.attributedText=mAttStri;
                    
                }else{
                    
                    cell.NewGoodsPriceLabel.hidden=YES;
                    cell.GoodsPriceLabel.hidden=NO;
                    cell.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];

                    NSString *stringForColor = @"积分";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:cell.GoodsPriceLabel.text];
                    //
                    NSRange range = [cell.GoodsPriceLabel.text rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range];
                    
                    cell.GoodsPriceLabel.attributedText=mAttStri;
                    
                }
                
               

            
        
            
            float pay_integer=[self.pay_integer floatValue];
            
            float pay_maney=[self.pay_maney floatValue];
            
            float price=pay_maney + pay_integer;
            
            
            NSLog(@"========================paice:%f",price);
            
            
            //判断积分够不够需求的积分
            pay_integer=[self.pay_integer floatValue]*_num;
            float integer=[self.integer floatValue];
            
            if (integer <= pay_integer) {
                
                FinishJiFen=integer;
            }else{
                
                FinishJiFen=pay_integer;
                
            }
            
            
            //进行配送方式的选择
            if ([self.MoneyType isEqualToString:@"0"]) {//1
                
                //加是否为属性商品运费判断
                float yunfei;
                
                
                //self.freight运费为统一参数
                if ([model.is_attribute isEqualToString:@"2"]) {
                    
                    yunfei=[self.freight floatValue];
                    
                }else{
                    
                    yunfei=[model.freight floatValue];
                }
//
                
                
                NSLog(@"*******===%@",self.freight);
                
                NSLog(@"==####===%@",self.yunfei);
                
                NSLog(@"===运费==%.02f==%@",yunfei,model.freight);
                
                    
//                cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num,(float)_num*price + yunfei*(float)_num];
                
                
            
                NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                NSLog(@"==stringForColor1=合计金额===%@",string1);
                
                // 创建对象.
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                //
                NSRange range1 = [string1 rangeOfString:stringForColor1];
                
                //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                
                [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                cell.YTLabel.attributedText=mAttStri1;
//                cell.YTLabel.text=string1;
                NSLog(@"=17=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
                
                NSString *MarkString = [NSString stringWithFormat:@"%.02f",[self.integer floatValue]];
                
                
                if ([MarkString isEqualToString:@"0.00"] || [BegainStr isEqualToString:@"2"]) {
                    
                    cell.MarkLabel.text=@"(可用积分兑换，1积分=￥1.00)";
                    if ([self.good_type isEqualToString:@"8"]) {
                        cell.MarkLabel.text=@"(可用健康积分兑换，1积分=￥1.00)";

                    }
                }else{
                    
                    cell.MarkLabel.text=@"(已将积分兑换，1积分=￥1.00)";
                    if ([self.good_type isEqualToString:@"8"]) {
                        cell.MarkLabel.text=@"(已将健康积分兑换，1积分=￥1.00)";
                    }
                }
                
                
                
                NSLog(@"=========cell.PriceLabel.text:%@",cell.PriceLabel.text);
                if ([BegainStr isEqualToString:@"1"]) {
                    
                    
                    NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num-FinishJiFen];
                    
                    NSString *stringForColor = @"实付金额:";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                    //
                    NSRange range = [string rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                    
                    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                    
                    label2.attributedText=mAttStri;
                    
                    
//                    label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num-FinishJiFen];
                    //不滑动cell，传入抵扣积分为self.ShiYongJiFen
                    isButtonOn=YES;
                    
                    self.ShiYongJiFen=[NSString stringWithFormat:@"%.02f",FinishJiFen];
                    
                    NSLog(@"=1111111111111111111111111==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                    
                }else{
                    
                    isButtonOn=NO;
                    
                    
                    NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    NSString *stringForColor = @"实付金额:";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                    //
                    NSRange range = [string rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                    
                    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                    
                    label2.attributedText=mAttStri;
                    
//                    label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    //不滑动cell，传入抵扣积分为0
                    self.ShiYongJiFen=[NSString stringWithFormat:@"0.00"];
                    
                    NSLog(@"=2222222222222222222222222222==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                }
                
                
                NSLog(@"=========label2.text:%@",label2.text);
                
                //            str=[NSString stringWithFormat:@"￥%ld",(long)_num*price];
                
                str=[NSString stringWithFormat:@"￥%.02f",/*(long)_num*price + */yunfei*(float)_num];
                
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                
                
                
                
                if ([[userDefaultes stringForKey:@"gouxuan"] isEqualToString:@"2"]){
                    
//                    [cell.TypeButton setTitle:[NSString stringWithFormat:@"线下自取￥0.00"] forState:0];
                    cell.YTPeiSonLabel.text= [NSString stringWithFormat:@"线下自取￥0.00"];
                    
                }else{
                    
                    
                    NSLog(@"$$$$$$$==str=%@=_num=%ld",str,_num);
                    
//                    [cell.TypeButton setTitle:[NSString stringWithFormat:@"快递邮寄 %@",str] forState:0];
                    cell.YTPeiSonLabel.text=[NSString stringWithFormat:@"快递邮寄 %@",str];
                }
                
                
                
                
                
                
            }else if([self.MoneyType isEqualToString:@"1"]){
//                cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                
                NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price];
                
                
                NSLog(@"==stringForColor1=合计金额===%@",string1);
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                // 创建对象.
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                //
                NSRange range1 = [string1 rangeOfString:stringForColor1];
                
                //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                
                [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                cell.YTLabel.attributedText=mAttStri1;
                NSLog(@"=18=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
                
                if ([BegainStr isEqualToString:@"1"]) {
                    
                    NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price-FinishJiFen];
                    
                    NSString *stringForColor = @"实付金额:";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                    //
                    NSRange range = [string rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                    
                    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                    
                    label2.attributedText=mAttStri;
                    
//                    label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price-FinishJiFen];
                    
                    //不滑动cell，传入抵扣积分为self.ShiYongJiFen
                    isButtonOn=YES;
                    
                    self.ShiYongJiFen=[NSString stringWithFormat:@"%.02f",FinishJiFen];
                    
                    NSLog(@"=1313131331313131313==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                    
                    
                }else{
                    
                    
                    NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
                    
                    NSString *stringForColor = @"实付金额:";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                    //
                    NSRange range = [string rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                    
                    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                    
                    label2.attributedText=mAttStri;
                    
//                    label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    
                    isButtonOn=NO;
                    
                    //不滑动cell，传入抵扣积分为0
                    self.ShiYongJiFen=[NSString stringWithFormat:@"0.00"];
                    
                    NSLog(@"=1414141414414141414114==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                }
                
                
                
                NSLog(@"99999999999999%@",label2.text);
                
                
//                [cell.TypeButton setTitle:[NSString stringWithFormat:@"线下自取￥0.00"] forState:0];
                
                cell.YTPeiSonLabel.text=[NSString stringWithFormat:@"线下自取￥0.00"];
            }
            
            //上级页面带入购买件数
            cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
            
            
            //******************************************************************
            
            cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
            
            //******************************************************************
            
            [cell.TypeButton addTarget:self action:@selector(SendTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.ReduceButton addTarget:self action:@selector(ReduceNumberBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.AddButton addTarget:self action:@selector(AddNumberBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            
            //******************************************************************
            
            
            [cell.YTAddButton addTarget:self action:@selector(YTAddNumberBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            
            [cell.YTReduceButton addTarget:self action:@selector(YTReduceNumberBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
//            if ([self.count isEqualToString:@"1"]) {
//                
//                cell.YTNumberTF.enabled=NO;
//                
//            }else{
            
                cell.YTNumberTF.delegate=self;
                cell.YTNumberTF.tag=500;
            
            cell.YTCount=self.count;
            
//            }
            
            
            //******************************************************************
            
            
        }
        
        cell.WordTextField.delegate=self;
        cell.WordTextField.tag=100;
        
        
        return cell;
        
    }else if(indexPath.section==1){
        cell1=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        isButtonOn = [cell1.UseJiFenSwitch isOn];
        
        
        //使用积分开关事件
        [cell1.UseJiFenSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        cell1.UseJiFenSwitch.tag=300;
        
        
        if ([self.Goods_Type_Switch isEqualToString:@"1"]) {
            
            cell1.UseJiFenSwitch.enabled=NO;
        }
        if ([self.type isEqualToString:@"0"]) {
            
            float pay_integer=[self.pay_integer floatValue]*_num;
            
            
            float integer=[self.integer floatValue];
            
            if (integer <= pay_integer) {
                
                FinishJiFen=integer;
                
                cell1.UseJiFenTF.text=[NSString stringWithFormat:@"%.02f",(float)integer];
                cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",(float)integer];
                cell1.ZongJiFenLabel.text=[NSString stringWithFormat:@"(你有%.02f积分，最多可使用%.02f积分)",[self.integer floatValue],(float)integer];
                if ([self.good_type isEqualToString:@"8"]) {
                    cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",(float)integer];
                    cell1.ZongJiFenLabel.text=[NSString stringWithFormat:@"(你有%.02f健康积分，最多可使用%.02f积分)",[self.integer floatValue],(float)integer];
                }





                jifen=integer;
            }else{
                
                FinishJiFen=pay_integer;
                
                cell1.UseJiFenTF.text=[NSString stringWithFormat:@"%.02f",(float)pay_integer];
                cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",(float)pay_integer];
                cell1.ZongJiFenLabel.text=[NSString stringWithFormat:@"(你有%.02f积分，最多可使用%.02f积分)",[self.integer floatValue],(float)pay_integer];
                if ([self.good_type isEqualToString:@"8"]) {
                    cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",(float)pay_integer];
                    cell1.ZongJiFenLabel.text=[NSString stringWithFormat:@"(你有%.02f健康积分，最多可使用%.02f积分)",[self.integer floatValue],(float)pay_integer];
                }
                jifen=pay_integer;
            }
            
        }else{
            
            MaxUseJiFen=[self.pay_integer floatValue]*_num;
            
            UserJiFen=[self.integer floatValue];
            
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            if (UserJiFen <= MaxUseJiFen) {
                
                FinishJiFen=UserJiFen;
                NSLog(@"用户最终%f",FinishJiFen);
                cell1.UseJiFenTF.text=[NSString stringWithFormat:@"%.02f",(float)UserJiFen];
                
//                self.ShiYongJiFen=[NSString stringWithFormat:@"%ld",(long)integer];
                
                cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",(float)UserJiFen];
                cell1.ZongJiFenLabel.text=[NSString stringWithFormat:@"(你有%.02f积分，最多可使用%.02f积分)",[self.integer floatValue],(CGFloat)UserJiFen];
                if ([self.good_type isEqualToString:@"8"]) {
                    cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",(float)UserJiFen];
                    cell1.ZongJiFenLabel.text=[NSString stringWithFormat:@"(你有%.02f健康积分，最多可使用%.02f积分)",[self.integer floatValue],(CGFloat)UserJiFen];
                }
            }else{
                
                FinishJiFen=MaxUseJiFen;
                NSLog(@"用户最终%f",FinishJiFen);
                cell1.UseJiFenTF.text=[NSString stringWithFormat:@"%.02f",(float)MaxUseJiFen];
                
//                self.ShiYongJiFen=[NSString stringWithFormat:@"%ld",(long)pay_integer];
                
                cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",(float)MaxUseJiFen];
                cell1.ZongJiFenLabel.text=[NSString stringWithFormat:@"(你有%.02f积分，最多可使用%.02f积分)",[self.integer floatValue],(float)MaxUseJiFen];
                if ([self.good_type isEqualToString:@"8"]) {
                    cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",(float)MaxUseJiFen];
                    cell1.ZongJiFenLabel.text=[NSString stringWithFormat:@"(你有%.02f健康积分，最多可使用%.02f积分)",[self.integer floatValue],(float)MaxUseJiFen];
                }
            }
        }
        
        
        if ([BegainStr isEqualToString:@"1"]) {
           
            
            //////////////////////////默认积分打开//////////////////////////////////////////////
            
//            NSInteger number1=FinishJiFen;
//            
//            self.ShiYongJiFen=cell1.UseJiFenTF.text;
            
            
         
//            NSLog(@"=====%ld",(long)number);
            
            
            
            NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)([self.ZongJi floatValue]-FinishJiFen)];
            
            NSString *stringForColor = @"实付金额:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
            
            label2.attributedText=mAttStri;
            
//          label2.text=[NSString stringWithFormat:@"￥%.02f",(float)([self.ZongJi floatValue]-FinishJiFen)];
            
            ///////////////////////////////////////////////////////////////////////
            
        }
        
        
        //使用积分输入框添加代理
        cell1.UseJiFenTF.delegate=self;
        [cell1.UseJiFenTF addTarget:self action:@selector(jifenChanges:) forControlEvents:UIControlEventEditingChanged];
        cell1.UseJiFenTF.tag=200;
        
        return cell1;
    }else{
        return nil;
    }
}

-(void)jifenChanges:(UITextField *)TF
{
    YLog(@"%@",TF.text);
    if ([TF isEqual:cell1.UseJiFenTF]) {
        if ([TF.text containsString:@"."]) {
            NSRange range=[TF.text rangeOfString:@"."];
            if (TF.text.length-range.location>3) {
                TF.text=[NSString stringWithFormat:@"%@",[TF.text substringToIndex:range.location+3]];
            }
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    [cell.YTNumberTF resignFirstResponder];
    if (indexPath.section==0 && indexPath.row==0) {
        
        NSLog(@"==$$$$$=%ld===",_addressArrM.count);
        
        if (YTarray.count==0) {
            
            YTAddressViewController *vc=[[YTAddressViewController alloc] init];
            
            vc.YTString=@"100";
            
            vc.delegate=self;
            
            self.navigationController.navigationBar.hidden=YES;
            
            [self.navigationController pushViewController:vc animated:NO];
            
        }else{
            
            YTAddressManngerViewController *vc=[[YTAddressManngerViewController alloc] init];
            
            vc.back=@"100";
            
            vc.YTString=@"200";
            
            vc.delegate=self;
            
            [self.navigationController pushViewController:vc animated:NO];
            
            self.navigationController.navigationBar.hidden=YES;
            
            
        }
        
    }
    
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    isButtonOn = [switchButton isOn];
    
    if (isButtonOn) {
        NSLog(@"on");
        
        BegainStr=@"1";
        
        
        float number1=[cell1.UseJiFenTF.text floatValue];
        
        self.ShiYongJiFen=cell1.UseJiFenTF.text;
        
        NSLog(@"=3333333333333333333333==self.ShiYongJiFen====%@",self.ShiYongJiFen);
        float number3=[self.ZongJi floatValue];
        float number=number3-number1;
        
        
        NSLog(@"///////%@",self.ShiYongJiFen);
//        NSLog(@"=====%ld",number1);
//        NSLog(@"=====%@",self.ZongJi);
//        NSLog(@"=====%ld",number);
        
        _ShiFuMoney=[NSString stringWithFormat:@"￥%.02f",(float)number];
        
        
        NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)number];
        
        NSString *stringForColor = @"实付金额:";
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
        //
        NSRange range = [string rangeOfString:stringForColor];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
        
        label2.attributedText=mAttStri;
        
//        label2.text=_ShiFuMoney;
        
//        NSLog(@">>>>>>%@",label2.text);
        
        [_tableView reloadData];
        
    }else {
        NSLog(@"off");
        
        self.ShiYongJiFen=@"0";
        
        BegainStr=@"2";
        
        NSLog(@"\\\\\\\\\%@",self.ShiYongJiFen);
        NSInteger number2=[self.ZongJi floatValue];
        
//        NSLog(@"==%ld",number2);
        _ShiFuMoney=[NSString stringWithFormat:@"￥%.02f",(float)number2];
        
//        label2.text=_ShiFuMoney;
        
        NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)number2];
        
        NSString *stringForColor = @"实付金额:";
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
        //
        NSRange range = [string rangeOfString:stringForColor];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
        
        label2.attributedText=mAttStri;
        
//        NSLog(@">>>>>>%@",label2.text);
//        [_tableView reloadData];
        
        NSLog(@"=444444444444444444444444==self.ShiYongJiFen====%@",self.ShiYongJiFen);
    }
    
    
    
    [_tableView reloadData];
    
}

//输入积分时，调用
-(void)textFieldDidEndEditing:(UITextField *)textField{
    

    UITextField *TF = (UITextField *)[self.view viewWithTag:200];
    
    UITextField *TF1 = (UITextField *)[self.view viewWithTag:100];

    UITextField *TF2 = (UITextField *)[self.view viewWithTag:500];
//    UISwitch *SH = (UISwitch*)[self.view viewWithTag:300];
    NSLog(@"SH==%d",isButtonOn);
    if (TF == textField&&isButtonOn==YES) {
        NSLog(@"我输入了==%@",textField.text);
        NSLog(@"总计==%@",self.ZongJi);
        NSLog(@"总计==%.02f",(float)[self.ZongJi floatValue]  - [textField.text floatValue]);
        NSLog(@"用户最终%.02f",FinishJiFen);
        
        if ([textField.text floatValue] > FinishJiFen) {
    
            textField.text=[NSString stringWithFormat:@"%.02f",(float)FinishJiFen];
            
            self.ShiYongJiFen=textField.text;
            
            NSLog(@"=55555555555555555555555555==self.ShiYongJiFen====%@",self.ShiYongJiFen);
            
            NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",[self.ZongJi floatValue] - [textField.text floatValue]];
            
            NSString *stringForColor = @"实付金额:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
            
            label2.attributedText=mAttStri;
            
//            label2.text  =[NSString stringWithFormat:@"%.02f",[self.ZongJi floatValue] - [textField.text floatValue]];
            
            
            cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",[self.ShiYongJiFen floatValue]];
        }else{
            
            
            NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",[self.ZongJi floatValue] - [textField.text floatValue]];
            
            NSString *stringForColor = @"实付金额:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
            
            label2.attributedText=mAttStri;
            
            
//            label2.text  =[NSString stringWithFormat:@"%.02f",[self.ZongJi floatValue] - [textField.text floatValue]];
            
            self.ShiYongJiFen=textField.text;
            
            cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",[self.ShiYongJiFen floatValue]];
            
            NSLog(@"=6666666666666666666666666==self.ShiYongJiFen====%@",self.ShiYongJiFen);
        }
        
        
    }else if(TF1 == textField){
        
        
    }else if(TF2 == textField){
        
        NSLog(@"键盘被点击了");
        
        if ([textField.text intValue] > [self.stock intValue]) {
            
            
            [JRToast showWithText:@"您输入的购买数不能大于库存量！" duration:1.0f];
            
            _num=1;
            
        }else if(![self.count isEqualToString:@"0"]){
            
            
            if ([textField.text intValue] >= [self.count intValue]) {
                
                
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"该商品限购%@件",self.count] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alertView show];
                
                
//                [JRToast showWithText:[NSString stringWithFormat:@"该商品限购%@件",self.count] duration:3.0f];
                
                _num=1;
                
            }
            
            
        }else{
            
            _num=[textField.text intValue];

        }

        [_tableView reloadData];

        //************************************************

    }else{
    
        textField.text=[NSString stringWithFormat:@"%.02f",(float)FinishJiFen];
        
        self.ShiYongJiFen=@"0";
        
        cell1.JiFenDuiXianLabel.text=[NSString stringWithFormat:@"积分兑现￥%.02f",[self.ShiYongJiFen floatValue]];
        
        NSLog(@"=7777777777777777777777==self.ShiYongJiFen====%@",self.ShiYongJiFen);

    }

}
//配送方式
-(void)SendTypeBtnClick
{
    
    NSLog(@"=========&&&&&&&&===%@",self.exchange);
    
    if ([self.exchange integerValue] == 1|| [self.exchange integerValue] == 2) {
//        CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄"]];
        
//        mySheet.cancelTitle=@"关闭";
//        mySheet.delegate = self;
//        [mySheet show];
        
        self.MoneyType=@"0";
        
    }else if([self.exchange integerValue] == 3|| [self.exchange integerValue] == 4){
        
        CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄",@"线下自取"]];
        
        mySheet.cancelTitle=@"关闭";
        
        mySheet.delegate = self;
        
        
        [mySheet show];
        
    }
    
}

//配送方式代理方法
- (void)sheet:(CustomActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((long)buttonIndex==0) {
//        [cell.TypeButton setTitle:[NSString stringWithFormat:@"快递邮寄"] forState:0];
        cell.YTPeiSonLabel.text=@"快递邮寄";
        
        self.MoneyType=@"0";
        
        [_tableView reloadData];
        
        //缓存勾选状态
        [UserMessageManager GoodsImageSecect:@"1"];
        
        
    }else if ((long)buttonIndex==1){
        
//        [cell.TypeButton setTitle:[NSString stringWithFormat:@"线下自取￥0.00"] forState:0];
        
        cell.YTPeiSonLabel.text=@"线下自取￥0.00";
        self.MoneyType=@"1";
        
        //缓存勾选状态
        [UserMessageManager GoodsImageSecect:@"2"];
        
        [_tableView reloadData];
    }
}


-(void)YTAddNumberBtnClick
{
    
    NSLog(@"************%ld",_num);
    NSLog(@"************%@",self.count);
    
    //    _num=_num+1;
    
    NSInteger number10=[self.stock integerValue];
    if (_num > number10) {
        
        self.ChaoChuKuCun=@"100";
        
        NSLog(@"++SSSSS+++++%@",self.ChaoChuKuCun);
    }else{
        
        self.ChaoChuKuCun=@"001";
        
        NSLog(@"++WWWWWW+++++%@",self.ChaoChuKuCun);
    }
    
    NSLog(@"************====%ld",(long)_num);
    
    if ([self.good_type isEqualToString:@"1"] || !(self.detailId.length==0)) {
        
        
        if ([self.count integerValue]==0) {
            
            
            int yunfei=[self.freight intValue];
            
            NSInteger number=[self.stock integerValue];
            
            float pay_integer=[self.pay_integer floatValue];
            
            float pay_maney=[self.pay_maney floatValue];
            
            float price=pay_maney+pay_integer;
            
            //    NSLog(@"====%@",self.stock);
            
            if (_num < number) {
                cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
                
                //******************************************************************
                
                cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
                
                //******************************************************************
                
//                cell.AmountLabel.text=[NSString stringWithFormat:@"共%ld件商品",(long)_num-1];
                
                if ([self.type isEqualToString:@"0"]) {
//                    cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price + yunfei*(float)_num];
                    
                    
                    NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                    //
                    NSRange range1 = [string1 rangeOfString:stringForColor1];
                    
                    //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                    
                    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                    
                    cell.YTLabel.attributedText=mAttStri1;
                    
                    NSLog(@"=1=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                    
                    self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    
                    NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    NSString *stringForColor = @"实付金额:";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                    //
                    NSRange range = [string rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                    
                    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                    
                    label2.attributedText=mAttStri;
                    
//                    label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    [_tableView reloadData];
                    
                }else{
//                    cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    
                    NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price];
                    
                    NSLog(@"==stringForColor1=合计金额===%@",string1);
                    NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                    //
                    NSRange range1 = [string1 rangeOfString:stringForColor1];
                    
                    //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                    
                    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                    
                    cell.YTLabel.attributedText=mAttStri1;
                    
                    NSLog(@"=2=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                    self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
                    
                    NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
                    
                    NSString *stringForColor = @"实付金额:";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                    //
                    NSRange range = [string rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                    
                    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                    
                    label2.attributedText=mAttStri;
                    
//                    label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    
                    str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    
                    [_tableView reloadData];
                }
                
            }else{
                
                
                NSLog(@"11111111===");
                
                NSInteger number=[self.stock integerValue];
                
                _num=number;
                self.ChaoChuKuCun=@"100";
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"超出库存!" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                _num--;
                [alertView show];
                cell.AddButton.enabled=NO;
            }
            
            
            
        }else{
            
            
            if (_num >= [self.count integerValue]) {
                
//                [JRToast showWithText:[NSString stringWithFormat:@"该商品限购%@件",self.count] duration:3.0f];
                
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"该商品限购%@件",self.count] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alertView show];
                
                
                
                _num=[self.count integerValue];
                
                cell.YTAddButton.enabled=NO;
                
                self.ChaoChuKuCun=@"666";
                
            }else{
                
                int yunfei=[self.freight intValue];
                
                NSInteger number=[self.stock integerValue];
                
                float pay_integer=[self.pay_integer floatValue];
                
                float pay_maney=[self.pay_maney floatValue];
                
                float price=pay_maney+pay_integer;
                
                //    NSLog(@"====%@",self.stock);
                
                
                //2
                if (_num < number) {
                    cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
                    
                    //******************************************************************
                    
                    cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
                    
                    //******************************************************************
                    
//                    cell.AmountLabel.text=[NSString stringWithFormat:@"共%ld件商品",(long)_num-1];
                    //3
                    if ([self.type isEqualToString:@"0"]) {
//                        cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price + yunfei*(float)_num];
                        
                        NSLog(@"==stringForColor1=合计金额===%@",string1);
                        NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                        // 创建对象.
                        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                        //
                        NSRange range1 = [string1 rangeOfString:stringForColor1];
                        
                        //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                        
                        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                        
                        cell.YTLabel.attributedText=mAttStri1;
                        
                        NSLog(@"=3=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                        self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        
                        NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        NSString *stringForColor = @"实付金额:";
                        // 创建对象.
                        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                        //
                        NSRange range = [string rangeOfString:stringForColor];
                        
                        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                        
                        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                        
                        label2.attributedText=mAttStri;
                        
//                        label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        [_tableView reloadData];
                        
                    }else{
//                        cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                        
                        NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price];
                        
                        NSLog(@"==stringForColor1=合计金额===%@",string1);
                        NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                        // 创建对象.
                        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                        //
                        NSRange range1 = [string1 rangeOfString:stringForColor1];
                        
                        //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                        
                        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                        
                        cell.YTLabel.attributedText=mAttStri1;
                        NSLog(@"=4=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                        self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
                        
                        NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
                        
                        NSString *stringForColor = @"实付金额:";
                        // 创建对象.
                        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                        //
                        NSRange range = [string rangeOfString:stringForColor];
                        
                        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                        
                        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                        
                        label2.attributedText=mAttStri;
                        
//                        label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                        
                        str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                        
                        [_tableView reloadData];
                    }
                    //3
                }else{
                    
                    NSLog(@"2222222222===");
                    
                    
                    NSInteger number=[self.stock integerValue];
                    
                    _num=number;
                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"超出库存!" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    self.ChaoChuKuCun=@"100";
                    [alertView show];
                    _num--;
                    cell.AddButton.enabled=NO;
                }
                //2
            }
            
        }
        //1
    }else{
        
        
        int yunfei=[self.freight intValue];
        
        NSInteger number=[self.stock integerValue];
        
        float pay_integer=[self.pay_integer floatValue];
        
        float pay_maney=[self.pay_maney floatValue];
        
        float price=pay_maney+pay_integer;
        
        //    NSLog(@"====%@",self.stock);
        
        if (_num < number) {
            cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
            
            //******************************************************************
            
            cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
            
            //******************************************************************
            
//            cell.AmountLabel.text=[NSString stringWithFormat:@"共%ld件商品",(long)_num-1];
            
            if ([self.type isEqualToString:@"0"]) {
//                cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price + yunfei*(float)_num];
                
                NSLog(@"==stringForColor1=合计金额===%@",string1);
                NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                // 创建对象.
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                //
                NSRange range1 = [string1 rangeOfString:stringForColor1];
                
                //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                
                [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                cell.YTLabel.attributedText=mAttStri1;
                NSLog(@"=5=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
                
                
                NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                NSString *stringForColor = @"实付金额:";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                
                label2.attributedText=mAttStri;
                
//                label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                [_tableView reloadData];
                
            }else{
//                cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                
                NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price];
                
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                // 创建对象.
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                //
                NSRange range1 = [string1 rangeOfString:stringForColor1];
                
                //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                
                [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                cell.YTLabel.attributedText=mAttStri1;
                NSLog(@"=6=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
                
                
                NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
                
                NSString *stringForColor = @"实付金额:";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                
                label2.attributedText=mAttStri;
                
//                label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                
                str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                
                [_tableView reloadData];
            }
            
        }else{
            
            
            NSLog(@"333333333===");
            NSInteger number=[self.stock integerValue];
            
            _num=number;
            self.ChaoChuKuCun=@"100";
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"超出库存!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            _num--;

            [alertView show];
            cell.AddButton.enabled=NO;
        }
        
        
    }
    
    _num=_num+1;
}

-(void)YTReduceNumberBtnClick
{
    cell.AddButton.enabled=YES;
    
    int yunfei=[self.freight intValue];
    
    if ([cell.YTNumberTF.text isEqualToString:@"1"]) {
        cell.YTReduceButton.enabled=YES;
    }else{
        
        float pay_integer=[self.pay_integer floatValue];
        
        float pay_maney=[self.pay_maney floatValue];
        
        float price=pay_maney+pay_integer;
        
        _num=_num-1;
        
        cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
        
        //******************************************************************
        
        cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
        
        //******************************************************************
        
//        cell.AmountLabel.text=[NSString stringWithFormat:@"共%ld件商品",(long)_num];
        
        if ([self.type isEqualToString:@"0"]) {
//            cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
            
            NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num,(float)_num*price + yunfei*(float)_num];
            
            NSLog(@"==stringForColor1=合计金额===%@",string1);
            NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
            // 创建对象.
            NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
            //
            NSRange range1 = [string1 rangeOfString:stringForColor1];
            
            //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
            
            [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
            
            cell.YTLabel.attributedText=mAttStri1;
            NSLog(@"=7=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
            self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
            
            
            NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
            
            NSString *stringForColor = @"实付金额:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
            
            label2.attributedText=mAttStri;
            
//            label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
            
            str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
            
            [_tableView reloadData];
            
        }else{
//            cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
            
            NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num,(float)_num*price];
            
            NSLog(@"==stringForColor1=合计金额===%@",string1);
            NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
            // 创建对象.
            NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
            //
            NSRange range1 = [string1 rangeOfString:stringForColor1];
            
            //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
            
            [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
            
            cell.YTLabel.attributedText=mAttStri1;
            NSLog(@"=8=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
            self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
            
            
            NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
            
            NSString *stringForColor = @"实付金额:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
            
            label2.attributedText=mAttStri;
            
            
//            label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
            
            str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
            
            [_tableView reloadData];
        }
    }
    
    
}

//购买数量+
-(void)AddNumberBtnClick
{
    NSLog(@"************%ld",_num);
    NSLog(@"************%@",self.count);
    
//    _num=_num+1;
    
    NSInteger number10=[self.stock integerValue];
    if (_num > number10) {
        
        self.ChaoChuKuCun=@"100";
        
        NSLog(@"++SSSSS+++++%@",self.ChaoChuKuCun);
    }else{
        
        self.ChaoChuKuCun=@"001";
        
        NSLog(@"++WWWWWW+++++%@",self.ChaoChuKuCun);
    }
    
    NSLog(@"************====%ld",(long)_num);
    
    if ([self.good_type isEqualToString:@"1"] || !(self.detailId.length==0)) {
        
        
        if ([self.count integerValue]==0) {
            
            
            int yunfei=[self.freight intValue];
            
            NSInteger number=[self.stock integerValue];
            
            float pay_integer=[self.pay_integer floatValue];
            
            float pay_maney=[self.pay_maney floatValue];
            
            float price=pay_maney+pay_integer;
            
            //    NSLog(@"====%@",self.stock);
            
            if (_num < number) {
                cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
                
                
                //******************************************************************
                
                cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
                
                //******************************************************************
                
                
//                cell.AmountLabel.text=[NSString stringWithFormat:@"共%ld件商品",(long)_num-1];
                
                if ([self.type isEqualToString:@"0"]) {
//                    cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    
                    NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price + yunfei*(float)_num];
                    
                    NSLog(@"==stringForColor1=合计金额===%@",string1);
                    NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                    //
                    NSRange range1 = [string1 rangeOfString:stringForColor1];
                    
                    //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                    
                    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                    
                    cell.YTLabel.attributedText=mAttStri1;
                    NSLog(@"=9=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                    self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    
                    NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    NSString *stringForColor = @"实付金额:";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                    //
                    NSRange range = [string rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                    
                    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                    
                    label2.attributedText=mAttStri;
                    
//                    label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                    
                    [_tableView reloadData];
                    
                }else{
//                    cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    
                    NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price];
                    
                    NSLog(@"==stringForColor1=合计金额===%@",string1);
                    NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                    //
                    NSRange range1 = [string1 rangeOfString:stringForColor1];
                    
                    //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                    
                    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                    
                    cell.YTLabel.attributedText=mAttStri1;
                    NSLog(@"=10=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                    
                    self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
                    
                    
                    NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
                    
                    NSString *stringForColor = @"实付金额:";
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                    //
                    NSRange range = [string rangeOfString:stringForColor];
                    
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                    
                    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                    
                    label2.attributedText=mAttStri;
                    
//                    label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    
                    str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                    
                    [_tableView reloadData];
                }
                
            }else{
                
                
                NSLog(@"11111111===");
                
                NSInteger number=[self.stock integerValue];
                
                _num=number;
                self.ChaoChuKuCun=@"100";
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"超出库存!" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                _num--;

                [alertView show];
                cell.AddButton.enabled=NO;
            }

            
            
        }else{
            
            NSLog(@"====每人限购==%ld====%ld",(long)_num,(long)[self.count integerValue]);
            if (_num >= [self.count integerValue]) {
                
                
                NSLog(@"====每人限购====");
                
                [JRToast showWithText:[NSString stringWithFormat:@"每人限购%@件",self.count] duration:3.0f];
                
                _num=[self.count integerValue];
                
                cell.YTAddButton.enabled=NO;
                
                self.ChaoChuKuCun=@"666";
                
            }else{
                
                int yunfei=[self.freight intValue];
                
                NSInteger number=[self.stock integerValue];
                
                float pay_integer=[self.pay_integer floatValue];
                
                float pay_maney=[self.pay_maney floatValue];
                
                float price=pay_maney+pay_integer;
                
                //    NSLog(@"====%@",self.stock);
                
                
                //2
                if (_num < number) {
                    cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
                    
                    //******************************************************************
                    
                    cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
                    
                    //******************************************************************
                    
 //                   cell.AmountLabel.text=[NSString stringWithFormat:@"共%ld件商品",(long)_num-1];
                    //3
                    if ([self.type isEqualToString:@"0"]) {
//                        cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price + yunfei*(float)_num];
                        
                        NSLog(@"==stringForColor1=合计金额===%@",string1);
                        NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                        // 创建对象.
                        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                        //
                        NSRange range1 = [string1 rangeOfString:stringForColor1];
                        
                        //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                        
                        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                        
                        cell.YTLabel.attributedText=mAttStri1;
                        NSLog(@"=11=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                        
                        self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        
                        NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        NSString *stringForColor = @"实付金额:";
                        // 创建对象.
                        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                        //
                        NSRange range = [string rangeOfString:stringForColor];
                        
                        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                        
                        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                        
                        label2.attributedText=mAttStri;
                        
//                        label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                        
                        [_tableView reloadData];
                        
                    }else{
//                        cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                        
                        NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price];
                        NSLog(@"==stringForColor1=合计金额===%@",string1);
                        
                        NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                        // 创建对象.
                        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                        //
                        NSRange range1 = [string1 rangeOfString:stringForColor1];
                        
                        //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                        
                        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                        
                        cell.YTLabel.attributedText=mAttStri1;
                        NSLog(@"=12=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                        
                        self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
                        
                        NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
                        
                        NSString *stringForColor = @"实付金额:";
                        // 创建对象.
                        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                        //
                        NSRange range = [string rangeOfString:stringForColor];
                        
                        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                        
                        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                        
                        label2.attributedText=mAttStri;
                        
                        
//                        label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                        
                        str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                        
                        [_tableView reloadData];
                    }
                    //3
                }else{
                    
                    NSLog(@"2222222222===");
                    
                    
                    NSInteger number=[self.stock integerValue];
                    
                    _num=number;
                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"超出库存!" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    self.ChaoChuKuCun=@"100";
                    [alertView show];
                    _num--;

                    cell.AddButton.enabled=NO;
                }
                //2
            }
            
        }
//1
    }else{
      
        
        int yunfei=[self.freight intValue];
        
        NSInteger number=[self.stock integerValue];
        
        float pay_integer=[self.pay_integer floatValue];
        
        float pay_maney=[self.pay_maney floatValue];
        
        float price=pay_maney+pay_integer;
        
        //    NSLog(@"====%@",self.stock);
        
        if (_num < number) {
            cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
            
            //******************************************************************
            
            cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
            
            //******************************************************************
            
//            cell.AmountLabel.text=[NSString stringWithFormat:@"共%ld件商品",(long)_num-1];
            
            if ([self.type isEqualToString:@"0"]) {
//                cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                
                NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price + yunfei*(float)_num];
                NSLog(@"==stringForColor1=合计金额===%@",string1);
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                // 创建对象.
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                //
                NSRange range1 = [string1 rangeOfString:stringForColor1];
                
//                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                
                [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
               cell.YTLabel.attributedText=mAttStri1;
                NSLog(@"=13=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                
                self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
                
                NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                NSString *stringForColor = @"实付金额:";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                
                label2.attributedText=mAttStri;
                
//                label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
                
                [_tableView reloadData];
                
            }else{
//                cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                
                
                NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price];
                
                NSLog(@"==stringForColor1=合计金额===%@",string1);
                NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                // 创建对象.
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
                //
                NSRange range1 = [string1 rangeOfString:stringForColor1];
                
                //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
                
                [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                cell.YTLabel.attributedText=mAttStri1;
                NSLog(@"=14=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
                
                self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
                
                
                NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
                
                NSString *stringForColor = @"实付金额:";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
                
                label2.attributedText=mAttStri;
                
//                label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                
                str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
                
                [_tableView reloadData];
            }
            
        }else{
            
            
            NSLog(@"333333333===");
            NSInteger number=[self.stock integerValue];
            
            _num=number;
            self.ChaoChuKuCun=@"100";
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"超出库存!" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            _num--;

            [alertView show];
            cell.AddButton.enabled=NO;
        }

        
    }
    
    _num=_num+1;
    
}

//购买数量-
-(void)ReduceNumberBtnClick
{
    
    cell.AddButton.enabled=YES;
    
    int yunfei=[self.freight intValue];
    
    if ([cell.NumberLabel.text isEqualToString:@"1"]) {
        cell.ReduceButton.enabled=YES;
    }else{
        
        float pay_integer=[self.pay_integer floatValue];
        
        float pay_maney=[self.pay_maney floatValue];
        
        float price=pay_maney+pay_integer;
        
        _num=_num-1;
        
        cell.NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)_num];
        
        //******************************************************************
        
        cell.YTNumberTF.text=[NSString stringWithFormat:@"%ld",(long)_num];
        
        //******************************************************************
        
//        cell.AmountLabel.text=[NSString stringWithFormat:@"共%ld件商品",(long)_num];
        
        if ([self.type isEqualToString:@"0"]) {
//            cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
            
            
            NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num,(float)_num*price + yunfei*(float)_num];
            
            NSLog(@"==stringForColor1=合计金额===%@",string1);
            NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
            // 创建对象.
            NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
            //
            NSRange range1 = [string1 rangeOfString:stringForColor1];
            
            //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
            
            [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
            
            cell.YTLabel.attributedText=mAttStri1;
            NSLog(@"=15=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
            
            self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price + yunfei*(float)_num];
            
            
            NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price + yunfei*(float)_num];
            
            NSString *stringForColor = @"实付金额:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
            
            label2.attributedText=mAttStri;
            
            
//            label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
            
            str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price + yunfei*(float)_num];
            
            [_tableView reloadData];
            
        }else{
//            cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
            
            
            NSString *string1 = [NSString stringWithFormat:@"共%ld件商品  合计:￥%.02f",(long)_num-1,(float)_num*price];
            
            NSLog(@"==stringForColor1=合计金额===%@",string1);
            NSString *stringForColor1 = [NSString stringWithFormat:@"￥%.02f",(float)_num*price];
            // 创建对象.
            NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:string1];
            //
            NSRange range1 = [string1 rangeOfString:stringForColor1];
            
            //                [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
            
            [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
            
            cell.YTLabel.attributedText=mAttStri1;
            
            NSLog(@"=16=stringForColor1=合计金额===%@==%@",string1,cell.YTLabel.attributedText);
            self.ZongJi=[NSString stringWithFormat:@"%.02f",(float)_num*price];
            
            
            NSString *string = [NSString stringWithFormat:@"实付金额:￥%.02f",(float)_num*price];
            
            NSString *stringForColor = @"实付金额:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range];
            
            label2.attributedText=mAttStri;
            
            
//            label2.text=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
            
            str=[NSString stringWithFormat:@"￥%.02f",(float)_num*price];
            
            [_tableView reloadData];
        }
    }
}

//控制输入文字的长度和内容，可通调用以下代理方法实现
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{


    if (range.location==0)
    {
        //控制输入文本的长度
//        textView.text=@"选填，有什么小要求在这提醒卖家";
        
        return  YES;
        
    }else if (range.location>=200){
        
        return NO;
        
    }
    
    if ([text isEqualToString:@"\n"]||[text containsString:@"\n"]) {
        //禁止输入换行
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"选填，有什么小要求在这提醒卖家"] ) {
        textView.text=@"";
    }
    
}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView.text.length==0) {
        
        textView.text=@"选填，有什么小要求在这提醒卖家";
//        textView.textColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    }
    
    [UserMessageManager UserWord:textView.text];
    
    NSLog(@"==&&&&===%@",textView.text);
    
}

//将要结束编辑

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        
        textView.text=@"选填，有什么小要求在这提醒卖家";
    }
    return YES;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.00000000001;
    }else{
        return 1;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSLog(@"======NSUserDefaults=====%@",[userDefaultes stringForKey:@"guige"]);
    
    
    NSDictionary *dict1 =[[NSDictionary alloc] initWithObjectsAndKeys:[userDefaultes stringForKey:@"guige"],@"textOne", nil];
    
    NSNotification *notification1 = [[NSNotification alloc] initWithName:@"QueRenDingDanBack" object:nil userInfo:dict1];
    
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
    
    //通知属性弹框消失
    NSNotification *notifiication = [[NSNotification alloc] initWithName:@"tankuangxiaoshi" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notifiication];
    
    [UserMessageManager removeUserWord];
    
    //通知显示购物车件数
    
    NSNotification *notifiication3 = [[NSNotification alloc] initWithName:@"GoodsDetailAndTuWenCartNumber" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notifiication3];
    
    NSArray *arrays = self.navigationController.viewControllers;
    
    NSLog(@"=====arrays====%ld",(unsigned long)arrays.count);
    
    if ([self.CutLogin isEqualToString:@"100"]) {
        
        if (arrays.count > 4) {
            
            [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
            self.tabBarController.tabBar.hidden=YES;
            
        }else{
            
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            self.tabBarController.tabBar.hidden=YES;
        }
        
        
    }else if ([self.CutLogin isEqualToString:@"200"]) {
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.tabBar.hidden=YES;
    }
    
    
    
}

//
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (textField ==cell1.UseJiFenTF) {

        return [self validateNumber:string];

    }

    return YES;
}
//确定
-(void)NowBuyBtnClick
{
    
        
///////////////////////////////////////////////////////////////////////////////////////////////
//    NSNull *null=[[NSNull alloc] init];
    
    NSLog(@"(((((((((((((===%@",label2.text);
    
    if ((_addressArrM.count==0) || [self.phone isEqualToString:@""]/* && [self.UserPhone isEqualToString:@""])*/) {
        
        UIAlertView *YTalertView=[[UIAlertView alloc] initWithTitle:@"请添加收货人信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        YTalertView.tag=10000;
        
        
        [YTalertView show];
        
    }else{
        
        if ([self.good_type isEqualToString:@"1"]) {
            
            if ([self.stuts isEqualToString:@"10003"]) {
                
                [JRToast showWithText:[NSString stringWithFormat:@"每人限购%@件，您已无法购买",self.count] duration:3.0f];
                
                
            }else{
                
                if (cell.WordTextField.text.length>200) {
                    
                    [JRToast showWithText:@"您最多输入128个字符" duration:3.0f];
                }else{
                    //支付
                    [self payMoney];
                    
//                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
//                    [SVProgressHUD showWithStatus:@"请耐心等待..."];
//                    
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        
//                        [SVProgressHUD dismiss];
                    
//                    });
                }
            }
        }/*else if([label2.text isEqualToString:@"￥0.00"]){
            
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"无需现金，将直接扣除你的部分积分以完成支付" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            
            [alertView show];
            
        }*/else{
            
            NSString *str1=[str substringFromIndex:5];
            
            if([str1 isEqualToString:@"￥0.00"]){
                
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"无需现金，将直接扣除你的部分积分以完成支付" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                
                alertView.tag=80000;
                
                
                [alertView show];
            
            }else{
                                
                if (cell.WordTextField.text.length>200) {
                    
                    [JRToast showWithText:@"您最多输入128个字符" duration:3.0f];
                    
                }else{
                    //支付
                    [self payMoney];
                    
                    
                    
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        
//                        
//                        
//                    });
                }
//                //支付
//                [self payMoney];
//                
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
//                [SVProgressHUD showWithStatus:@"请耐心等待..."];
//                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    
//                    
//                    [SVProgressHUD dismiss];
//                    
//                });
            }
            
            
            
        }
        
    }
}

//支付
-(void)payMoney
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD showWithStatus:@"请耐心等待..."];
    
    NSNull *null=[[NSNull alloc] init];
    
    NSLog(@"====>>%ld",_num);
    NSLog(@"====>>%@",self.ShiYongJiFen);
    NSLog(@"====>>%@",self.phone);
    NSLog(@"====>>%@",self.UserPhone);
    NSLog(@"====>>%@",self.ID);
    NSLog(@"====>>%@",self.aid);
    
    NSLog(@"===self.UserID=>>%@",self.UserID);
    
    
    if (![self.UserPhone isEqualToString:@"0"]) {
        
        self.phone=self.UserPhone;
        
    }
   // self.good_type=self.Goods_Type_Switch;
    //获取数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@saveUserExchange_mob.shtml",URL_Str];

    if ([self.good_type isEqualToString:@"8"]) {
        url=[NSString stringWithFormat:@"%@healthGoodsSubmitOrder_mob.shtml",URL_Str];
    }

    //saveUserExchange_mob.shtml
    
    NSDictionary *dic=[[NSDictionary alloc] init];
    
    
    NSLog(@"))))))))))))))))%d",isButtonOn);
    
    //判断aid是否为收货地址传过来的
//   if ([self.UserID isEqualToString:@"0"]) {
        
        if (isButtonOn==1) {
            

//            self.ShiYongJiFen=cell1.UseJiFenTF.text;
            
            
            if ([self.UserType isEqualToString:@"888"]) {
                
                self.aid =self.UserID;
            }
            
            
            if ([cell.WordTextField.text isEqualToString:@"选填，有什么小要求在这提醒卖家"]) {
                
                self.YTLiuYan=@"";
                
            }else{
                
                self.YTLiuYan=cell.WordTextField.text;
            }
            
            NSLog(@"=====1===self.ShiYongJiFen====%@===",self.ShiYongJiFen);
            NSLog(@"=====1===self.aid====%@===",self.aid);
            NSLog(@"=====1===number====%@===",[NSString stringWithFormat:@"%ld",(long)_num]);
            NSLog(@"=====1===deductionIntegral====%@===",self.ShiYongJiFen);
            NSLog(@"=====1===self.phone====%@===",self.phone);
            NSLog(@"=====1===self.UserPhone====%@===",self.UserPhone);
            NSLog(@"=====1===self.ID====%@===",self.ID);
            NSLog(@"=====1===self.MoneyType====%@===",self.MoneyType);
            NSLog(@"=====1===cell.WordTextField.text====%@===",cell.WordTextField.text);
//            NSLog(@"=====1===self.ID====%@===",self.ID);
            
            
            //判断是否超出库存
            if ([self.ChaoChuKuCun isEqualToString:@"100"]) {
                
                NSLog(@"=888888888888888888888==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                NSLog(@"=====1===self.phone====%@===",self.phone);
                dic = @{@"sigen":self.sigen,@"number":[NSString stringWithFormat:@"%ld",(long)_num],@"deductionIntegral":self.ShiYongJiFen,@"tmid":@"",@"phone":self.phone,@"gid":self.ID,@"aid":self.aid,@"type":self.MoneyType,@"remark":self.YTLiuYan,@"detailId":self.detailId,@"good_type":self.good_type};
                
            }else if([self.ChaoChuKuCun isEqualToString:@"666"]){
                
                NSLog(@"=caonima=888888888888888888888==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                
                dic = @{@"sigen":self.sigen,@"number":[NSString stringWithFormat:@"%ld",(long)_num],@"deductionIntegral":self.ShiYongJiFen,@"tmid":@"",@"phone":self.phone,@"gid":self.ID,@"aid":self.aid,@"type":self.MoneyType,@"remark":self.YTLiuYan,@"detailId":self.detailId,@"good_type":self.good_type};
                
                
            }else{
                
                NSLog(@"=99999999999999999999999==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                NSLog(@"=====1===self.phone====%@===",self.phone);
                dic = @{@"sigen":self.sigen,@"number":[NSString stringWithFormat:@"%ld",(long)_num],@"deductionIntegral":self.ShiYongJiFen,@"tmid":@"",@"phone":self.phone,@"gid":self.ID,@"aid":self.aid,@"type":self.MoneyType,@"remark":self.YTLiuYan,@"detailId":self.detailId,@"good_type":self.good_type};
            }
            
        }else{
            
            
            if ([cell.WordTextField.text isEqualToString:@"选填，有什么小要求在这提醒卖家"]) {
                
                self.YTLiuYan=@"";
                
            }else{
                
                self.YTLiuYan=cell.WordTextField.text;
            }
            
            self.ShiYongJiFen=@"0";
            
            
            if ([self.UserType isEqualToString:@"888"]) {
                
                self.aid =self.UserID;
            }
            
            
            NSLog(@"=====2===self.ShiYongJiFen====%@===",self.ShiYongJiFen);
            NSLog(@"=====2===self.aid====%@===",self.aid);
            NSLog(@"=====2===self.phone====%@===",self.phone);
            NSLog(@"=====2===self.UserPhone====%@===",self.UserPhone);
            
            //判断是否超出库存
            if ([self.ChaoChuKuCun isEqualToString:@"100"]) {
                NSLog(@"=====1===self.phone====%@===",self.phone);
                NSLog(@"=10101010101001010==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                dic = @{@"sigen":self.sigen,@"number":[NSString stringWithFormat:@"%ld",(long)_num],@"deductionIntegral":self.ShiYongJiFen,@"tmid":@"",@"phone":self.phone,@"gid":self.ID,@"aid":self.aid,@"type":self.MoneyType,@"remark":self.YTLiuYan,@"detailId":self.detailId,@"good_type":self.good_type};
                
            }else if([self.ChaoChuKuCun isEqualToString:@"666"]){
                NSLog(@"=====1===self.phone====%@===",self.phone);
                NSLog(@"=caonima==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                
                dic = @{@"sigen":self.sigen,@"number":[NSString stringWithFormat:@"%ld",_num],@"deductionIntegral":self.ShiYongJiFen,@"tmid":@"",@"phone":self.phone,@"gid":self.ID,@"aid":self.aid,@"type":self.MoneyType,@"remark":self.YTLiuYan,@"detailId":self.detailId,@"good_type":self.good_type};
                
            }else{
                NSLog(@"=====1===self.phone====%@===",self.phone);
                NSLog(@"=12121121212221212112==self.ShiYongJiFen====%@",self.ShiYongJiFen);
                dic = @{@"sigen":self.sigen,@"number":[NSString stringWithFormat:@"%ld",(long)_num],@"deductionIntegral":self.ShiYongJiFen,@"tmid":@"",@"phone":self.phone,@"gid":self.ID,@"aid":self.aid,@"type":self.MoneyType,@"remark":self.YTLiuYan,@"detailId":self.detailId,@"good_type":self.good_type};
            }
        }
    
    
    
    //number商品最后数量
    //deductionIntegral抵扣积分
    //tmid 全部为空
    //gid 上级页面id 商品id
    //
    
    
    
    //    NSDictionary *dic=nil;
    //    NSDictionary *dic = @{@"sigen":@"1210114j701evr567o9pkqf7jr3sfccf3fc24efe42dbb02d577117275e2e7b4093251fb86112c4lvskmh0i3"};
    YLog(@"self.goodtype=%@",self.good_type);
    NSLog(@"dic=%@",dic);
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            //关闭菊花
            [SVProgressHUD dismiss];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"积分支付 + 组合==%@",dic2);
            
            
            
            view.hidden=YES;
            for (NSDictionary *dict1 in dic2) {
                
                NSLog(@"%@",dict1[@"message"]);
                
                self.PayType=dict1[@"type"];
                
                self.Status=dict1[@"status"];
                
                self.message=dict1[@"message"];
                
                self.successurl=dict1[@"successurl"];
                
                self.YTmoney=dict1[@"money"];
                
                //===========支付宝请求参数=======
                
                self.APP_ID = dict1[@"APP_ID"];
                
                self.SELLER = dict1[@"SELLER"];
                
                self.RSA_PRIVAT = dict1[@"RSA_PRIVAT"];
                
                self.Pay_orderno = dict1[@"orderno"];
                
                self.Notify_url = dict1[@"notify_url"];
                
                self.Pay_money = dict1[@"pay_money"];
                
                self.Money_url = dict1[@"money"];
                
                self.Return_url = dict1[@"returnurl"];
                
                self.YTOrderno = dict1[@"order_batchid"];
                
                //==============================

                
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                    
                    //                NSLog(@"使用积分:%@",self.ShiYongJiFen);
                    
                    if ([dict1[@"type"] isEqualToString:@"0"]) {//纯积分
                        

                        
                        [JRToast showWithText:@"兑换成功!" duration:3.0f];
                        
                        
                        DuiHuanSuccessViewController *vc=[[DuiHuanSuccessViewController alloc] init];
                        
//                        JiaoYiNoSendViewController *vc=[[JiaoYiNoSendViewController alloc] init];
                        
                        vc.backType=@"200";
//                        vc.orderno=self.orderno;//传订单号
                        vc.orderno=dict1[@"orderno"];//传订单号
                        
                        vc.sigen=self.sigen;
                        vc.logo=self.logo;
                        vc.storename=self.storename;
                        
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        
                        self.navigationController.navigationBar.hidden=YES;
                        
                        
                        
                    }else if ([dict1[@"type"] isEqualToString:@"2"] && ![dict1[@"money"] isEqualToString:@""] && ![dict1[@"money"] isEqual:null]){//组合支付
                        
//                        QueDingPayViewController *vc=[[QueDingPayViewController alloc] init];
//
//                        vc.orderNo=dict1[@"orderno"];
//                        vc.moneyCom=dict1[@"money"];
//                        vc.successurl=dict1[@"successurl"];
//                        vc.path=self.path;
//                        vc.debitBankJson=self.bankList;

                        
                        //调用支付宝支付
                        
                        [self saveAlipayRecord];
                        
//                        [self.navigationController pushViewController:VC animated:NO];
//                        
//                        self.navigationController.navigationBar.hidden=YES;
                        
                    }else if ([dict1[@"type"] isEqualToString:@"1"]){//金钱支付
                      
                        
                        
                    }
                    
                    
                }else if ([dict1[@"status"] isEqualToString:@"10007"]){
                    

                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                    
                    [alertView show];
                    
                }else if ([dict1[@"status"] isEqualToString:@"10001"]){
                 
//                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//                    
//                    [alertView show];
//
                    
                    [JRToast showWithText:self.message duration:2.0];
                    
                    
                    DuiHuanFailureViewController *vc=[[DuiHuanFailureViewController alloc] init];
                    
                    
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    
                    
                }else if ([dict1[@"status"] isEqualToString:@"10005"]){//系统
                    
                    
                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                    
                    [alertView show];
                    
                    
                }else if ([dict1[@"status"] isEqualToString:@"10003"]){//限购
                    
                    
                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    
                    
                }else if ([dict1[@"status"] isEqualToString:@"10004"]){//限购跳继续付款
                    
                    
                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    alertView.tag=20000;
                    
                    
                    [alertView show];
                    
                    
                }else{
                    
                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                    
                    [alertView show];
                }
                
                
                if ([self.PayType isEqualToString:@"0"]) {
                    
                    self.orderno=dict1[@"orderno"];
                    
                }else{
                    
                    self.money1=dict1[@"money"];
                    self.orderno=dict1[@"orderno"];
                }
            }
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络异常" inView:self.view duration:1 animated:YES];
        
        [self NoWebSeveice];
        
        
        NSLog(@"%@",error);
    }];
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    NSLog(@"3333333333");
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        
        if (buttonIndex==0) {
            
            
            NSLog(@"========");
            
//            YTAddressViewController *vc=[[YTAddressViewController alloc] init];
//            
//            vc.delegate=self;
//            
//            self.navigationController.navigationBar.hidden=YES;
//            
//            [self.navigationController pushViewController:VC animated:NO];
            
        }
    }else if(alertView.tag==20000){
        
        
        if (buttonIndex==0) {
            
            
            NSLog(@"====20000====");
            
            
            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //读取数组NSArray类型的数据
            
            
//            PersonalShoppingDanDetailVC *vc=[[PersonalShoppingDanDetailVC alloc] init];
//            XLDingDanModel *model=[[XLDingDanModel alloc] init];
//            model.order_batchid=self.YTOrderno;
//            vc.myDingDanModel=model;
//            [self.navigationController pushViewController:VC animated:NO];
//            self.navigationController.navigationBar.hidden=YES;

            PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
            [vc selectedDingDanType:@"0" AndIndexType:1];
            PersonalShoppingDanDetailVC *vc2=[[PersonalShoppingDanDetailVC alloc] init];
            XLDingDanModel *model=[[XLDingDanModel alloc] init];
            model.order_batchid=self.YTOrderno;
            vc2.myDingDanModel=model;
            vc2.delegate=vc;
            self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
            [self.navigationController pushViewController:vc2 animated:NO];
        }
        
    }
    

    
    else{
        
        if (buttonIndex==0) {
            //        JiaoYiNoSendViewController *vc=[[JiaoYiNoSendViewController alloc] init];
            //
            //        vc.backType=@"200";
            //        vc.orderno=self.orderno;//传订单号
            //        vc.sigen=self.sigen;
            //        vc.logo=self.logo;
            //        vc.storename=self.storename;
            //
            //        [self.navigationController pushViewController:VC animated:NO];
            //
            //        self.navigationController.navigationBar.hidden=YES;
            
            [self payMoney];
            
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
            [SVProgressHUD showWithStatus:@"请耐心等待..."];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                [SVProgressHUD dismiss];
                
            });
            
            
        }else{
            
            
        }
    }
    
}

-(void)addBtnClick
{
   GetGoodsAddressViewController  *vc=[[GetGoodsAddressViewController alloc] init];
    
    vc.back=@"100";
    
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

//键盘掉下
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    [cell.WordTextField resignFirstResponder];
    [cell1.UseJiFenTF resignFirstResponder];
    [cell.YTNumberTF resignFirstResponder];
}

//NSNotification:  消息的类
/*
 name, object, userInfo
 */
- (void)keyboardWillShow:(NSNotification *)notification andTextField:(UITextField *)textField
{
    NSLog(@"---%@", notification);
    
    //获得键盘的高度
    CGRect rect =  [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    //CGRectValue, 将字符串---> 结构体
    //将结构体转换为字符串
    //NSStringFromCGRect(<#CGRect rect#>)
    
    CGFloat height = rect.size.height;
    
    //将self.view 的y坐标-height
    CGRect frame = _tableView.frame;
    if (frame.origin.y == 0) {
        frame.origin.y = frame.origin.y - height;
        _tableView.frame = frame;
    }
    
}

//当键盘掉下的时候， 会调用这个方法
- (void)keyboardWiilHide:(NSNotification *)notification andTextField:(UITextField *)textField
{
    
    CGRect rect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGFloat height = rect.size.height;
    
    CGRect frame = _tableView.frame;
    
    if (frame.origin.y < 0) {
        frame.origin.y = frame.origin.y + height;
        _tableView.frame = frame;
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [cell.WordTextField resignFirstResponder];
    [cell1.UseJiFenTF resignFirstResponder];
    [cell.YTNumberTF resignFirstResponder];
    
    return YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //获取当前textField的rect
    if ([self.Goods_Type_Switch isEqualToString:@"1"]) {
        
        if (cell1.UseJiFenTF==textField) {
            
            return NO;
        }else{
            
            return YES;
        }
        
    }else{
        
        UsingJiFenCell *cell2 = (UsingJiFenCell *)textField.superview;
        if (kIOSVersions < 8.0) {
            cell2 = (UsingJiFenCell *)textField.superview.superview;
        }
        
        
        
        NSIndexPath *indexPath = [_tableView indexPathForCell:cell2];
        CGRect rectInTableView = [_tableView rectForRowAtIndexPath:indexPath];
        
        
        CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
        NSLog(@"rect==%@", NSStringFromCGRect(rect));//rect.origin.y
        textField_rect =rect;
        
        return YES;
    }
    
}

//键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (_tableView.frame.origin.y+_tableView.frame.size.height) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    //    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSString *sourceStr = self.Pay_orderno;
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
            view.hidden=YES;
            
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
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
    
}




-(void)GoALiPay
{
    
    
    
    [UserMessageManager removeUserWord];
    
    NSLog(@"===self.APP_ID===%@===self.SELLER=%@===self.RSA_PRIVAT=%@==self.Pay_money===%@==self.Pay_orderno===%@==self.Notify_url==%@",self.APP_ID,self.SELLER,self.RSA_PRIVAT,self.Pay_money,self.Pay_orderno,self.Notify_url);
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
    
    NSLog(@"===order.biz_content.subject==%@",order.biz_content.subject);
    
    //    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.out_trade_no = self.Pay_orderno; //订单ID（由商家自行制定）
    
    order.biz_content.timeout_express = @"30m"; //超时时间设置

    order.biz_content.total_amount = [NSString stringWithFormat:@"%.02f", [self.Pay_money floatValue]]; //商品价格
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
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                //读取数组NSArray类型的数据
                
                
                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"0" AndIndexType:2];
                PersonalShoppingDanDetailVC *vc2=[[PersonalShoppingDanDetailVC alloc] init];
                XLDingDanModel *model=[[XLDingDanModel alloc] init];
                model.order_batchid=self.YTOrderno;
                vc2.myDingDanModel=model;
                vc2.delegate=vc;
                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
                [self.navigationController pushViewController:vc2 animated:NO];
                
                
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
                
                [JRToast showWithText:@"正在处理中" duration:2.0f];
                
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
                
                
                [JRToast showWithText:@"订单支付失败" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                PersonalAllDanVC  *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"0" AndIndexType:1];
                PersonalShoppingDanDetailVC *vc2=[[PersonalShoppingDanDetailVC alloc] init];
                XLDingDanModel *model=[[XLDingDanModel alloc] init];
                model.order_batchid=self.YTOrderno;
                vc2.myDingDanModel=model;
                vc2.delegate=vc;
                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
                [self.navigationController pushViewController:vc2 animated:NO];
                [JRToast showWithText:@"用户中途取消" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
                
                [JRToast showWithText:@"网络连接出错" duration:2.0f];
            }

            
        }];
        //
        
        
        
    }
    
    
}

-(void)resultStatus:(NSNotification *)text
{
    
    
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
        
//        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"0" AndIndexType:2];
        PersonalShoppingDanDetailVC *vc2=[[PersonalShoppingDanDetailVC alloc] init];
        XLDingDanModel *model=[[XLDingDanModel alloc] init];
        model.order_batchid=self.YTOrderno;
        vc2.myDingDanModel=model;
        vc2.delegate=vc;
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
        [self.navigationController pushViewController:vc2 animated:NO];
        
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){
        
        [JRToast showWithText:@"正在处理中" duration:2.0f];
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){
        
        
        [JRToast showWithText:@"订单支付失败" duration:2.0f];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"0" AndIndexType:1];
        PersonalShoppingDanDetailVC *vc2=[[PersonalShoppingDanDetailVC alloc] init];
        XLDingDanModel *model=[[XLDingDanModel alloc] init];
        model.order_batchid=self.YTOrderno;
        vc2.myDingDanModel=model;
        vc2.delegate=vc;
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
        [self.navigationController pushViewController:vc2 animated:NO];
        [JRToast showWithText:@"用户中途取消" duration:2.0f];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){
        
        [JRToast showWithText:@"网络连接出错" duration:2.0f];
    }
    
    
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
