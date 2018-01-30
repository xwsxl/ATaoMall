//
//  ATHBreakRulesViewController.m
//  违章查询
//
//  Created by JMSHT on 2017/7/26.
//  Copyright © 2017年 yt. All rights reserved.
//

#import "ATHBreakRulesViewController.h"

#import "ATHBreakRulesUpImgViewController.h"

#import "ATHBreakPayCenterViewController.h"

#import "PeccancecyInfoModel.h"

#import "PecOrderModel.h"

#import "ServiceVC.h"

@interface ATHBreakRulesViewController ()<UITextFieldDelegate>
{
    
    UITextField *NameTF;
    
    UITextField *PhoneTF;
    
    UITextField *DriveTF;
    
    UITextField *FilesTF;
    
    UIScrollView *_scrollerView;
    
    NSMutableArray *peccArr;
    NSMutableArray *peccNoArr;
    UIImageView *TipIV;
    PecOrderModel *orderModel;
    UIControl *huiseControl;
    UIView *plateTipsView;
    
    UIWebView *webView;
    UIView *loadView;
    
    NSInteger shiftHeight;
    
}
@end

@implementation ATHBreakRulesViewController

/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    
    //创建导航栏
    [self initNav];
    
    if (!_scrollerView) {
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-49-KSafeAreaBottomHeight)];
   
    
    [self.view addSubview:_scrollerView];
    }
    //蓝色说明
    [self initBlueView];
    
    //个人信息
    [self initUserMessageView];
    
  _scrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50+240+5+22+shiftHeight);
    
    //提交按钮
    [self initPayView];
    
  //  [self showPayTips];
    
}
/*******************************************************      数据请求       ******************************************************/
/*****
 *
 *  Description 数据数组
 *
 ******/
-(void)setDataArr:(NSArray *)dataArr
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _dataArr=dataArr;
        if (!peccNoArr) {
            peccNoArr=[NSMutableArray array];
        }
        if (!peccArr) {
            peccArr=[NSMutableArray array];
        }
        [peccNoArr removeAllObjects];
        [peccArr removeAllObjects];
        for (PeccancecyInfoModel *model in _dataArr) {
            if ([model.type isEqualToString:@"0"]) {
                
                if ([model.canHandle isEqualToString:@"true"]) {
                    [peccArr addObject:model];
                }else
                {
                    [peccNoArr addObject:model];
                }
            }
        }
        NSLog(@"peccArr=%@,peccNoArr=%@",peccArr,peccNoArr);
        dispatch_async(dispatch_get_main_queue(), ^{
            //可缴费违章
            [self initCanPayView];
            
            //不支持违章
            [self initCanotPayView];
            _scrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50+240+5+22+shiftHeight);
        });
    });
    
    
    
}

//提交
-(void)PayBtnCLick
{
    if (![self personInfoIsCorrect]) {
        return;
    }
    NSMutableArray *selectArr=[[NSMutableArray alloc]init];
    for (int i=0; i<peccArr.count; i++) {
        UIButton *but=(UIButton *)[self.view viewWithTag:i+10];
        if (but.selected==YES) {
            PeccancecyInfoModel *model=peccArr[i];
            [selectArr addObject:model];
        }
        
    }
    if (selectArr.count==0) {
        [TrainToast showWithText:@"请至少选择一条需要缴费的违章记录" duration:1.0];
        return;
    }
    
    
    CGRect frame = CGRectMake(0, 65+60, 80, 80);
    frame.size = [UIImage imageNamed:@"ring-alt(1).gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ring-alt(1)" ofType:@"gif"]];
    // view生成
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-frame.size.width)/2, ([UIScreen mainScreen].bounds.size.height-frame.size.height)/2, frame.size.width, frame.size.height)];
    
    webView.backgroundColor = [UIColor clearColor];
    [webView setOpaque:NO];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@illegalSubmitOrder_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    NSMutableArray *arr=[NSMutableArray new];
    for (PeccancecyInfoModel *model in selectArr) {
        NSDictionary *dic=@{@"time":model.PeccancecyTimeStr,@"fine":model.PeccancecyFineStr,@"cityName":model.city,@"recordId":model.peccID,@"behavior":model.behavior,@"canHandle":model.canHandle,@"serviceFee":model.serviceFee,@"deductPointType":model.deductPointType,@"code":model.PeccancecyTypeStr,@"zhinajin":model.zhiNaJin,@"address":model.PeccancecyPlaceStr,@"deductPoint":model.PeccancecyDecuteMarksStr};
        [arr addObject:dic];
    }
    PeccancecyInfoModel *model=peccArr.firstObject;
    NSDictionary *allData=@{@"carNo":model.PlateNumberStr,@"contactName":NameTF.text,@"tel":PhoneTF.text,@"dirNo":DriveTF.text,@"dirFileNo":FilesTF.text,@"clientId":@"3",@"endorsement":[arr copy]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allData options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *str=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *param=@{@"sigen":[[NSUserDefaults standardUserDefaults] objectForKey:@"sigen"],@"all_data":str};
    NSLog(@"param=%@",param);
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic=%@",dic);
            
            if ([dic[@"status"] isEqualToString:@"10000"])
            {
                
                orderModel=[[PecOrderModel alloc]init];
                orderModel.orderNo=[NSString stringWithFormat:@"%@",dic[@"orderno"]];
                orderModel.userIntegral=[NSString stringWithFormat:@"%@", dic[@"userIntegral"]];
                orderModel.deductionIntegral=[NSString stringWithFormat:@"%@",dic[@"deduction_integral"]];
                orderModel.fineMoney=[NSString stringWithFormat:@"%@",dic[@"fine_money"]];
                orderModel.lateMoney=[NSString stringWithFormat:@"%@",dic[@"late_money"] ];
                orderModel.serviceFee=[NSString stringWithFormat:@"%@",dic[@"service_fee"]];
                if (webView.superview!=nil) {
                    [webView removeFromSuperview];
                }
                if (loadView.superview!=nil) {
                    [loadView removeFromSuperview];
                }
                if (![[NSString stringWithFormat:@"%@",dic[@"files"]] isEqualToString:@""]) {
                    
                    
                    ATHBreakRulesUpImgViewController *vc=[[ATHBreakRulesUpImgViewController alloc]init];
                    vc.papersType=dic[@"papersType"];
                    vc.orderModel=orderModel;
                    vc.count=[NSString stringWithFormat:@"%ld",selectArr.count];
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    self.navigationController.navigationBar.hidden = YES;
                    
                }else{
                    
                    ATHBreakPayCenterViewController *vc=[[ATHBreakPayCenterViewController alloc]init];
                    // ATHBreakRulesUpImgViewController *vc = [[ATHBreakRulesUpImgViewController alloc] init];
                    vc.orderModel=orderModel;
                    vc.count=[NSString stringWithFormat:@"%ld",selectArr.count];
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    self.navigationController.navigationBar.hidden = YES;
                }
            }
            else if([dic[@"status"] isEqualToString:@"10005"])
            {
                if (webView.superview!=nil) {
                    [webView removeFromSuperview];
                }
                if (loadView.superview!=nil) {
                    [loadView removeFromSuperview];
                }
                [TrainToast showWithText:dic[@"message"] duration:3.0];
            }
            else
            {
                if (webView.superview!=nil) {
                    [webView removeFromSuperview];
                }
                if (loadView.superview!=nil) {
                    [loadView removeFromSuperview];
                }

                UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:dic[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                } ];
                [alert addAction:action];
                [self presentViewController:alert animated:NO completion:nil];
                
                
            }
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (webView.superview!=nil) {
            [webView removeFromSuperview];
        }
        if (loadView.superview!=nil) {
            [loadView removeFromSuperview];
        }
        
        [TrainToast showWithText:@"请求失败" duration:1.0];
        NSLog(@"shibai");
    }];
    
    
    
}
/*******************************************************      初始化视图       ******************************************************/
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
    
    label.text = @"违章缴费";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    //服务说明
    UIButton *Show = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Show.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-75, 25+KSafeTopHeight, 60, 30);
    
    [Show setTitle:@"服务说明" forState:0];
    
    [Show setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    
    Show.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    
    [Show addTarget:self action:@selector(ShowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Show];
    
}

//蓝色说明
-(void)initBlueView
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    view.backgroundColor = [UIColor colorWithRed:63/255.0 green:139/255.0 blue:253/255.0 alpha:1.0];
    [_scrollerView addSubview:view];
    NSString *str=@"因信息填写错误或已提交过的订单擅自再去缴费而造成的损失自行承担。本平台不收取任何费用，若可缴费违章中有服务费则是第三方平台代办费用。";
    CGSize size=[str sizeWithFont:KNSFONT(11) maxSize:CGSizeMake(kScreen_Width-36-15, 50)];

    
    UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (50-size.height)/2+3, 13, 13)];
    ImgView.image = [UIImage imageNamed:@"icon_hint"];
    [view addSubview:ImgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(34, (50-size.height)/2, size.width, size.height+2)];
    label.text  = str;
    label.textColor = [UIColor whiteColor];
    label.font = KNSFONT(11);
    label.numberOfLines = 0;
    [view addSubview:label];
    
    
}

//个人信息
-(void)initUserMessageView
{
    UIView *PersonView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 240)];
    
    [_scrollerView addSubview:PersonView];
    
    
    UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 84)];
    [PersonView addSubview:NameView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, 100, 13)];
    label.text  = @"个人信息";
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [NameView addSubview:label];
    
    UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 52, 100, 13)];
    NameLabel.text  = @"车主姓名";
    NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [NameView addSubview:NameLabel];
    
    NameTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 52, [UIScreen mainScreen].bounds.size.width-100, 15)];
    NameTF.placeholder = @"请填写车主真实姓名";
    NameTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    NameTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    NameTF.delegate=self;
    NameTF.keyboardType=UIReturnKeyDone;
    [NameView addSubview:NameTF];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 83, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [NameView addSubview:line];
    
    
    UIView *PhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, [UIScreen mainScreen].bounds.size.width, 52)];
    [PersonView addSubview:PhoneView];
    
    UILabel *PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 13)];
    PhoneLabel.text  = @"手机号码";
    PhoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PhoneLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [PhoneView addSubview:PhoneLabel];
    
    PhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 20, [UIScreen mainScreen].bounds.size.width-100, 15)];
    PhoneTF.placeholder = @"便于及时了解处理进度";
    PhoneTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    PhoneTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    PhoneTF.delegate=self;
    PhoneTF.keyboardType=UIReturnKeyDone;
    [PhoneView addSubview:PhoneTF];
    
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, [UIScreen mainScreen].bounds.size.width, 1)];
    line4.image = [UIImage imageNamed:@"分割线-拷贝"];
    [PhoneView addSubview:line4];
    
    UIView *DriveView = [[UIView alloc] initWithFrame:CGRectMake(0, 84+52, [UIScreen mainScreen].bounds.size.width, 52)];
    [PersonView addSubview:DriveView];
    
    UILabel *DriveLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 13)];
    DriveLabel.text  = @"驾驶证号";
    DriveLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    DriveLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [DriveView addSubview:DriveLabel];
    
    DriveTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 20, [UIScreen mainScreen].bounds.size.width-100, 15)];
    DriveTF.placeholder = @"请填写车主本人驾驶证号";
    DriveTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    DriveTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    DriveTF.delegate=self;
    DriveTF.keyboardType=UIReturnKeyDone;
    [DriveView addSubview:DriveTF];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [DriveView addSubview:line2];
    
    UIButton *DriveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    DriveButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-17-15, 18, 17, 17.5);
    [DriveButton setImage:[UIImage imageNamed:@"icon_hint2"] forState:0];
    DriveButton.tag=1;
    [DriveButton addTarget:self action:@selector(DriveBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    [DriveView addSubview:DriveButton];
    
    UIView *FilesView = [[UIView alloc] initWithFrame:CGRectMake(0, 84+52+52, [UIScreen mainScreen].bounds.size.width, 52)];
    [PersonView addSubview:FilesView];
    
    UILabel *FilesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 13)];
    FilesLabel.text  = @"档案编号";
    FilesLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    FilesLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [FilesView addSubview:FilesLabel];
    
    FilesTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 20, [UIScreen mainScreen].bounds.size.width-100, 15)];
    FilesTF.placeholder = @"请填写车主本人档案编号";
    FilesTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    FilesTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    FilesTF.delegate=self;
    FilesTF.keyboardType=UIReturnKeyDone;
    [FilesView addSubview:FilesTF];
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, [UIScreen mainScreen].bounds.size.width, 1)];
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [FilesView addSubview:line3];
    
    UIButton *FilesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    FilesButton.tag=2;
    FilesButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-17-15, 18, 17, 17.5);
    [FilesButton setImage:[UIImage imageNamed:@"icon_hint2"] forState:0];
    [FilesButton addTarget:self action:@selector(DriveBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    [FilesView addSubview:FilesButton];
    
    UIView *bgVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 50+240, [UIScreen mainScreen].bounds.size.width, 5)];
    bgVIew.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [_scrollerView addSubview:bgVIew];
    
}
//可缴费违章
-(void)initCanPayView
{
    if (!shiftHeight) {
        shiftHeight=0;
    }
    if (!(peccArr.count>0)) {
        return;
    }
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50+240+5, [UIScreen mainScreen].bounds.size.width, 22)];
    
    [_scrollerView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, 100, 13)];
    label1.text  = @"可缴费违章";
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [view1 addSubview:label1];
    shiftHeight+=5;
    for (int i =0; i < peccArr.count; i++) {
        
        PeccancecyInfoModel *model=peccArr[i];
        CGSize behaviorSize=[model.behavior sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-105, 100)];
        CGSize placeSize=[[NSString stringWithFormat:@"%@%@",model.city,model.PeccancecyPlaceStr] sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-105, 100)];
        
        UIButton *view=[UIButton buttonWithType:UIButtonTypeCustom];
        view.frame=CGRectMake(0, 50+240+5+22+shiftHeight, [UIScreen mainScreen].bounds.size.width, 99+behaviorSize.height+placeSize.height);
        view.tag=i+300;
        [view addTarget:self action:@selector(ButtoneBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50+240+5+22+shiftHeight, [UIScreen mainScreen].bounds.size.width, 99+behaviorSize.height+placeSize.height)];
        
        
        
        [_scrollerView addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width-30, 12)];
        label.text  =[NSString stringWithFormat:@"扣%@分  罚%@元 服务费%@元",model.PeccancecyDecuteMarksStr,model.PeccancecyFineStr,model.serviceFee]  ;
        label.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:label];
        
        NSString *ShiFuPriceForColor = @"分  罚";
        NSString *ShiFuPriceForColor2 = @"元 服务费";
        // 创建对象.
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:label.text];
        //
        NSRange range1 = [label.text rangeOfString:ShiFuPriceForColor];
        NSRange range2 = [label.text rangeOfString:ShiFuPriceForColor2];
        NSRange range3 = NSMakeRange(0, 1);
        NSRange range4=NSMakeRange(label.text.length-1, 1);
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range1];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range3];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range2];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range4];
        
        label.attributedText=mAttStri1;
        
        UILabel *TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15+12+15, 35, 12)];
        TypeLabel.text =@"类型";
        TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:TypeLabel];
        
        
        UILabel *type=[[UILabel alloc]initWithFrame:CGRectMake(60, 15+10+15,behaviorSize.width,behaviorSize.height)];
        type.text=model.behavior;
        type.numberOfLines=0;
        type.textColor=RGB(51, 51, 51);
        type.font=KNSFONT(13);
        [view addSubview:type];
        
        UILabel *AddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,15+12+15+behaviorSize.height+15,35, 12)];
        AddressLabel.text  =@"地点";
        AddressLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        AddressLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        AddressLabel.numberOfLines = 2;
        [view addSubview:AddressLabel];
        
        UILabel *address=[[UILabel alloc] initWithFrame:CGRectMake(60, 15+10+15+behaviorSize.height+15, kScreen_Width-105, placeSize.height)];
        address.text=[NSString stringWithFormat:@"%@%@",model.city,model.PeccancecyPlaceStr];
        address.textColor=RGB(51, 51, 51);
        address.font=KNSFONT(13);
        [view addSubview:address];
        
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30, (99+behaviorSize.height+placeSize.height-15)/2, 15, 15);
        [Button setImage:[UIImage imageNamed:@"btn_unselected"] forState:0];
        Button.tag = i+10;
      //  [Button addTarget:self action:@selector(ButtoneBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        Button.selected=NO;
        [view addSubview:Button];
        
        UILabel *TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15+12+15+behaviorSize.height+15+placeSize.height+15, 35, 12)];
        TimeLabel.text  =@"时间";
        TimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:TimeLabel];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(60, 15+12+15+behaviorSize.height+15+placeSize.height+15, kScreen_Width-75, 12)];
        time.text=model.PeccancecyTimeStr;
        time.textColor=RGB(51, 51, 51);
        time.font=KNSFONT(13);
        [view addSubview:time];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99+placeSize.height+behaviorSize.height-1, [UIScreen mainScreen].bounds.size.width, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view addSubview:line3];
        shiftHeight=shiftHeight+99+placeSize.height+behaviorSize.height;
    }
    
    UIView *bgVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 50+240+5+22+shiftHeight, [UIScreen mainScreen].bounds.size.width, 5)];
    bgVIew.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    shiftHeight=shiftHeight+5;
    [_scrollerView addSubview:bgVIew];
    
}

//不支持违章缴费
-(void)initCanotPayView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65-49)];
        
        
        [self.view addSubview:_scrollerView];
    }
    if (!(peccNoArr.count>0)) {
        return;
    }
    if (peccArr.count==0) {
        shiftHeight+=-20;
    }
    shiftHeight+=5;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50+240+5+22+shiftHeight, [UIScreen mainScreen].bounds.size.width, 22)];
    shiftHeight=shiftHeight+22;
    [_scrollerView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, 120, 13)];
    label1.text  = @"不支持缴费的违章";
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [view1 addSubview:label1];
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(130, 7, 15, 15);
    
    [but setImage:[UIImage imageNamed:@"btn_help"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(showPayTips) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:but];
    for (int i =0; i < peccNoArr.count; i++) {
        
        PeccancecyInfoModel *model=peccNoArr[i];
        CGSize behaviorSize=[model.behavior sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-105, 100)];
        CGSize placeSize=[[NSString stringWithFormat:@"%@%@",model.city,model.PeccancecyPlaceStr] sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-105, 100)];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50+240+5+22+shiftHeight, [UIScreen mainScreen].bounds.size.width, 99+behaviorSize.height+placeSize.height)];
        NSLogRect(CGRectMake(0, 50+240+5+22+shiftHeight, [UIScreen mainScreen].bounds.size.width, 99+behaviorSize.height+placeSize.height));
        [_scrollerView addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width-30, 12)];
        label.text  =[NSString stringWithFormat:@"扣%@分  罚%@元 服务费%@元",model.PeccancecyDecuteMarksStr,model.PeccancecyFineStr,model.serviceFee]  ;
        label.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:label];
        
        NSString *ShiFuPriceForColor = @"分  罚";
        NSString *ShiFuPriceForColor2 = @"元 服务费";
        // 创建对象.
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:label.text];
        //
        NSRange range1 = [label.text rangeOfString:ShiFuPriceForColor];
        NSRange range2 = [label.text rangeOfString:ShiFuPriceForColor2];
        NSRange range3 = NSMakeRange(0, 1);
        NSRange range4=NSMakeRange(label.text.length-1, 1);
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range1];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range3];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range2];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range4];
        
        label.attributedText=mAttStri1;
        
        UILabel *TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15+12+15, 35, 12)];
        TypeLabel.text =@"类型";
        TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:TypeLabel];
        
        
        UILabel *type=[[UILabel alloc]initWithFrame:CGRectMake(60, 15+10+15,behaviorSize.width,behaviorSize.height)];
        type.text=model.behavior;
        type.numberOfLines=0;
        type.textColor=RGB(51, 51, 51);
        type.font=KNSFONT(13);
        [view addSubview:type];
        
        UILabel *AddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,15+12+15+behaviorSize.height+15,35, 12)];
        AddressLabel.text  =@"地点";
        AddressLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        AddressLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        AddressLabel.numberOfLines = 2;
        [view addSubview:AddressLabel];
        
        UILabel *address=[[UILabel alloc] initWithFrame:CGRectMake(60, 15+10+15+behaviorSize.height+15, kScreen_Width-105, placeSize.height)];
        address.text=[NSString stringWithFormat:@"%@%@",model.city,model.PeccancecyPlaceStr];
        address.textColor=RGB(51, 51, 51);
        address.font=KNSFONT(13);
        [view addSubview:address];
        
        UILabel *TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15+12+15+behaviorSize.height+15+placeSize.height+15, 35, 12)];
        TimeLabel.text  =@"时间";
        TimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:TimeLabel];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(60, 15+12+15+behaviorSize.height+15+placeSize.height+15, kScreen_Width-75, 12)];
        time.text=model.PeccancecyTimeStr;
        time.textColor=RGB(51, 51, 51);
        time.font=KNSFONT(13);
        [view addSubview:time];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99+placeSize.height+behaviorSize.height-1, [UIScreen mainScreen].bounds.size.width, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view addSubview:line3];
        shiftHeight=shiftHeight+99+placeSize.height+behaviorSize.height;
        NSLog(@"shiftHeight=%ld",shiftHeight);
        
    }
    
}

//提交按钮
-(void)initPayView
{
    
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 49)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
    [PayView.layer addSublayer:gradientLayer];
    
    [self.view addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"提交" forState:0];
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
}


/*******************************************************      协议方法       ******************************************************/
#pragma mark-UITextFieldDelegate-输入框协议
/*****
 *
 *  Description 键盘输入return键的执行方法
 *
 ******/
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*****
 *
 *  Description 检测输入的字符是否符合要求
 *
 ******/
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==PhoneTF) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        BOOL canChange = [string isEqualToString:filtered];
        if (!canChange) {
            [TrainToast showWithText:@"手机号只能输入数字" duration:1.0];
            
        }
        else if (PhoneTF.text.length>10)
        {
            [TrainToast showWithText:@"手机号最多为11位" duration:1.0];
            if ([string isEqualToString:@""]) {
                return YES;
            }
            return NO;
        }
        return canChange;
    }else if ((textField==DriveTF)||(textField==FilesTF))
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        BOOL canChange = [string isEqualToString:filtered];
        if (!canChange) {
            [TrainToast showWithText:@"只能输入英文和数字" duration:1.0];
        }
        return canChange;
    }
    return YES;
}

//返回
-(void)QurtBtnClick
{
  //  ATHBreakRulesUpImgViewController *vc=[[ATHBreakRulesUpImgViewController alloc]init];
    
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

//键盘掉下
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//服务说明
-(void)ShowBtnClick
{
    [self hideKeyBoard];
    ServiceVC *vc=[[ServiceVC alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
}

/*****
 *
 *  Description 输入框后的叹号、弹出档案编号和驾驶证号的图片
 *
 ******/
-(void)DriveBtnCLick:(UIButton *)sender
{
    [self hideKeyBoard];
    if (!TipIV) {
       // TipIV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-233)/2, 200, 233, 158)];
        TipIV=[[UIImageView alloc]initWithFrame:CGRectMake(75, 200, kScreen_Width-150, (kScreen_Width-150)*158/233)];
    }
    if (sender.tag==1)
    {
        TipIV.image=[UIImage imageNamed:@"驾驶证号"];
        NSLog(@"驾驶证号");
        
    }else
    {
        TipIV.image=[UIImage imageNamed:@"档案编号"];
        NSLog(@"档案编号");
    }
    if (!huiseControl) {
        huiseControl=[[UIControl alloc]initWithFrame:self.view.frame];
        huiseControl.backgroundColor=RGBA(0, 0, 0, 0.74);
        [huiseControl addTarget:self action:@selector(huiseCotrolclick) forControlEvents:UIControlEventTouchUpInside];
        huiseControl.alpha=0;
    }
    
    if (huiseControl.superview==nil) {
        [self.view addSubview:huiseControl];
    }
    [self.view addSubview:TipIV];
    [UIView animateWithDuration:0.2 animations:^{
        huiseControl.alpha=1;
    }];
    
}
/*****
 *
 *  Description 点击不可缴费违章后的问号、弹出遮罩和提示
 *
 ******/
-(void)showPayTips
{
    [self hideKeyBoard];

    if (!plateTipsView) {
        plateTipsView=[[UIView alloc]initWithFrame:CGRectMake(60, (kScreen_Height-200)/2, kScreen_Width-120, 200)];
        plateTipsView.backgroundColor=[UIColor whiteColor];
        plateTipsView.layer.cornerRadius=10;
        
        UIButton *closeBut=[UIButton buttonWithType:UIButtonTypeCustom];
        closeBut.frame=CGRectMake(kScreen_Width-130,-10, 20, 20);
        [closeBut setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        [closeBut addTarget:self action:@selector(huiseCotrolclick) forControlEvents:UIControlEventTouchUpInside];
        [plateTipsView addSubview:closeBut];
        
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreen_Width-120, 15)];
        titleLab.font=KNSFONT(16);
        titleLab.textColor=RGB(51, 51, 51);
        titleLab.text=@"提示";
        titleLab.textAlignment=NSTextAlignmentCenter;
        [plateTipsView addSubview:titleLab];
        
        UILabel *msgLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 35,kScreen_Width-160, 200-35)];
        msgLab.font=KNSFONT(15);
        msgLab.textColor=RGB(51, 51, 51);
        msgLab.text=@"暂不支持缴费的违章(未知扣分、未知罚款、部分高速违章、部分外地违章),如果你的违章不属于上述情况，请检查查询城市是否包含车牌所在地,请重新勾选查询城市后再次尝试。不支持缴费的违章请前往交管局柜台进行处理。最终解释权归本公司所有。";
        msgLab.numberOfLines=0;
        [plateTipsView addSubview:msgLab];
    }
    if (!huiseControl) {
        huiseControl=[[UIControl alloc]initWithFrame:self.view.frame];
        huiseControl.backgroundColor=RGBA(0, 0, 0, 0.74);
        [huiseControl addTarget:self action:@selector(huiseCotrolclick) forControlEvents:UIControlEventTouchUpInside];
        huiseControl.alpha=0;
    }
    
    if (huiseControl.superview==nil) {
        [self.view addSubview:huiseControl];
    }
    [self.view addSubview:plateTipsView];
    
    [UIView animateWithDuration:0.2 animations:^{
        huiseControl.alpha=1;
    }];
}
/*****
 *
 *  Description 点击遮罩
 *
 ******/
-(void)huiseCotrolclick
{
    
    [UIView animateWithDuration:0.2 animations:^{
        huiseControl.alpha=0;
    }completion:^(BOOL finished) {
        if (TipIV.superview!=nil) {
        [TipIV removeFromSuperview];
        }
        if (plateTipsView.superview!=nil) {
            [plateTipsView removeFromSuperview];
        }
    }];
}

//选择缴费违章
-(void)ButtoneBtnCLick:(UIButton *)sender
{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:sender.tag-300+10];
    NSInteger selectCount=0;
    for (int i=0; i<peccArr.count; i++) {
        UIButton *but = (UIButton *)[self.view viewWithTag:i+10];
        if (but.selected==YES) {
            selectCount++;
        }
    }
    //获取已选中违章条数、大于等于20则弹出提示消息，并返回
    if ((selectCount>=20)&&(button.selected==NO)) {
        [TrainToast showWithText:@"单笔订单最多可勾选20条违章进行缴费" duration:1.0];
        return;
    }
    
    button.selected=!button.selected;
    if (button.selected) {
        
        [button setImage:[UIImage imageNamed:@"btn_The-selected"] forState:0];
        
    }else{
        
        [button setImage:[UIImage imageNamed:@"btn_unselected"] forState:0];
    }
    
}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/

//收起键盘
-(void)hideKeyBoard
{
    [NameTF resignFirstResponder];
    [PhoneTF resignFirstResponder];
    [DriveTF resignFirstResponder];
    [FilesTF resignFirstResponder];
}

/*****
 *
 *  Description 校验信息填写是否符合要求
 *
 ******/
-(BOOL)personInfoIsCorrect
{
    BOOL nameBOOL=[NameTF.text isChinese];
    BOOL phoneBool=[PhoneTF.text phoneNumberIsCorrect];
    NSString *ptr2= @"^[A-Za-z0-9]*$";
    NSPredicate *carTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ptr2];
    BOOL DriveBOOL=(![DriveTF.text isEqualToString:@""])&&[carTest2 evaluateWithObject:DriveTF.text];
    BOOL filesBOOL=(![FilesTF.text isEqualToString:@""])&&[carTest2 evaluateWithObject:FilesTF.text];
    if (!nameBOOL) {
        [TrainToast showWithText:@"请填写车主姓名，仅限11位汉字以内" duration:2.0];
    }else if (!phoneBool)
    {
        [TrainToast showWithText:@"请填写正确的手机号码" duration:2.0];
    }else if (!DriveBOOL)
    {
        [TrainToast showWithText:@"请填写正确的驾驶证号" duration:2.0];
    }else if (!filesBOOL)
    {
        [TrainToast showWithText:@"请填写正确的档案编号" duration:2.0];
    }else
    {
        return YES;
    }
    return NO;
}


@end
