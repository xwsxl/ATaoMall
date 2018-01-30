//
//  NewGoodsDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NewGoodsDetailViewController.h"

#import "GoodsDetailHeaderView.h"
#import "GoodsDetailCell.h"

#import "AFNetworking.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "UIImageView+WebCache.h"

#import "GoodsDetailModel.h"

#import "GotoShopLookViewController.h"//店铺详情

#import "TuWenViewController.h"//图文详情
#import "QueDingDingDanViewController.h"//确定订单

#import "NewAddAddressViewController.h"

//弹出视图
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"
#import "CustomActionSheet.h"

#import "GoodsDetailImageModel.h"

#import "NewGoodsDetailViewController.h"

#import "WKProgressHUD.h"

#import "NewLoginViewController.h"

#import "GGClockView.h"//倒计时

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "UserMessageManager.h"

#import "XSInfoView.h"

#import "JRToast.h"

#import "SVProgressHUD.h"

#import "GoodsAttributeCell.h"//商品属性的cell
#import "GoodsAttributeCell2.h"
#import "GoodsDetailMainView.h"

#import "ChoseView.h"

#import "GoodsAttributeModel.h"//属性

#import "ATHLoginViewController.h"
#define fwidth [UIScreen mainScreen].bounds.size.width

@interface NewGoodsDetailViewController ()<UITableViewDataSource,UITableViewDelegate,CustomActionSheetDelagate,LoginMessageDelegate,DJRefreshDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_datasArrM;
    
    NSMutableArray *_ArrM;
    
    NSString *sendWayString;//配送方式
    
    NSMutableArray *_ImageArrM;//轮番图片
    
    GoodsDetailHeaderView *_header;
    
    UIImageView *imgView;
    
    UILabel *label2;
    
    UIView *topView;
    
    UIButton *rightButton;//图文详情
   
    
    GoodsDetailMainView *goodsMainview;
    ChoseView *choseView;
    NSArray *sizearr;//尺寸数组
    NSArray *colorarr;//颜色数组
    NSArray *BuLiaoarr3;//布料数组
    NSArray *Stylearr4;//风格数组
    NSArray *Titlearr5;//标题数组；
    NSString *Goods_Type;
    NSString *Goods_Status;
    
    NSMutableArray *TitleArrM1;//中间可变数组
    NSMutableArray *ColorArrM2;//颜色可变数组
    NSMutableArray *SizeArrM3;//尺寸数组
    NSMutableArray *BuLiaoArrM4;//布料可变数组
    NSMutableArray *StyleArrM5;//风格可变数组
    
    NSString *ImageString;//图片
    NSString *MoneyString;//现金
    NSString *IntergelString;//积分
    NSString *StockString;//库存
    
    
    
    NSDictionary *stockdic;//商品库存量
    int goodsStock;
    UIView *view;
    

}

@property (nonatomic, weak) GGClockView *clockView;

@property (nonatomic,strong)DJRefresh *refresh;

@end

@implementation NewGoodsDetailViewController

-(void)viewWillAppear:(BOOL)animated{

    if (_header.timer) {
        [_header.timer invalidate];
        NSLog(@"定时器已经被释放了");
    }
    
}
-(void)dealloc{
    
    [_header.timer invalidate];
    NSLog(@"定时器已经被释放了。。。。。。哈哈");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame=[UIScreen mainScreen].bounds;
    
    TitleArrM1=[NSMutableArray new];
    
    ColorArrM2=[NSMutableArray new];
    
    SizeArrM3=[NSMutableArray new];
    
    BuLiaoArrM4=[NSMutableArray new];
    
    StyleArrM5=[NSMutableArray new];
    
//    NSLog(@"===========self.gid===%@==",self.gid);
    
   

    // Do any additional setup after loading the view from its nib.
    [self SetDataForButton];
    
//    [self initview];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    NSLog(@">>>>>>%@",self.sigen);
    
    
    self.sigen=@"";
    
    sendWayString=@"快递邮寄";
    self.MoneyType = @"0";
    
    _datasArrM=[NSMutableArray new];
    
    _ArrM=[NSMutableArray new];
    
    _ImageArrM=[NSMutableArray new];

        //获取数据
    [self getDatas];
    
    
    
    //创建
    [self initTableView];
    
   
    
    
   //     WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//       [hud dismiss:YES];
//    });

    
    topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    topView.backgroundColor=[UIColor clearColor];
    
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"左返回1.png"] forState:0];
    backButton.frame=CGRectMake(20, 25, 30, 30);
    
    
    [backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:backButton];
    
    if ([self.good_type isEqualToString:@"1"]) {
        
        
        label2=[[UILabel alloc] initWithFrame:CGRectMake(fwidth/4+90+fwidth/25, 25, 50, 30)];
        
        if ([self.status isEqualToString:@"4"]) {
            label2.text=@"后停止";
            
        }else if ([self.status isEqualToString:@"0"]){
           label2.text=@"后开始";
        }
        
//        label2.backgroundColor = [UIColor blueColor];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font=[UIFont systemFontOfSize:13];
        
        label2.textColor=[UIColor whiteColor];
        
        [self.view addSubview:label2];
//        [self.view insertSubview:label2 atIndex:4];
        
        imgView=[[UIImageView alloc] initWithFrame:CGRectMake(fwidth/4, 25, fwidth-fwidth/2-fwidth/25, 30)];
        
        imgView.image=[UIImage imageNamed:@"开始@2x.png"];
        
        [topView addSubview:imgView];
        
        self.timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(fwidth/4+fwidth/25, 20, 90, 30)];
//       self.timeLabel.backgroundColor= [UIColor greenColor];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.timeLabel];
        
        //将label2加到topView上
        [topView insertSubview:label2 aboveSubview:self.view];
       
        
//        [imgView addSubview:label2];
        
    }
    
    
    
    
    rightButton=[UIButton buttonWithType:UIButtonTypeCustom];

    
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"图文祥情按钮@2x"] forState:0];
    
//    rightButton.backgroundColor=[UIColor orangeColor];
    rightButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-75, 25, 60, 30);
    
    [rightButton setTitle:@"图文详情" forState:0];
    
    [rightButton setTitleColor:[UIColor whiteColor] forState:0];
    
    rightButton.titleLabel.font=[UIFont systemFontOfSize:12];

    if (self.String.length>0) {
        
        [rightButton addTarget:self action:@selector(ImageDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
   
    [topView addSubview:rightButton];
    
    
    
    [self.view addSubview:topView];
    
   
    
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

//获取属性数据
-(void)getGoodsAttributeDatas
{
//    创建菊花
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getGoodAttributeInfo_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    NSDictionary *dic = @{@"gid":self.gid};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr%@",xmlStr);
            
            //菊花消失
            [hud dismiss:YES];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            NSLog(@"=//获取属性数据==%@",dic2);
            
            NSLog(@"#########==%@",dic2[@"totalStock"]);
            
            StockString =dic2[@"totalStock"];
            
            view.hidden=YES;
            
            
            if ([dic2[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict in dic2[@"list"]) {
                    
                    
                    NSLog(@"=====bigName===%@",dict[@"bigName"]);
                    
                    //添加标题
                    [TitleArrM1 addObject:dict[@"bigName"]];
                    
                    if ([dict[@"bigKey"] isEqualToString:@"a"]) {
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            NSLog(@"==1====smallName==%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [ColorArrM2 addObject:model];
                            
                            
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"b"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            NSLog(@">>>2>>>>smallName>>%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [SizeArrM3 addObject:model];
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"c"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            NSLog(@">>>>3>>>smallName>>%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [BuLiaoArrM4 addObject:model];
                            
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"d"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            NSLog(@">>>>>4>>smallName>>%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [StyleArrM5 addObject:model];
                            
                        }
                    }
                }
                
                
                if (SizeArrM3.count==1) {
                    //缓存尺码
                    
                    for (GoodsAttributeModel *model in SizeArrM3) {
                        
                        [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%@",model.mallId]];
                        [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%@",model.mallId]];
                    }
                    
                    
                }
                
                if (ColorArrM2.count==1) {
                    //缓存颜色
                    for (GoodsAttributeModel *model in ColorArrM2) {
                        
                        [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%@",model.mallId]];
                        [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%@",model.mallId]];
                    }
                    
                    
                }
                
                
                if (BuLiaoArrM4.count==1) {
                    
                    //缓存布料
                    
                    for (GoodsAttributeModel *model in BuLiaoArrM4) {
                        
                        [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%@",model.mallId]];
                        [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%@",model.mallId]];
                        
                    }
                    
                }
                
                if (StyleArrM5.count==1) {
                    
                    //缓存风格
                    
                    for (GoodsAttributeModel *model in StyleArrM5) {
                        
                        
                        [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%@",model.mallId]];
                        [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%@",model.mallId]];
                    }
                    
                }
                
                
                
                Titlearr5=TitleArrM1;
                colorarr=SizeArrM3;
                sizearr=ColorArrM2;
                BuLiaoarr3=BuLiaoArrM4;
                Stylearr4=StyleArrM5;
                
                
                NSLog(@"===BuLiaoArrM4.count====%ld",BuLiaoArrM4.count);
                NSLog(@"===ColorArrM2====%ld",ColorArrM2.count);
                NSLog(@"==SizeArrM3====%ld",SizeArrM3.count);
                NSLog(@"===StyleArrM5====%ld",StyleArrM5.count);
                
            }else if ([dic2[@"status"] isEqualToString:@"10005"]){
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:dic2[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else if ([dic2[@"status"] isEqualToString:@"10010"]){
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:dic2[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}



-(void)loadData{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    
    [self getDatas];
    
}
//获取数据赋值
-(void)SetDataForButton
{
    
//    Titlearr5 = [[NSArray alloc] initWithObjects:@"尺码",@"颜色",@"尺码",@"颜色",nil];
//    sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",@"S",@"M",@"L",@"S",@"M",@"L",@"S",@"M",@"L",@"S",@"M",@"L",nil];
//    colorarr = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",@"蓝色",@"红色",@"湖蓝色",@"咖啡色",@"蓝色",@"红色",@"湖蓝色",nil];
//    BuLiaoarr3 = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",@"蓝色",nil];
//    Stylearr4 = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",nil];
    
}

-(void)initview{

 self.view.backgroundColor = [UIColor blackColor];
    
//    NSLog(@"ppppppppppppp==%@",self.gid);
    goodsMainview = [[GoodsDetailMainView alloc] initWithFrame:self.view.bounds];
    
    goodsMainview.vc = self;
    [self.view addSubview:goodsMainview];
    goodsMainview.goodsDetail.delegate = self;

    
    
    [goodsMainview initChoseViewSizeArr:sizearr andColorArr:colorarr andArr3:BuLiaoarr3 andArr4:Stylearr4 andArr5:Titlearr5 andStockDic:stockdic andGoodsImageView:ImageString andMoney:MoneyString andJIFen:IntergelString andKuCun:StockString andGid:self.gid andcount:self.count andGoods_type:Goods_Type andGoods_status:Goods_Status andback:self.Attribute_back andYTBack:@"300" andMid:self.mid andYYYY:@"1" andSmallIds:@"" andStorename:self.storename andLogo:self.logo andSendWayType:self.SendWayType andMoneyType:self.MoneyType andSid:@"" andTf:@"" andCut:@"" andJinDu:@"" andWeiDu:@"" andAddressString:@"" andNewHomeString:@""];


}

-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6
{
    self.sigen=string1;
    
    [_tableView reloadData];
    
}
//获取商品详情数据
-(void)getDatas
{
    //    创建菊花
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMerchantsGoodsDetails_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"id":self.gid};
    
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr%@",xmlStr);
            //菊花消失
            [hud dismiss:YES];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=====商品详情：%@",dic);
            
            view.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {
                
                
                self.String=dict1[@"status"];
                
                for (NSDictionary *dict2 in dict1[@"list_goods"]) {
                    GoodsDetailModel *model=[[GoodsDetailModel alloc] init];
                    
//                    GoodsDetailImageModel *model1=[[GoodsDetailImageModel alloc] init];
                    model.is_attribute = dict2[@"is_attribute"];//商品属性判断
                    _attribute = dict2[@"is_attribute"];
                    _count = dict2[@"count"];
                    model.amount=dict2[@"amount"];
                    model.freight=dict2[@"freight"];
                    model.id=dict2[@"id"];
                    model.integral=dict2[@"integral"];
                    model.name=dict2[@"name"];
                    model.pay_integer=dict2[@"pay_integer"];
                    model.pay_maney=dict2[@"pay_maney"];
                    model.scopeimg=dict2[@"scopeimg"];
                    
                    ImageString = dict2[@"scopeimg"];
                    MoneyString = dict2[@"pay_maney"];
                    IntergelString = dict2[@"pay_integer"];
//                    StockString = dict2[@"stock"];
                    
                    NSLog(@"===========freight====%@",dict2[@"freight"]);
                    
                    
                    
                    model.tname=dict2[@"tname"];
                    model.pice=dict2[@"pice"];
                    model.mid=dict2[@"mid"];
                    
                    self.mid=dict2[@"mid"];
                    
                    model.type=dict2[@"type"];
                    model.good_type=dict2[@"good_type"];
                    model.status=dict2[@"status"];
                    model.min_price = dict2[@"min_price"];
                    model.max_price = dict2[@"max_price"];
                    
                    if ([dict2[@"is_attribute"] isEqualToString:@"2"]) {
                        
                        
                    }else{
                        
                        self.stock=dict2[@"stock"];
                    }
//                    self.stock=dict2[@"stock"];
                    
                    self.Good_status=dict2[@"status"];
                    
                    Goods_Type=dict2[@"good_type"];
                    Goods_Status=dict2[@"status"];
                    
                    NSNull *null=[[NSNull alloc] init];
                    
                    if (![dict2[@"start_time_str"] isEqual:null] && ![dict2[@"end_time_str"] isEqual:null]) {
                        
                        self.startString=dict2[@"start_time_str"];
                        self.endString=dict2[@"end_time_str"];
                    }
                    
                    
//
//                    NSLog(@"model.id=====%@",dict2[@"id"]);
//                    NSLog(@"self.gid=====%@",self.gid);
                    
                    self.SendWayType=dict2[@"type"];//配送方式
                    self.exchange2 = dict2[@"exchange"];
                    NSString *picpath=dict2[@"picpath"];
                    NSString *picpath2=dict2[@"picpath2"];
                    NSString *picpath3=dict2[@"picpath3"];
                    NSString *picpath4=dict2[@"picpath4"];
                    
                    [_datasArrM addObject:model];
                    
                    if ([picpath isEqualToString:@""]) {
                        
                    }else{
                        
                        [_ImageArrM addObject:picpath];
                    }
                    
                    if ([picpath2 isEqualToString:@""]) {
                        
                        
                    }else{
                        [_ImageArrM addObject:picpath2];
                    }
                    
                    if ([picpath3 isEqualToString:@""]) {
                        
                    }else{
                       [_ImageArrM addObject:picpath3];
                    }
                    
                    if ([picpath4 isEqualToString:@""]) {
                        
                    }else{
                        
                        [_ImageArrM addObject:picpath4];
                    }
                    
                    
                }
                
                NSLog(@"======Count===%ld",_ImageArrM.count);
                
                GoodsDetailModel *model=[[GoodsDetailModel alloc] init];
                
                
                
                
                model.city=dict1[@"merchants_map"][@"city"];
                model.coordinates=dict1[@"merchants_map"][@"coordinates"];
                model.county=dict1[@"merchants_map"][@"county"];
                model.logo=dict1[@"merchants_map"][@"logo"];
                model.mobile=dict1[@"merchants_map"][@"mobile"];
                model.province=dict1[@"merchants_map"][@"province"];
                model.storename=dict1[@"merchants_map"][@"storename"];
                
                self.logo=dict1[@"merchants_map"][@"logo"];
                self.storename=dict1[@"merchants_map"][@"storename"];
                    
                [_ArrM addObject:model];
            }
            [_tableView reloadData];
            
            
            if ([self.good_type isEqualToString:@"1"]) {
                
                //倒计时
                [self DaoJiTime];
            }
            
            //只有等数据加载完毕，才能点击
            if ([self.String isEqualToString:@"10000"]) {
                
                [rightButton addTarget:self action:@selector(ImageDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
            }
            if([_attribute intValue]==2){
                [self getGoodsAttributeDatas];
            }
        }
        NSLog(@"kkkkkkkkkkkk=%@",self.exchange2);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self getDatas];
        
        NSLog(@"%@",error);
    }];
    
}

-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49+20) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
//    UIView *view1=[[UIView alloc] initWithFrame:self.view.frame];
//   _tableView.frame=view1.bounds;
//    self.view=view1;
//    
//    [view1 addSubview:_tableView];
    
    
    
    _tableView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    
    
    [self.view addSubview:_tableView];
    
    
    _tableView.tableHeaderView=_header;
    
    
    _header.userInteractionEnabled=YES;
    
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsDetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsAttributeCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsAttributeCell2" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsDetailHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 2;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        return 110;
    }else if ([_attribute integerValue] == 2 && indexPath.row==0) {
        return 65;
    }else{
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [UIScreen mainScreen].bounds.size.height*4/5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if(indexPath.row == 0){
            if ([_attribute integerValue] == 2) {
    GoodsAttributeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                if ([self.Panduan integerValue]== 2) {
                    cell.GoodsAttribute.text = self.YXZattribute;
                }
//    cell.GoodsAttribute.text = @"颜色+尺寸";
//  
                
        return cell;
                
            }else{
            
            GoodsAttributeCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
                return cell;
            }
    
    
    }
   
    GoodsDetailCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
    for (GoodsDetailModel *model in _ArrM) {
        
//        //图片切成圆形
//        cell1.ShopLogoImageView.layer.masksToBounds=YES;
//        cell1.ShopLogoImageView.layer.cornerRadius=30;
        
//            [cell1.ShopLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        
        [cell1.ShopLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            cell1.ShopNameLabel.text=[NSString stringWithFormat:@"店铺名:%@",model.storename];
            cell1.ShopPhoneLabel.text=[NSString stringWithFormat:@"联系电话:%@",model.mobile];
        }
        cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭
        return cell1;
    

   }

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
//    NSNull *null=[[NSNull alloc] init];
    
    for (GoodsDetailModel *model in _datasArrM) {
        _header.GoodsDetailNameLabel.text=model.name;
        
        
//        _header.NowPriceLabel.text=[NSString stringWithFormat:@"￥%@+%@积分",model.pay_maney,model.pay_integer];
        
        if ([self.Panduan integerValue] == 2) {
            
            _header.AmountLabel.text=[NSString stringWithFormat:@"总销量%@件",self.amount];
            //判断如果最高价和最低价相同，显示一个价格
            if ([model.min_price floatValue] == [model.max_price floatValue]) {
                 _header.Pricenum.text = [NSString stringWithFormat:@"   %.02f ",[model.min_price floatValue]];
            }else{
             _header.Pricenum.text = [NSString stringWithFormat:@"%.02f   %.02f",[model.min_price floatValue] ,[model.max_price floatValue]];
            
            }
            
            
            
        }else{
            
            _header.AmountLabel.text=[NSString stringWithFormat:@"总销量%@件",model.amount];
            
            if ([self.attribute integerValue] == 2) {
                
                //判断如果最高价和最低价相同，显示一个价格
                if ([model.min_price floatValue] == [model.max_price floatValue]) {
                    _header.Pricenum.text = [NSString stringWithFormat:@"   %.02f ",[model.min_price floatValue]];
                }else{
                    _header.Pricenum.text = [NSString stringWithFormat:@"%.02f   %.02f",[model.min_price floatValue] ,[model.max_price floatValue]];
                    
                }

                
            }else{
        
                
                _header.Pricenum.text = [NSString stringWithFormat:@"  %.02f元",[model.pice floatValue]];
                
                
            }
            
        }
       
       

        

            
            if ([self.Panduan integerValue] == 2) {
                
                 _header.NowPriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[self.pay_money floatValue],[self.pay_integral floatValue]];
                
            }else{
                 _header.NowPriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
            }
            
           
            
            NSString *stringForColor = @"积分";
            
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:_header.NowPriceLabel.text];
            //
            NSRange range = [_header.NowPriceLabel.text rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range];
            
            _header.NowPriceLabel.attributedText=mAttStri;
            

        
 //进行配送方式的选择
        
        if ([self.exchange integerValue] == 1|| [self.exchange integerValue] == 2) {
            
//            _header.SendMoneyLabel.text=[NSString stringWithFormat:@"配送￥%.02f",[model.freight floatValue]];
            
            sendWayString=@"快递邮寄";
            
            float number=[model.pay_maney floatValue] + [model.freight floatValue];
            
            NSString *string=[NSString stringWithFormat:@"%.02f",(float)number];
            

                if ([self.Panduan integerValue] == 2) {
                    number=[self.pay_money floatValue] + [self.yunfei floatValue];
                    string=[NSString stringWithFormat:@"%.02f",(float)number];
                    self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                    NSLog(@"==1919119191119111911====%@",self.PayMoneyLabel.text);
                }else{
                    
                    self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue],[model.pay_integer floatValue]];
                    NSLog(@"==11818181181181181181====%@",self.PayMoneyLabel.text);
                }

            
        }else{
//
                //3
                if ([sendWayString isEqualToString:@"快递邮寄"]) {
                    
                    float number=[model.pay_maney floatValue] + [model.freight floatValue];
                    
                    NSString *string=[NSString stringWithFormat:@"%.02f",(float)number];
                    
                    NSLog(@"==string===%@",string);
                    NSLog(@"===model.pay_integer==%@",model.pay_integer);
                    
                    self.MoneyType=@"0";
                    

                        if ([self.Panduan integerValue] == 2  ) {
                            
                            number=[self.pay_money floatValue] + [self.yunfei floatValue];
                            string=[NSString stringWithFormat:@"%.02f",(float)number];
                             self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                            NSLog(@"==888888888888888====%@",self.PayMoneyLabel.text);
                        }else{
                            
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue],[model.pay_integer floatValue]];
                            
                            NSLog(@"==777777777777777====%@",self.PayMoneyLabel.text);
                            
//                            [_tableView reloadData];
                            
                        }
                       

                    
                }else{
                    float number=[model.pay_maney floatValue] + [model.freight floatValue];
                    
                    NSString *string=[NSString stringWithFormat:@"%.02f",(float)number];
                    
                    self.MoneyType=@"1";
                    

                        if ([self.Panduan integerValue] == 2  ) {
                            number=[self.pay_money floatValue];// + [self.yunfei floatValue];
                            string=[NSString stringWithFormat:@"%.02f",(float)number];
                        self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            NSLog(@"==22222222222222====%@",self.PayMoneyLabel.text);
                        }else{
                            
                            NSLog(@"===%@====%@",string ,model.freight);
                        self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]-[model.freight floatValue],[model.pay_integer floatValue]];
                            
                            NSLog(@"==1111111111111====%@",self.PayMoneyLabel.text);
                            
//                            [_tableView reloadData];
                            
                            
                        }

                }

        }
    }
    
    
//    [_header.SendWayButton setTitle:sendWayString forState:0];
    //返回
    
    [_header.SendWayButton addTarget:self action:@selector(SendWayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //传入数组数据
    _header.headerDatas = _ImageArrM;
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
          
          
    if ([[userDefaultes stringForKey:@"gouxuan"] isEqualToString:@"1"]) {
        
        sendWayString=@"快递邮寄";
        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@ >",sendWayString] forState:0];
        
    }else if ([[userDefaultes stringForKey:@"gouxuan"] isEqualToString:@"2"]){
        
        sendWayString=@"线下自取";
        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@ >",sendWayString] forState:0];
        
    }else{
        
        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@ >",sendWayString] forState:0];
    }
    
    
    
    
    NSLog(@"===%@",sendWayString);
    return _header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        NSLog(@"点击了商品属性");
        [self initview];
        [goodsMainview show];
        

        
    }else{
    
    GotoShopLookViewController *vc=[[GotoShopLookViewController alloc] init];
    
        if ([self.Attribute_back isEqualToString:@"1"]) {
            
            vc.GetString=@"2";
            
        }else if ([self.Attribute_back isEqualToString:@"2"]){
            
            vc.GetString=@"3";
        }else if ([self.Attribute_back isEqualToString:@"3"]){
            
            vc.GetString=@"4";
        }else if ([self.Attribute_back isEqualToString:@"4"]){
            
            vc.GetString=@"5";
        }
        
        
    vc.type=@"1";//判断返回界面
    
    for (GoodsDetailModel *model in _datasArrM) {
        vc.mid=model.mid;
    }
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    }
}

-(void)backBtnClick
{
    
    if ([self.type isEqualToString:@"1"]) {
        
//        [self.navigationController popViewControllerAnimated:YES];
        [UserMessageManager removeAllGoodsAttribute];
        [UserMessageManager removeAllImageSecect];
        self.tabBarController.tabBar.hidden=NO;
        
        if ([self.attribute integerValue] == 2) {
            
            
            if ([self.Attribute_back isEqualToString:@"2"]) {
                
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
                
            }else if([self.Attribute_back isEqualToString:@"3"]){
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
                
            }else if([self.Attribute_back isEqualToString:@"4"]){
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[3] animated:YES];
                
            }else if([self.Attribute_back isEqualToString:@"5"]){
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[4] animated:YES];
                
            }else{
                
                
                NSArray *vcArray = self.navigationController.viewControllers;
                
                
                for(UIViewController *vc in vcArray)
                {
                    if ([vc isKindOfClass:[BusinessQurtViewController class]]){
                        
                        
                        self.navigationController.navigationBar.hidden=NO;
                        self.tabBarController.tabBar.hidden=NO;
                        
                        [self.navigationController popToViewController:vc animated:NO];
                        
                    }else{
                        
                        [self.navigationController popToRootViewControllerAnimated:NO];
                    }
                }
//                
//                self.navigationController.navigationBar.hidden = NO;
//                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
    }else{
        [UserMessageManager removeAllGoodsAttribute];
        [UserMessageManager removeAllImageSecect];
//        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.tabBar.hidden=YES;
        
        if ([self.attribute integerValue] == 2) {
            
            if ([self.Attribute_back isEqualToString:@"2"]) {
                
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
                
            }else if([self.Attribute_back isEqualToString:@"3"]){
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
                
            }else if([self.Attribute_back isEqualToString:@"4"]){
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[3] animated:YES];
                
            }else if([self.Attribute_back isEqualToString:@"5"]){
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[4] animated:YES];
                
            }else{
                
                self.navigationController.navigationBar.hidden = NO;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }

        
        
    }
    
}
//图文详情
-(void)ImageDetailBtnClick
{
    
    NSLog(@"PayMoneyLabel.text=%@",self.PayMoneyLabel.text);
    
    TuWenViewController *vc=[[TuWenViewController alloc] init];
    
    
    for (GoodsDetailModel *model in _datasArrM) {
        vc.ID=model.id;
    }
    vc.pay_xiaoji = self.PayMoneyLabel.text;
    
    if ([self.attribute integerValue]==2) {
         vc.detailId = self.detailId;
        vc.MoneyType = self.MoneyType;
        vc.num = self.num;
        vc.Panduan = self.Panduan;
        if ([self.Panduan integerValue]== 2) {
            vc.exchange = self.exchange;
        }else{
        vc.exchange = self.exchange2;
        }
        
    }
//     NSLog(@"kkkkkkkkkkkk=%@",self.exchange);
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

//配送方式
-(void)SendWayBtnClick
{
    
    if ([self.Panduan integerValue] == 2) {
        
        if ([self.exchange integerValue] == 1|| [self.exchange integerValue] == 2) {
//            CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄"]];
            self.MoneyType = @"0";
//            mySheet.cancelTitle=@"关闭";
//            mySheet.delegate = self;
//            [mySheet show];
        }else if([self.exchange integerValue] == 3|| [self.exchange integerValue] == 4){
        
            CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄",@"线下自取"]];
            
//            mySheet.cancelTitle=@"关闭";
            
            mySheet.delegate = self;
            
            
            [mySheet show];
        
        }
    }else{
        if ([self.exchange2 integerValue] == 1|| [self.exchange2 integerValue] == 2) {
//            CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄"]];
           self.MoneyType = @"0";
//            mySheet.cancelTitle=@"关闭";
//            
//            mySheet.delegate = self;
//            [mySheet show];
        }else if([self.exchange2 integerValue] == 3|| [self.exchange2 integerValue] == 4){
            
            CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄",@"线下自取"]];
             self.MoneyType = @"0";
//            mySheet.cancelTitle=@"关闭";
            
            mySheet.delegate = self;
            [mySheet show];
            
        }

    
        
        
    }
//    if ([self.SendWayType isEqualToString:@"0"]) {
//      CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄"]];
//        
//        mySheet.cancelTitle=@"关闭";
//        
//        mySheet.delegate = self;
//        [mySheet show];
//    }
    
    
//    CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄",@"包邮",@"线下自取"]];
    
//    mySheet.cancelTitle=@"关闭";
//
//    mySheet.delegate = self;
//    [mySheet show];
}

#pragma mark - delegate
// 在代理方法中写你需要处理的点击事件逻辑即可
- (void)sheet:(CustomActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"you has clicked button ======= %ld",(long)buttonIndex);
    
    
    for (GoodsDetailModel *model in _datasArrM) {

//        NSInteger number=[model.pay_maney integerValue] + 10;
         //       NSString *string=[NSString stringWithFormat:@"%ld",(long)number];
        
        if ((long)buttonIndex==0) {
            sendWayString=@"快递邮寄";
            
//            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%@ + %@积分",string,model.pay_integer];
            
            NSLog(@"%@",self.PayMoneyLabel.text);
            
            
            
            _header.SendMoneyLabel.text=[NSString stringWithFormat:@"配送 "];
            
            self.MoneyType=@"0";
            
            
            //缓存勾选状态
            [UserMessageManager GoodsImageSecect:@"1"];
            
            [_tableView reloadData];
            
        }else if ((long)buttonIndex==1){
            sendWayString=@"线下自取";
            _header.SendMoneyLabel.text=[NSString stringWithFormat:@"配送 "];
            
            self.MoneyType=@"1";
            
            //缓存勾选状态
            [UserMessageManager GoodsImageSecect:@"2"];
            
        }
        
        [_tableView reloadData];
    }
    
}

//同店铺的不能购买
-(void)getDatas1
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD showWithStatus:@"请耐心等待..."];
    NSNull *null=[[NSNull alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getConfirmOrderInfo_mob.shtml",URL_Str];
    
    NSLog(@"=====self.sigen====%@========",self.sigen);
    NSLog(@"=====self.mid====%@========",self.mid);
    NSLog(@"=====self.gid====%@========",self.gid);
    NSLog(@"=====self.logo====%@========",self.logo);
    NSLog(@"=====self.storename====%@========",self.storename);
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"mid":self.mid,@"gid":self.gid,@"logo":@"",@"storename":self.storename};
    //logo可能为空报错
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr==%@",xmlStr);
            //菊花消失
            [SVProgressHUD dismiss];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
                NSLog(@"=======商品信息555555555555555555555555555%@",dic);
            
            
            view.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {
                
                
                self.NotBuy=dict1[@"status"];
                
                self.NotBuyMessage=dict1[@"message"];
                
                
                
                if ([self.NotBuy isEqualToString:@"10001"]) {
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    
                }else if([self.NotBuy isEqualToString:@"10000"]){
                    
                    if ([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"0"]) {
                        
                        [JRToast showWithText:@"请等待，限购商品暂未开抢" duration:3.0f];
                        
                        
                    }else if([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"7"]) {
                        
                        [JRToast showWithText:@"该商品已结束抢购！" duration:3.0f];
                        
                        
                    }else if([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"6"]) {
                        
                        [JRToast showWithText:@"该商品已售完！" duration:3.0f];
                        
                        
                    }else if([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"1"]) {
                        
                        [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                        
                        
                    }else if([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"5"]) {
                        
                        [JRToast showWithText:@"该商品已删除！" duration:3.0f];
                        
                        
                    }else{
                        
                        if ([self.stock isEqualToString:@"0"]) {
                            
                            [JRToast showWithText:@"库存为0，无法购买" duration:3.0f];
                            
                            
                        }else{
                            QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
                            
                            //    NewAddAddressViewController *vc=[[NewAddAddressViewController alloc] init];
                            
                            vc.gid=self.gid;
                            
                            vc.sigen=self.sigen;
                            
                            vc.storename=self.storename;
                            
                            vc.logo=self.logo;
                            
                            vc.GoodsDetailType=self.SendWayType;
                            
                            vc.Goods_Type_Switch=self.good_type;
                            
                            vc.SendWayType=self.SendWayType;
                            
                            vc.MoneyType=self.MoneyType;
                            
                            vc.midddd=self.mid;
                            
                            vc.yunfei=self.yunfei;
                            
                            
                            NSLog(@"===1111==&&&&===%@",self.exchange);
                    if ([self.Panduan integerValue]==2) {
                        vc.attributenum = self.num;
                        vc.exchange = self.exchange;
                        vc.detailId = self.detailId;
                        if (self.detailId.length != 0) {
                                    
                            [self.navigationController pushViewController:vc animated:NO];
                                    
                                self.navigationController.navigationBar.hidden=YES;
                            }
                        
                        }else if([self.attribute integerValue]!=2 ){
                            vc.exchange = self.exchange2;
                            
                            NSLog(@"===222222==&&&&===%@",self.exchange2);
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            self.navigationController.navigationBar.hidden=YES;
                            
                        }
                    }
                }
            }
        }
            
            NSLog(@"++++++self.NotBuy++++++%@",self.NotBuy);
            NSLog(@"++++++self.NotBuyMessage++++++%@",self.NotBuyMessage);
            [_tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}


//立即购买
- (IBAction)GoBuyingBtnClick:(UIButton *)sender {
    
    
    NSNull *null=[[NSNull alloc] init];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    NSLog(@">>>>>>%@",self.sigen);
    
    
    
    if(_datasArrM.count !=0){
    
    if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
        
//        NewLoginViewController *vc=[[NewLoginViewController alloc] init];
        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
        vc.delegate=self;
        
        vc.backString=@"300";
        
        
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
    }else{
        
        [self getDatas1];
        
        NSLog(@"------TTTTTTT==%@==%@",self.Panduan,self.attribute);
        
        if ([self.Panduan integerValue]==2){
            
            if (self.detailId.length != 0)
            {
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
//                [SVProgressHUD showWithStatus:@"请耐心等待..."];
//                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    
//                    [SVProgressHUD dismiss];
//                    
//                });
                
            }
        }else if([self.attribute integerValue]!=2 ){
//            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
//            [SVProgressHUD showWithStatus:@"请耐心等待..."];
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//
//                
//            });
            
        }else{
            
            [SVProgressHUD dismiss];
            [self initview];
            [goodsMainview show];
        }

        
        NSLog(@"++++++self.NotBuy++++++%@",self.NotBuy);
        
    }
  }
}

//时间转换
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

-(void)DaoJiTime
{
    //日期转换为时间戳 (日期转换为秒数)
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
    
    //当前时间
        NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
    
    //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
    NSDate *date2 = [dateFormatter dateFromString:self.endString];
    
    NSDate *date4 = [dateFormatter dateFromString:self.startString];
    
    
    NSLog(@">>>>>>>>>%@",self.endString);
    NSLog(@">>>>>>>>>%@",self.startString);
    
    NSDate *num1 = [self getNowDateFromatAnDate:date3];
    
    NSDate *num2=[self getNowDateFromatAnDate:date2];
    
    NSDate *num3=[self getNowDateFromatAnDate:date4];
    
    NSLog(@"=========当前日期为:%@",num1);
    NSLog(@"=========结束日期为:%@",num2);
    
    NSTimeInterval hh1= [num1 timeIntervalSince1970];
    
    NSTimeInterval hh2 = [num2 timeIntervalSince1970];
    
    NSTimeInterval hh3 = [num3 timeIntervalSince1970];
    
    
    
    NSInteger times;
    
    
    
    if ([self.good_type isEqualToString:@"1"]) {
        
        if ([self.status isEqualToString:@"4"]) {
            
            times=(NSInteger)(hh2 - hh1);
            NSLog(@"--------->%ld",times);
            
        }else if ([self.status isEqualToString:@"0"]){
            
            times=(NSInteger)(hh3 - hh1);
            NSLog(@"--------->%ld",times);
        }
    }
    
    if (times<=0) {
        
        if ([self.status isEqualToString:@"4"]) {
            
            label2.hidden=YES;
            self.timeLabel.hidden=YES;
            
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(fwidth/4, 25, fwidth-fwidth/2-fwidth/25, 30)];
            
            label.text=@"已停止抢购";
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
            
            [topView insertSubview:label aboveSubview:self.view];
        }else if ([self.status isEqualToString:@"0"]){
            
            self.timeLabel.hidden=YES;
            label2.hidden=YES;
            
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(fwidth/4, 25, fwidth-fwidth/2-fwidth/25, 30)];
            label.text=@"已开始抢购";
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
            
            [topView insertSubview:label aboveSubview:self.view];
        }
        
    }else{
        
        GGClockView *clockView = [[GGClockView alloc] init];
        clockView.frame = self.timeLabel.frame;
        
        clockView.time = times;
        [self.view addSubview:clockView];
        self.clockView = clockView;
    }
    
}


- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    topView.hidden=YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
        
        topView.hidden=NO;
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
        
    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    [_tableView reloadData];
    
}

+ (CGFloat )systemVersion{
    
    NSString *sVersion = [[UIDevice currentDevice] systemVersion];
    
    NSRange fRange = [sVersion rangeOfString:@"."];
    
    
    CGFloat version = 0.0f;
    
    if(fRange.location != NSNotFound){
        sVersion = [sVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSMutableString *mVersion = [NSMutableString stringWithString:sVersion];
        [mVersion insertString:@"." atIndex:fRange.location];
        version = [mVersion floatValue];
    }else {
        // 版本应该有问题(由于ios 的版本 是7.0.1，没有发现出现过没有小数点的情况)
        version = [sVersion floatValue];
    }
    
    return version;
}
@end
