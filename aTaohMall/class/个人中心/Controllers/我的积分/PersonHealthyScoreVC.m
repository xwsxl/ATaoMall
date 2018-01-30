//
//  PersonHealthyScoreVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/10.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonHealthyScoreVC.h"

#import "NewScoreHeaderView.h"

#import "NewScoreCell.h"


#import "AFNetworking.h"

//加密
#import "DESUtil.h"
#import "ConverUtil.h"
#import "SecretCodeTool.h"

#import "MyScoreModel.h"

#import "UIImageView+WebCache.h"

#import "UserMessageManager.h"

#import "WKProgressHUD.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "XSInfoView.h"
#import "HomeLookFooter.h"//点击加载更多

#import "NoScoreCell.h"
@interface PersonHealthyScoreVC ()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate,FooterViewDelegate,NewScoreHeaderViewDelegate>
{

    UITableView *_tableView;

    UILabel *_label;

    UIView *view;


    UILabel *label1;
    UILabel *label2;
    UILabel *label3;

    UIButton *button1;
    UIButton *button2;
    UIButton *button3;

    UIImageView *fenge;

    NSMutableArray *_datasArr1;//获取全部数据

    NSMutableArray *_datasArr2;//收入

    NSMutableArray *_datasArr3;//支出

    NewScoreHeaderView *header;

    HomeLookFooter *footer;

    int num;
    int bo;//用来判断点击的是哪一个；
    NSString *string10;

    UIView *NOView;

    UILabel *noData;


}
@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic,strong)UIButton *MyScoreBut;
@property (nonatomic,strong)UIButton *HealthyScoreBut;
@end

@implementation PersonHealthyScoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.YTString = @"1";

    self.type = @"0";

    self.sigen=[kUserDefaults objectForKey:@"sigen"];
    self.flag=@"1";

    self.PanDuan=@"0";

    bo=1;

    num=1;
    _datasArr1=[NSMutableArray new];

    _datasArr2=[NSMutableArray new];

    _datasArr3=[NSMutableArray new];
    self.view.frame=[UIScreen mainScreen].bounds;
    [self InitNavi];
    [self initTableView];


    [self getData];
    [self setTop];
}
-(void)setTop
{
    fenge=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 1)];

    fenge.image=[UIImage imageNamed:@"分割线-拷贝"];

    [self.view addSubview:fenge];

    view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];

    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];

    view.hidden=YES;

    fenge.hidden=YES;

    label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40)];
    label1.text=@"全部";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    label1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:16];

    [view addSubview:label1];

    button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40);

    [view addSubview:button1];

    [button1 addTarget:self action:@selector(BtnClick1) forControlEvents:UIControlEventTouchUpInside];



    UIImageView *line1=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/3, 6, 1, 28)];
    line1.image=[UIImage imageNamed:@"分割线YT"];

    [view addSubview:line1];


    label2=[[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/3+1, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40)];
    label2.text=@"收入";
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:16];

    [view addSubview:label2];


    button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/3+1, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40);

    [view addSubview:button2];

    [button2 addTarget:self action:@selector(BtnClick2) forControlEvents:UIControlEventTouchUpInside];


    UIImageView *line2=[[UIImageView alloc] initWithFrame:CGRectMake(2*(([UIScreen mainScreen].bounds.size.width-2)/3)+1, 6, 1, 28)];
    line2.image=[UIImage imageNamed:@"分割线YT"];

    [view addSubview:line2];


    label3=[[UILabel alloc] initWithFrame:CGRectMake(2*(([UIScreen mainScreen].bounds.size.width-2)/3)+2, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40)];
    label3.text=@"支出";
    label3.textAlignment=NSTextAlignmentCenter;
    label3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label3.font=[UIFont fontWithName:@"PingFangSC-Regular" size:16];

    [view addSubview:label3];


    button3=[UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame=CGRectMake(2*(([UIScreen mainScreen].bounds.size.width-2)/3)+2, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 40);

    [view addSubview:button3];

    [button3 addTarget:self action:@selector(BtnClick3) forControlEvents:UIControlEventTouchUpInside];
}
-(void)getData
{


    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url = [NSString stringWithFormat:@"%@getUserHealthyIntegralList_mob.shtml",URL_Str];

    NSDictionary *dic = @{@"sigen":self.sigen,@"flag":self.flag,@"type":self.type};
    YLog(@"dic=%@",dic);
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"xmlStr%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic1= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"消费:=========%@",dic1);


            NOView.hidden=YES;

           // for (NSDictionary *dic1 in dic) {

                string10 = dic1[@"totalCount"];
                MyScoreModel *model=[[MyScoreModel alloc] init];
                model.integral=dic1[@"integral"];

                self.Score=dic1[@"integral"];

                //                NSLog(@"%@",dic1[@"status"]);
                //                NSLog(@"%@",dic1[@"message"]);

                self.status=dic1[@"status"];

                if ([self.status isEqualToString:@"10001"]) {

                    footer.hidden=YES;

                }else{

                    footer.hidden=NO;

                }
                for (NSDictionary *dict in dic1[@"integraldeductionlist"]) {
                    MyScoreModel *model=[[MyScoreModel alloc] init];


                    NSString *id=dict[@"id"];
                    NSString *ordernumber=dict[@"ordernumber"];

                    model.integral1=dict[@"integral"];

                    model.sysdate=dict[@"sysdate"];

                    model.id=id;
                    model.ordernumber=ordernumber;
                    model.type=dict[@"type"];

                    //                    if (bo==1) {

                    [_datasArr1 addObject:model];

                    //                    }



                    if ([dict[@"type"] isEqualToString:@"1"] || [dict[@"type"] isEqualToString:@"2"] || [dict[@"type"] isEqualToString:@"4"] || [dict[@"type"] isEqualToString:@"6"] || [dict[@"type"] isEqualToString:@"7"] || [dict[@"type"] isEqualToString:@"8"]) {

                        [_datasArr2 addObject:model];

                    }

                    if ([dict[@"type"] isEqualToString:@"0"] || [dict[@"type"] isEqualToString:@"3"] || [dict[@"type"] isEqualToString:@"5"] || [dict[@"type"] isEqualToString:@"9"] || [dict[@"type"] isEqualToString:@"10"]) {

                        [_datasArr3 addObject:model];

                    }

                }
         //   }

            //全部
            if (bo==1) {

                NSLog(@"11111111111");

                if (_datasArr1.count == 0) {

                    [noData removeFromSuperview];

                    [self NoDataText];
                    _refresh.topEnabled=NO;//下拉刷新
                    noData.hidden = NO;

                }else{

                    noData.hidden = YES;
                    _refresh.topEnabled=YES;


                }

                if (_datasArr1.count%12==0&&_datasArr1.count!=0&&_datasArr1.count !=[string10 integerValue]) {

                    footer.hidden=NO;
                    [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
                    footer.loadMoreBtn.enabled=YES;

                }else if (_datasArr1.count == [string10 integerValue]){
                    footer.hidden = NO;
                    footer.moreView.hidden=YES;
                    [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=NO;


                }else{

                    //隐藏点击加载更多
                    footer.hidden=YES;

                }

                //收入
            }else if (bo==2){

                NSLog(@"222222222222");
                if (_datasArr2.count == 0) {

                    [noData removeFromSuperview];
                    [self NoDataText];
                    _refresh.topEnabled=NO;//下拉刷新
                    noData.hidden = NO;

                }else{

                    noData.hidden = YES;
                    _refresh.topEnabled=YES;


                }

                if (_datasArr2.count%12==0&&_datasArr2.count!=0&&_datasArr2.count !=[string10 integerValue]) {

                    footer.hidden=NO;
                    [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];

                    footer.loadMoreBtn.enabled=YES;

                }else if (_datasArr2.count == [string10 integerValue]){
                    footer.hidden = NO;
                    footer.moreView.hidden=YES;
                    [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=NO;


                }else{

                    //隐藏点击加载更多
                    footer.hidden=YES;

                }

                //支出
            }else if (bo==3){

                NSLog(@"3333333333");
                if (_datasArr3.count == 0) {

                    [noData removeFromSuperview];

                    [self NoDataText];
                    _refresh.topEnabled=NO;//下拉刷新
                    noData.hidden = NO;

                }else{
                    _refresh.topEnabled=YES;

                    noData.hidden = YES;

                }


                if (_datasArr3.count%12==0&&_datasArr3.count!=0&&_datasArr3.count !=[string10 integerValue]) {

                    footer.hidden=NO;
                    [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
                    //                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=YES;

                }else if (_datasArr3.count == [string10 integerValue]){
                    footer.hidden = NO;
                    footer.moreView.hidden=YES;
                    [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=NO;


                }else{

                    //隐藏点击加载更多
                    footer.hidden=YES;

                }

            }


            if ([self.PanDuan isEqualToString:@"0"]) {


                //回到头部
                [_tableView setContentOffset:CGPointZero animated:NO];

            }else{



            }

            [hud dismiss:YES];


            [_tableView reloadData];


        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        //            [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];

        [self NoWebSeveice];

        NSLog(@"%@",error);
    }];


}

//暂无相关数据文案
-(void)NoDataText
{

    noData=[[UILabel alloc] initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width-100, 30)];
    noData.text=@"暂无相关数据";
    noData.textAlignment=NSTextAlignmentCenter;
    noData.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    noData.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.view addSubview:noData];


}

-(void)NoWebSeveice
{

    NOView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    NOView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];

    [self.view addSubview:NOView];


    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((NOView.frame.size.width-82)/2, 100, 82, 68)];

    image.image=[UIImage imageNamed:@"网络连接失败"];

    [NOView addSubview:image];


    UILabel *label11=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, NOView.frame.size.width-200, 20)];

    label11.text=@"网络连接失败";

    label11.textAlignment=NSTextAlignmentCenter;

    label11.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];

    label11.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];

    [NOView addSubview:label11];


    UILabel *label22=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, NOView.frame.size.width-200, 20)];

    label22.text=@"请检查你的网络";

    label22.textAlignment=NSTextAlignmentCenter;

    label22.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];

    label22.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];

    [NOView addSubview:label22];


    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];

    button.frame=CGRectMake(100, 250, NOView.frame.size.width-200, 50);

    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];

    [NOView addSubview:button];

    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];

}

-(void)loadData{

    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });

    [self getData];

}



-(void)BtnClick1
{
    [header BtnClick1];
}
-(void)BtnClick2
{
    [header BtnClick2];
}
-(void)BtnClick3
{
    [header BtnClick3];
}


- (void)AllScoreButClick:(UIButton *)sender{

    num=1;
    self.flag=[NSString stringWithFormat:@"%d",num];
    self.YTString = @"1";
    bo=1;
    self.PanDuan=@"0";
    label1.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];

    self.type=@"0";

    [_datasArr1 removeAllObjects];
    [_datasArr2 removeAllObjects];
    [_datasArr3 removeAllObjects];

    [self getData];

}

- (void)ShouRuScoreButClick:(UIButton *)sender{

    num=1;
    self.flag=[NSString stringWithFormat:@"%d",num];
    self.YTString = @"2";
    bo=2;
    self.PanDuan=@"0";
    label1.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label2.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    label3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];

    self.type=@"1";

    [_datasArr1 removeAllObjects];
    [_datasArr2 removeAllObjects];
    [_datasArr3 removeAllObjects];

    [self getData];


}


- (void)ZhiChuScoreButClick:(UIButton *)sender{

    num=1;
    self.flag=[NSString stringWithFormat:@"%d",num];
    self.YTString = @"3";
    bo=3;
    self.PanDuan=@"0";
    label1.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label3.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];

    
    self.type=@"2";

    [_datasArr1 removeAllObjects];
    [_datasArr2 removeAllObjects];
    [_datasArr3 removeAllObjects];

    [self getData];


}

-(void)initTableView
{

    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];

    _tableView.delegate=self;

    _tableView.dataSource=self;

    [self.view addSubview:_tableView];

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [_tableView registerNib:[UINib nibWithNibName:@"NewScoreCell" bundle:nil] forCellReuseIdentifier:@"cell1"];

    [_tableView registerNib:[UINib nibWithNibName:@"NoScoreCell" bundle:nil] forCellReuseIdentifier:@"noCell"];

    [_tableView registerNib:[UINib nibWithNibName:@"NewScoreHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];

    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"footer"];

    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
}

-(void)InitNavi
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    [titleView setBackgroundColor:[UIColor whiteColor]];
    titleView.userInteractionEnabled=YES;
    [self.view addSubview:titleView];

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];

    line.image = [UIImage imageNamed:@"分割线-拷贝"];

    [self.view addSubview:line];

    //返回按钮

    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];

    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);

    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];

    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2"] forState:UIControlStateNormal];
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2"] forState:UIControlStateSelected];
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:Qurt];

    //创建搜索

    self.MyScoreBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.MyScoreBut.frame=CGRectMake((kScreen_Width-72*2-Width(20))/2.0, 32+KSafeTopHeight, 72, 18);
    self.MyScoreBut.titleLabel.font=KNSFONTM(18);
    [self.MyScoreBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.MyScoreBut setTitle:@"我的积分" forState:UIControlStateNormal];

    self.HealthyScoreBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.HealthyScoreBut.frame=CGRectMake(kScreen_Width/2.0+Width(12), 34+KSafeTopHeight, 64, 17);
    self.HealthyScoreBut.titleLabel.font=KNSFONTM(16);
    [self.HealthyScoreBut setTitle:@"健康积分" forState:UIControlStateNormal];
    [self.HealthyScoreBut setTitleColor:RGBA(254, 254, 254, 0.5) forState:UIControlStateNormal];
    [self.HealthyScoreBut addTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:self.MyScoreBut];
    [titleView addSubview:self.HealthyScoreBut];

    //设置不自动调整导航栏布局和左滑退出手势不可用
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)selectorBMDan:(UIButton *)sender
{

    [UIView animateWithDuration:0.5 animations:^{
        self.MyScoreBut.titleLabel.font=KNSFONTM(16);
        self.MyScoreBut.frame=CGRectMake(kScreen_Width/2.0-63-Width(13), 34+KSafeTopHeight, 64, 17);
        [self.MyScoreBut setTitleColor:RGBA(244, 244, 244, 0.5) forState:UIControlStateNormal];

        self.HealthyScoreBut.frame=CGRectMake(kScreen_Width/2.0+10, 32+KSafeTopHeight, 72, 18);
        self.HealthyScoreBut.titleLabel.font=KNSFONTM(18);
        [self.HealthyScoreBut setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];

    } completion:^(BOOL finished) {

        [self.MyScoreBut addTarget:self action:@selector(selectorShoppingDan:) forControlEvents:UIControlEventTouchUpInside];
        [self.HealthyScoreBut removeTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];

    }];
}

-(void)selectorShoppingDan:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{

        self.MyScoreBut.frame=CGRectMake((kScreen_Width-72*2-Width(20))/2.0, 32+KSafeTopHeight, 72, 18);
        self.MyScoreBut.titleLabel.font=KNSFONTM(18);
        [self.MyScoreBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        self.HealthyScoreBut.frame=CGRectMake(kScreen_Width/2.0+Width(12), 34+KSafeTopHeight, 64, 17);
        self.HealthyScoreBut.titleLabel.font=KNSFONTM(16);
        [self.HealthyScoreBut setTitleColor:RGBA(254, 254, 254, 0.5) forState:UIControlStateNormal];

    } completion:^(BOOL finished) {
        [self.MyScoreBut removeTarget:self action:@selector(selectorShoppingDan:) forControlEvents:UIControlEventTouchUpInside];
        [self.HealthyScoreBut addTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    if ([self.YTString isEqualToString:@"1"]) {

        return _datasArr1.count;

    }else if ([self.YTString isEqualToString:@"2"]){

        return _datasArr2.count;

    }else{



        return _datasArr3.count;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 110;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 135;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.YTString isEqualToString:@"1"]) {

        if (_datasArr1.count==0) {

            NoScoreCell *cell=[tableView dequeueReusableCellWithIdentifier:@"noCell"];

            return cell;

        }else{

            NewScoreCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];


            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            MyScoreModel *model=_datasArr1[indexPath.row];

            cell.orderLabel.text=[NSString stringWithFormat:@"订单号：%@",model.ordernumber];

            cell.TimeLabel.text=[NSString stringWithFormat:@"时间：%@",model.sysdate];

            if ([model.type isEqualToString:@"0"]) {

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：购物使用"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"1"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：淘金广场 积分获得"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"2"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：斯迈尔转入积分"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"3"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：POS机消费"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"4"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：用户退货退款"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"5"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：对账"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"6"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：健康助手兑换"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"7"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：购物获得"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"8"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：推荐好友购物"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"9"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：退款退货"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"10"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：推荐好友退款退货"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }




            return cell;
        }


    }else if ([self.YTString isEqualToString:@"2"]){

        if (_datasArr2.count==0) {

            NoScoreCell *cell=[tableView dequeueReusableCellWithIdentifier:@"noCell"];

            return cell;

        }else{

            NewScoreCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;


            MyScoreModel *model=_datasArr2[indexPath.row];

            cell.orderLabel.text=[NSString stringWithFormat:@"订单号：%@",model.ordernumber];

            cell.TimeLabel.text=[NSString stringWithFormat:@"时间：%@",model.sysdate];

            if ([model.type isEqualToString:@"0"]) {

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：购物使用"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"1"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：淘金广场 积分获得"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"2"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：斯迈尔转入积分"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"3"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：POS机消费"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"4"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：用户退货退款"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"5"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：对账"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"6"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：健康助手兑换"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"7"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：购物获得"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"8"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：推荐好友购物"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"9"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：退款退货"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"10"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：推荐好友退款退货"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }


            return cell;

        }


    }else{


        if (_datasArr3.count==0) {

            NoScoreCell *cell=[tableView dequeueReusableCellWithIdentifier:@"noCell"];

            return cell;

        }else{

            NewScoreCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;


            MyScoreModel *model=_datasArr3[indexPath.row];

            cell.orderLabel.text=[NSString stringWithFormat:@"订单号：%@",model.ordernumber];

            cell.TimeLabel.text=[NSString stringWithFormat:@"时间：%@",model.sysdate];

            if ([model.type isEqualToString:@"0"]) {

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：购物使用"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"1"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：淘金广场 积分获得"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"2"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：斯迈尔转入积分"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"3"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：POS机消费"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"4"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：用户退货退款"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"5"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：对账"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"6"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：健康助手兑换"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"7"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：购物获得"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"8"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：推荐好友购物"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"+%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"9"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：退款退货"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }else if ([model.type isEqualToString:@"10"]){

                cell.TypeLabel.text=[NSString stringWithFormat:@"详细说明：推荐好友退款退货"];
                cell.MoneyLabel.text=[NSString stringWithFormat:@"-%.02f",[model.integral1 floatValue]];

            }

            return cell;

        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    header.Score=self.Score;
    header.delegate=self;
    return header;

}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 44;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= 80) {

        //        _label.hidden = NO;

        view.hidden = NO;
        fenge.hidden=NO;

    }else{


        //        _label.hidden = YES;

        view.hidden = YES;
        fenge.hidden=YES;

    }
}


- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    _tableView.scrollEnabled=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });

}

- (void)addDataWithDirection:(DJRefreshDirection)direction{

    if (direction==DJRefreshDirectionTop) {
        self.flag=@"1";
        num = 1;
        [_datasArr1 removeAllObjects];
        [_datasArr2 removeAllObjects];
        [_datasArr3 removeAllObjects];
        [self getData];
        [_tableView reloadData];
        _tableView.scrollEnabled=YES;
    }
    [_refresh finishRefreshingDirection:direction animation:YES];
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];

    footer.delegate=self;

    if(_datasArr1.count==0 && bo == 1){
        footer.hidden = YES;
    }
    if(_datasArr2.count==0 && bo == 2){
        footer.hidden = YES;
    }

    if(_datasArr3.count==0 && bo == 3){
        footer.hidden = YES;
    }

    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{

    //    NSLog(@"点击加载更多");

    self.PanDuan=@"1";

    num=num+1;

    self.flag=[NSString stringWithFormat:@"%d",num];
    //获取数据


    [self getData];


}
@end

