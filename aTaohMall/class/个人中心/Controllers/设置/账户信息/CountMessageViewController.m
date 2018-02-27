//
//  CountMessageViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/17.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "CountMessageViewController.h"

#define LayerColor [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor]
#import "HeaderImageCell.h"
#import "CountOtherCell.h"

#import "ChangeMessageViewController.h"//修改QQ
#import "ChangeMessage1ViewController.h"//修改邮箱
#import "ChangeMesssage2ViewController.h"//修改手机

#import "GetGoodsAddressViewController.h"//收货地址

#import "AFNetworking.h"

#import "UIImageView+WebCache.h"

#import "CountMessageModel.h"

#import "UserMessageManager.h"//缓存用户名
#import "NewLoginViewController.h"

//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "ASIFormDataRequest.h"



#import "SexCell.h"
#import "BrithCell.h"
#import "EmailCell.h"
#import "QQCell.h"
#import "PhoneCell.h"
#import "LookAddressCell.h"

#import "WKProgressHUD.h"

#import "XSInfoView.h"

#import "JRToast.h"

#import "YTAddressManngerViewController.h"
@interface CountMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChangeQQDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,ChangeEmailDelegate,ChangePhoneDelegate,UIScrollViewDelegate>
{
//    UITableView *_tableView;
    
    NSMutableArray *_titleArr;
    
////////////////////////////////////////////
    NSData *imageData;
    UIAlertController *alertCon;
    ASIFormDataRequest * _requestUpLoad; //上传头像
    BOOL _isFullScreen;
    NSMutableArray *addImgUrlArr;
    NSString *headUrlStr;
    
//    UIImagePickerController *imagePickerController;
//////////////////////////////////////////////
 
    
    MBProgressHUD *myProgressHum;
    
    NSMutableArray *_UserMessageArrM;//存储用户信息
    
    CountOtherCell *cell2;
    
    SexCell *cell3;
    
    BrithCell *cell4;
    
    NSString *newQQ;
    
    HeaderImageCell *cell1;
    
    EmailCell *cell5;
    
    QQCell *cell6;
    
    PhoneCell *cell7;
    
    LookAddressCell *cell8;
    
    NSString *Path;
    
    NSString *Img_Str;//判断头像上传；
    
    UIView *view;
    
}

@property (nonatomic, strong) NSString *labdate;
@property (nonatomic, strong) NSDate *pickerDate;//上传头像
@end

@implementation CountMessageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    self.tabBarController.tabBar.hidden = YES;
    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    app.myIntegral = @"";
//    app.myKey = @"";
//    app.myPassword = @"";
//    app.myPhone = @"";
//    app.myPhoto = @"";
//    app.mySigen = @"";
//    app.myUserid = @"";
//    
//    app.myIntegral = nil;
//    app.myKey = nil;
//    app.myPassword = nil;
//    app.myPhone = nil;
//    app.myPhoto = nil;
//    app.mySigen = nil;
//    app.myUserid = nil;
    
    //取出缓存数据
    [self readNSUserDefaults];
    
    [[SDImageCache sharedImageCache] cleanDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //初始化
    _titleArr=[NSMutableArray new];
    _UserMessageArrM=[NSMutableArray new];
    
    [self initTableView];
    
     //刷新数据
        [self getDatas];
    
        self.view.frame=[UIScreen mainScreen].bounds;
    
        //获取账户数据
        [self getUserMessage];

    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
               
        
        [hud dismiss:YES];
    });
    
    
    
    imageData = [NSData data];
    
    
//    [self upLoadImage];
    
    // code1
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // code2
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}


-(void)setQQWithString:(NSString *)string
{
    NSLog(@"==QQ==%@",string);
    
//    newQQ=string;
    
     //刷新数据
    [self getUserMessage];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
       
        [hud dismiss:YES];
    });
    
    [_tableView reloadData];
}

-(void)setPhoneWithString:(NSString *)string
{
    NSLog(@"==Phone==%@",string);
    //刷新数据
    [self getUserMessage];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [hud dismiss:YES];
    });
    
    [_tableView reloadData];
}

-(void)setEmailWithString:(NSString *)string
{
    NSLog(@"==Email==%@",string);
    //刷新数据
    [self getUserMessage];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [hud dismiss:YES];
    });
    
    [_tableView reloadData];
}
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;

    _tableView.estimatedRowHeight=44;
    _tableView.estimatedSectionHeaderHeight=10;
    _tableView.estimatedSectionFooterHeight=0.01;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _tableView.separatorColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0];
    
    [self.view addSubview:_tableView];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"HeaderImageCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CountOtherCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"SexCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"BrithCell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"EmailCell" bundle:nil] forCellReuseIdentifier:@"cell5"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"QQCell" bundle:nil] forCellReuseIdentifier:@"cell6"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"PhoneCell" bundle:nil] forCellReuseIdentifier:@"cell7"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"LookAddressCell" bundle:nil] forCellReuseIdentifier:@"cell8"];
}

-(void)getDatas
{
    NSArray *array0=@[@"1",@"用户名",@"性别",@"生日",@"邮箱",@"QQ",@"手机"];

  //  NSArray *array1=@[@"收货地址"];

    
    [_titleArr addObject:@{@"array":array0}];
   // [_titleArr addObject:@{@"array":array1}];
}

-(void)getUserMessage
{
    
//    [_UserMessageArrM removeAllObjects];
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    
//    [userDefaultes removeObjectForKey:@"header"];
    //读取数组NSArray类型的数据
    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    [_tableView reloadData];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getAccountInfo_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigens};
    
//    NSLog(@"-------------------------------------------%@",self.sigens);
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
                for (NSDictionary *dict2 in dict1[@"list"]) {
                    CountMessageModel *model=[[CountMessageModel alloc] init];
                    NSString *address=dict2[@"address"];
                    NSString *birthday=dict2[@"birthday"];
                    NSString *email=dict2[@"email"];
                    NSString *id=dict2[@"id"];
                    
                    _userID=dict2[@"id"];
                    
                    
                    NSString *phone=dict2[@"phone"];
                    NSString *portrait=dict2[@"portrait"];
                    NSString *qq=dict2[@"qq"];
                    NSString *sex=dict2[@"sex"];
                    NSString *username=dict2[@"username"];
                    
//                    NSLog(@"========%@",portrait);
                    
                    model.address=address;
                    model.birthday=birthday;
                    model.email=email;
                    model.id=id;
                    model.phone=phone;
                    model.portrait=portrait;
                    model.qq=qq;
                    model.sex=sex;
                    model.username=username;
                    
                    [_UserMessageArrM addObject:model];
                    
                    [_tableView reloadData];
                }
            }
            
            [_tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        NSLog(@"%@",error);
        [self NoWebSeveice];
        
    }];
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
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict=_titleArr[section];
    NSArray *array=dict[@"array"];
    
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0) {
        return 80;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 && indexPath.section==0) {
        
        cell1=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        NSNull *null=[[NSNull alloc] init];
        //获取头像
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        //图片切成圆形
        cell1.headerImageView.layer.masksToBounds=YES;
        cell1.headerImageView.layer.cornerRadius=30;
        
        for (CountMessageModel *model in _UserMessageArrM) {
            
            if ([model.portrait isEqual:null] || [model.portrait isEqualToString:@""]) {
                
                cell1.headerImageView.image=[UIImage imageNamed:@"头像"];
                
            }else{
                
                [cell1.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.portrait]];
            }
        }
        cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
        return cell1;
    }else if (indexPath.section==0 && indexPath.row==1){
        
        cell2=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        for (CountMessageModel *model in _UserMessageArrM) {
            
          cell2.MessageLabel.text=model.username;
        }
        
        return cell2;
    }else if (indexPath.section==0 && indexPath.row==2){
        
        cell3=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
        cell3.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        for (CountMessageModel *model in _UserMessageArrM) {
           
            
            if ([model.sex isEqual:@"0"]) {
                
                cell3.MessageLabel.text=@"女";
                
            }else if ([model.sex isEqual:@"1"]){
                
                cell3.MessageLabel.text=@"男";
                
            }else if ([model.sex isEqual:@"2"]){
                
                cell3.MessageLabel.text=@"保密";
                
            }else{
                
                cell3.MessageLabel.text=@"请选择";
            }
            
        }
        return cell3;
        
    }else if (indexPath.section==0 && indexPath.row==3){
        NSNull *null=[[NSNull alloc] init];
        cell4=[tableView dequeueReusableCellWithIdentifier:@"cell4"];
        cell4.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        for (CountMessageModel *model in _UserMessageArrM) {
            
            if ([model.birthday isEqual:null] || [model.birthday isEqualToString:@""]) {
                
                cell4.MessageLabel.text=@"请设置";
            }else{
                
                cell4.MessageLabel.text=model.birthday;
            }
            
        }
        return cell4;
    }else if (indexPath.section==0 && indexPath.row==4){
        NSNull *null=[[NSNull alloc] init];
        cell5=[tableView dequeueReusableCellWithIdentifier:@"cell5"];
        cell5.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        for (CountMessageModel *model in _UserMessageArrM) {
           
            if ([model.email isEqual:null] || [model.email isEqualToString:@""]) {
                
                cell5.MessageLabel.text=@"请输入";
            }else{
                
                self.EmailString=model.email;
                
                cell5.MessageLabel.text=model.email;
            }
        }
        
        return cell5;
    }else if (indexPath.section==0 && indexPath.row==5){
        
        NSNull *null=[[NSNull alloc] init];
        cell6=[tableView dequeueReusableCellWithIdentifier:@"cell6"];
        cell6.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
        cell6.selectionStyle = UITableViewCellSelectionStyleNone;
        for (CountMessageModel *model in _UserMessageArrM) {
            
            if ([model.qq isEqual:null] || [model.qq isEqualToString:@""]) {
                
                cell6.MessageLabel.text=@"请输入";
            }else{
                
                self.QQString=model.qq;
                
                NSLog(@"MMMMMMMMMMMMMM%@",model.qq);
                cell6.MessageLabel.text=model.qq;
            }

        }
        
        return cell6;
    }else if (indexPath.section==0 && indexPath.row==6){
        NSNull *null=[[NSNull alloc] init];
        cell7=[tableView dequeueReusableCellWithIdentifier:@"cell7"];
        cell7.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
        cell7.selectionStyle = UITableViewCellSelectionStyleNone;
        for (CountMessageModel *model in _UserMessageArrM) {
            if ([model.phone isEqual:null] || [model.phone isEqualToString:@""]) {
                
                
                cell7.MessageLabel.text=@"请输入";
                
            }else{
                
                self.PhoneString=model.phone;
                
                cell7.MessageLabel.text=model.phone;
            }
        }
        return cell7;
    }else{
        
        cell8=[tableView dequeueReusableCellWithIdentifier:@"cell8"];
        cell8.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
        cell8.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell8;
    }
//    cell2=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
//    cell3=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
//    NSDictionary *dict=_titleArr[indexPath.section];
//    NSArray *array=dict[@"array"];
//    
//    NSString *str=array[indexPath.row];
//    
//    cell2.NameLabel.text=str;
    
//    for (CountMessageModel *model in _UserMessageArrM) {
//        
//        newQQ=model.qq;
//        
//        if (indexPath.section==0 && indexPath.row==1) {
//            
//            cell2.MessageLabel.text=model.username;
//        }else if (indexPath.section==0 && indexPath.row==2){
//            if ([model.sex isEqual:@"0"]) {
//                cell3.MessageLabel.text=@"女";
//            }else if ([model.sex isEqual:@"1"]){
//                cell3.MessageLabel.text=@"男";
//            }else if ([model.sex isEqual:@"2"]){
//                cell3.MessageLabel.text=@"保密";
//            }
//            
//            return cell3;
//        }else if (indexPath.section==0 && indexPath.row==3){
//            
//            
//            if ([model.birthday isEqual:null] || [model.birthday isEqualToString:@""]) {
//                
//            }else{
//                
//                cell2.MessageLabel.text=model.birthday;
//            }
//        }else if (indexPath.section==0 && indexPath.row==4){
//            
//            if ([model.email isEqual:null] || [model.email isEqualToString:@""]) {
//                
//            }else{
//                
//                self.EmailString=model.email;
//                
//                cell2.MessageLabel.text=model.email;
//            }
//            
//        }else if (indexPath.section==0 && indexPath.row==5){
//            if ([model.qq isEqual:null] || [model.qq isEqualToString:@""]) {
//                
//            }else{
//                
//                self.QQString=newQQ;
//                
//                cell2.MessageLabel.text=newQQ;
//            }
//            
//        }else if (indexPath.section==0 && indexPath.row==6){
//            
//            cell2.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
//            if ([model.phone isEqual:null] || [model.phone isEqualToString:@""]) {
//                
//            }else{
//                
//                self.PhoneString=model.phone;
//                
//                cell2.MessageLabel.text=model.phone;
//            }
//            
//            return cell2;
//            
//        }
//    }
//    
//    
//    if (!(indexPath.section==0 && indexPath.row==1)) {
//        cell2.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
//    }
//    
//    return cell2;
}

//headerView 的高度;
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

//footerView 高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000000001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
//实现反向传值方法
-(void)setLabelWithString:(NSString *)string
{
    self.getString=string;
//    NSLog(@"=====%@",self.getString);
    
    
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0) {
//        [self showActionSheet1];
        
        
        //创建UIAlertController是为了让用户去选择照片来源,拍照或者相册.
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action)
                                       {
                                           //这里可以不写代码
                                       }];
        [self presentViewController:alertController animated:YES completion:nil];
        
        //用来判断来源 Xcode中的模拟器是没有拍摄功能的,当用模拟器的时候我们不需要把拍照功能加速
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            
        {
            
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            [alertController addAction:photoAction];
            
        }
        
        else
        {
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
        }
        
    }else if(indexPath.section==0 && indexPath.row==1){
        
        
        [JRToast showWithText:@"用户名作为登录账号不能更改!" duration:3.0f];
        
//        XSInfoViewStyle *style = [[XSInfoViewStyle alloc] init];
//        style.info = @"用户名作为登录账号不能更改!";
//
//        style.layoutStyle = XSInfoViewLayoutStyleHorizontal;
//        
//        [XSInfoView showInfoWithStyle:style onView:self.view];
        
        
        
        
    }else if (indexPath.section==0 && indexPath.row==2){
        [self showActionSheet2];
    }else if(indexPath.section==0 && indexPath.row==3){
        if (self.backgroundView == nil) {
            UIView *dateBackView = [[UIView alloc]init];
            dateBackView.frame = CGRectMake(40, 150, self.view.frame.size.width-80, self.view.frame.size.height/2 - 30);
            dateBackView.backgroundColor = [UIColor whiteColor];
            //dateBackView.alpha = 0;
            dateBackView.layer.cornerRadius = 5;
            dateBackView.layer.borderColor = LayerColor;
            dateBackView.layer.borderWidth = 0.5;
            dateBackView.layer.shadowColor = [UIColor grayColor].CGColor;
            dateBackView.layer.shadowOffset = CGSizeMake(3, 3);
            dateBackView.layer.shadowOpacity = 0.5;
            dateBackView.layer.shadowRadius = 4.0;
            dateBackView.clipsToBounds = NO;
            
            [self.view addSubview:dateBackView];
            
            
            
            
            
            //日期选择器
            self.birthPicker = [[UIDatePicker alloc]init];
            self.birthPicker.frame = CGRectMake(0, 30, dateBackView.frame.size.width, dateBackView.frame.size.height-60);
            self.birthPicker.backgroundColor = [UIColor whiteColor];
            self.birthPicker.alpha = 0.8;
            //设置datePicker的滑动监听
            [self.birthPicker addTarget:self action:@selector(pickerChanged) forControlEvents:UIControlEventValueChanged];
            
            
            [dateBackView addSubview:self.birthPicker];
            //设置中文
            NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            self.birthPicker.locale = locale;
            //模式只显示日期
            self.birthPicker.datePickerMode = UIDatePickerModeDate;
            
            CGFloat minbpY = CGRectGetMinY(self.birthPicker.frame);
            CGFloat maxbpY = CGRectGetMaxY(self.birthPicker.frame);
            
            
            
            self.showLabel = [[UILabel alloc]init];
            self.showLabel.frame = CGRectMake(0, 0, dateBackView.frame.size.width,minbpY);
            self.showLabel.textAlignment = NSTextAlignmentCenter;
            self.showLabel.textColor = [UIColor blackColor];
            self.showLabel.font = [UIFont fontWithName:@"Arial" size:16.f];
            [dateBackView addSubview:self.showLabel];
            
            self.showLabel.text = self.labdate;
            
            CGFloat maxslY = CGRectGetMaxY(self.showLabel.frame);
            
            //直线
            UIView *strightLine = [[UIView alloc]init];
            strightLine.frame = CGRectMake(20, maxslY, dateBackView.frame.size.width - 40, 2);
            strightLine.backgroundColor = [UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0];
            [dateBackView addSubview:strightLine];
            
            
            
            //完成按钮
            UIButton *finshBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,maxbpY,dateBackView.frame.size.width,dateBackView.frame.size.height - maxbpY)];
            finshBtn.backgroundColor = [UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0];
            [finshBtn setTitle:@"完成" forState:UIControlStateNormal];
            finshBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [finshBtn addTarget:self action:@selector(getDate) forControlEvents:UIControlEventTouchUpInside];
            [dateBackView addSubview:finshBtn];
            //设置只有两个角变圆滑
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:finshBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = finshBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            finshBtn.layer.mask = maskLayer;
            
            self.backgroundView = dateBackView;
            
        }else{
            
            [self.backgroundView removeFromSuperview];
            self.backgroundView = nil;
        }
    }else if (indexPath.section==0 && indexPath.row==5){
        ChangeMessageViewController *vc=[[ChangeMessageViewController alloc] init];

        vc.delegate=self;
        
        vc.ChangeString=self.QQString;
        
        
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
    }else if (indexPath.section==0 && indexPath.row==4){
        ChangeMessage1ViewController *vc=[[ChangeMessage1ViewController alloc] init];
        
        vc.delegate=self;
        
        vc.ChangeString=self.EmailString;
        
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
    }else if (indexPath.section==0 && indexPath.row==6){
        ChangeMesssage2ViewController *vc=[[ChangeMesssage2ViewController alloc] init];
        

        vc.delegate=self;
        
        vc.ChangeString=self.PhoneString;
        
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
    }else if (indexPath.section==1 && indexPath.row==0){
        
//        GetGoodsAddressViewController *vc=[[GetGoodsAddressViewController alloc] init];
        
        YTAddressManngerViewController *vc =[[YTAddressManngerViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
    }
    
}

- (void)pickerChanged
{
    
    NSDate *birLabelDate = [self.birthPicker date];
    NSDateFormatter *pickerFormatter1 = [[NSDateFormatter alloc]init];
    [pickerFormatter1 setDateFormat:@"yyyy年MM月dd日 EEEE"];
    NSString *dateString = [pickerFormatter1 stringFromDate:birLabelDate];
    self.showLabel.text = dateString;
    self.labdate = dateString;
    //
//    self.BirthString=dateString;
    
//   NSLog(@"==========%@",self.BirthString);
    
}

-(void)CancleBtnClick
{
    
}

- (void)getDate
{
    
    NSDateFormatter *pickerFormatter2 = [[NSDateFormatter alloc ]init];
    [pickerFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString2 = [pickerFormatter2 stringFromDate:[self.birthPicker date]];
    self.findate = dateString2;
    self.BirthString=dateString2;
    NSLog(@"==========%@",self.BirthString);
//    [self.dateBtn setTitle:[NSString stringWithFormat:@"%@",self.findate] forState:UIControlStateNormal];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@updateAccountInfo_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigens,@"birthday":self.BirthString,@"type":@"3"};
    
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
                    
                    [self getUserMessage];
                }else{
                    
                    [JRToast showWithText:@"生日修改失败!" duration:1.0f];
                }
            }
            
            //刷新数据
//                [self getUserMessage];
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                
                [hud dismiss:YES];
            });
            
            [_tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self NoWebSeveice];
        
    }];
    
    
//    [self getDate];
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    //刷新数据
    [_tableView reloadData];
}

//头像
-(void)showActionSheet1
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择",nil];
    
    sheet.tag=20;
    
    [sheet showInView:self.view];
}
//性别
-(void)showActionSheet2
{
 
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女",@"保密",nil];
    sheet.tag=10;
    
    [sheet showInView:self.view];

}
#pragma mark - actionSheet代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==20) {
        if (buttonIndex==0) {
//            NSLog(@"0");
            UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
            pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            //设置代理
            pickerCtrl.delegate = self;
            
            //可编辑
            pickerCtrl.allowsEditing = YES;
            
            
            //切换到pikerCtr
            [self presentViewController:pickerCtrl animated:YES completion:nil];
            
        }else if (buttonIndex==1){
//            NSLog(@"1");
            
            UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
            pickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;;
            
            //设置代理
            pickerCtrl.delegate = self;
            
            //可编辑
            pickerCtrl.allowsEditing = YES;
            
            //切换到pikerCtr
            [self presentViewController:pickerCtrl animated:YES completion:nil];
        }
    }else if (actionSheet.tag==10){
        
        
        
        
        if (buttonIndex==0) {
            self.SexString=@"1";
            
//            //刷新数据
            cell2.MessageLabel.text=@"女";
                //刷新数据
//                [self getUserMessage];
            
            [self ChangeSex];
            
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
               
                [hud dismiss:YES];
            });
            
            [_tableView reloadData];
            
        }else if (buttonIndex==1){
            self.SexString=@"0";
            
//            //刷新数据
//            [self getUserMessage];
            
            [self ChangeSex];
            
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                
                [hud dismiss:YES];
            });
            
            [_tableView reloadData];
        }else if(buttonIndex==2){
            self.SexString=@"2";
            
//            //刷新数据
//            [self getUserMessage];
            
            [self ChangeSex];
            
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                
                [hud dismiss:YES];
            });
            
            [_tableView reloadData];
        }
        
        
//        [self getUserMessage];
        
    }
}

//修改性别
-(void)ChangeSex
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@updateAccountInfo_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigens,@"sex":self.SexString,@"type":@"2"};
    
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
                    
                    [self getUserMessage];
                    
                }else{
                    
                    [JRToast showWithText:@"性别修改失败!" duration:1.0f];
                }
            }
            [_tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self NoWebSeveice];
        
    }];
    
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
   // self.tabBarController.tabBar.hidden=NO;
}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    [_tableView reloadData];
//    NSLog(@"UserName======%@",self.sigens);
}



////这个是选取完照片后要执行的代理方法
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    //选取裁剪后的图片
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    /* 此处info 有六个值
//     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
//     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
//     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
//     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
//     * UIImagePickerControllerMediaURL;       // an NSURL
//     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
//     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
//     */
//    
//    
//    
////    cell1.headerImageView.image=image;
//    
//    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSLog(@"=============%@",path);
//    
//    NSData *data;
//    
//    if (UIImagePNGRepresentation(image) == nil) {
//        
//        data = UIImageJPEGRepresentation(image, 1);
//        
//    } else {
//        
//        data = UIImagePNGRepresentation(image);
//        
//    }
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"image"];         //将图片存储到本地documents
//    
//    
//    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
//    
//    [fileManager createFileAtPath:[filePath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
//    
//    
////    NSString *img=[NSString stringWithFormat:@"image%0d",arc4random()%10];
////    
////    Path=[NSString stringWithFormat:@"%@.png",img];
//    
//    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/image/%@.png",NSHomeDirectory(),@"image"];
//    
//    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
//    
//    NSLog(@"======》》%@",aPath3);
//    
//    
//    cell1.headerImageView.image = imgFromUrl3;
//    
//    [_tableView reloadData];
//    
//}

- (void)saveImage:(UIImage *)img withName:(NSString *)imageName{
    
    imageData = UIImageJPEGRepresentation(img, 0.5);
    
    NSLog(@"======imageData======%@",imageData);
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    NSLog(@"====fullPath====%@",fullPath);
    
    
    [imageData writeToFile:fullPath atomically:NO];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //UIImagePickerControllerOriginalImage; //原图
    //UIImagePickerControllerEditedImage;//裁剪的图
    //UIImagePickerControllerCropRect;//获取图片裁剪后 剩下的图
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSLog(@"======image======%@",image);
    [self saveImage:image withName:@"img.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"img.png"];
    
    
    NSLog(@"====fullPath====%@",fullPath);
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    imageData = UIImageJPEGRepresentation(image, 0.5);
    
    NSLog(@"========%@",savedImage);
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    app.imagedata = imageData;
    
    
    [self upLoadImage];
}


- (void)upLoadImage{
    
    
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    _requestUpLoad = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://image.anzimall.com:8089/fileUpload/p/file!upload"]];
    
    NSLog(@"====_requestUpLoadh====%@",_requestUpLoad);
    
    _requestUpLoad.delegate = self;
    
    
    NSLog(@"======app.myKey====%@",app.myKey);
    
    app.myKey=self.sigens;
    
    [_requestUpLoad addPostValue:app.myKey forKey:@"key"];
    
    
    NSString *i;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    NSLog(@"====user====%@",user);
    
    if ([user objectForKey:@"headUrlName"] == NULL) {
        
        i = @"1";
    }else{
        i = [NSString stringWithFormat:@"%@",[user objectForKey:@"headUrlName"]];
        
    }
    
    NSString *imgName = [NSString stringWithFormat:@"img%@.png",i];
    
    
    NSLog(@"====imgName====%@",imgName);
    
    [_requestUpLoad addData:imageData withFileName:imgName andContentType:@"image/png" forKey:@"img"];
    [_requestUpLoad startAsynchronous];
    
    i = [NSString stringWithFormat:@"%d",[i intValue]+1];
    
    NSLog(@"====i====%@",i);
    
    [user setObject:i forKey:@"headUrlName"];
    
    Img_Str=@"100";
    
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    if ([Img_Str isEqualToString:@"100"]) {
       
        headUrlStr = [request.responseString substringFromIndex:2];
        
        self.headerImage=headUrlStr;
        
        NSRange range1=[headUrlStr rangeOfString:@"com"];
        
        NSString *Imgurl=[headUrlStr substringFromIndex:range1.location+3];
        
        NSLog(@"===url====%@",Imgurl);
        
        
        NSLog(@"===headUrlStr=====%@",headUrlStr);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"头像上传成功，请点击确认修改进行保存" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: (UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            NSLog(@"IEv看明白了没老板娘吗老娘们l");
            
            NSLog(@"====self.sigen===%@",self.sigens);
            
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            NSString *url = [NSString stringWithFormat:@"%@updateAccountInfo_mob.shtml",URL_Str];
            
            NSDictionary *dic = @{@"sigen":self.sigens,@"portrait":Imgurl,@"type":@"1"};
            
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
                            
                            //刷新数据
                            [self getUserMessage];
                            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
                            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
                            dispatch_after(time, dispatch_get_main_queue(), ^{
                                
                                if (_delegate && [_delegate respondsToSelector:@selector(changeImageWithHeader:)]) {
                                    
                                    [_delegate changeImageWithHeader:self.headerImage];
                                    
                                }
                               
                                [hud dismiss:YES];
                            });
                        }
                    }
                    
                    [_tableView reloadData];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
                NSLog(@"%@",error);
        
                [self NoWebSeveice];
                
            }];
            
        }]];
        
        [self presentViewController: alertCon animated: YES completion: nil];
        
        // 上传成功的回调
        NSDictionary * _dic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"ooooooooooooooooooooooo%@",_dic);
        
    }

}
- (void)requestStarted:(ASIHTTPRequest *)request{
    myProgressHum = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //NSLog(@"开始上传");
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传失败，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: (UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        NSLog(@"IEv看明白了没老板娘吗老娘们l");
        
        [self presentViewController: alertCon animated: YES completion: nil];
    }]];
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _isFullScreen = !_isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = cell1.headerImageView.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +cell1.headerImageView.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+cell1.headerImageView.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (_isFullScreen) {
            // 放大尺寸
            cell1.headerImageView.layer.cornerRadius=0;
            cell1.headerImageView.frame = CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.width-64);
        }
        else {
            // 缩小尺寸
 //           cell1.headerImageView.frame = CGRectMake(100, 90, 120, 120);
            cell1.headerImageView.layer.cornerRadius=40;
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
    
    
}





@end
