//
//  XLPersonalDingDanVC.m
//  aTaohMall
//
//  Created by Hawky on 2018/2/27.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLPersonalDingDanVC.h"

#import "PersonalShoppingDanCell.h"
#import "PersonalShoppingSectionHeaderView.h"
#import "PersonalShoppingSectionFooterView.h"

//店铺
#import "MerchantDetailViewController.h"
//订单详情
#import "PersonalShoppingDanDetailVC.h"
//物流
#import "PersonalLogisticsDetailVC.h"
#import "PersonalTwoOrMoreLogisticsDetailVC.h"
//申请退款
#import "PersonalShoppingReplyRefundVC.h"
#import "PersonalShoppingRefundTypeVC.h"
#import "PersonalShoppingRefundDanDetailVC.h"
//协商记录
#import "ConsultNounVC.h"
#import "XLDingDanModel.h"
#import "XLShoppingModel.h"


#import "PersonalBMDetailVC.h"
//店铺
#import "BMNewGameAndPhoneViewController.h"
#import "BMPlaneAndTrainViewController.h"
#import "PeccantViewController.h"
//退款
#import "TrainToReturnMoneyViewController.h"
#import "AirApplyRefundVC.h"

#import "PersonalBMDanCell.h"

#import "BianMinModel.h"

#import "BMDanModel.h"

#import "SearchManager.h"
@interface XLPersonalDingDanVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,PersonalShoppingSectionFooterViewDelegate,PersonalShoppingSectionHeaderViewDelegate,PersonalShoppingDanCellDelegat,PersonalShoppingDanDetailVCDelegate,PersonalBMDanCellDelegate,PersonalBMDetailVCDelegate>
{


    UIScrollView *_scroll;
    UITableView *_tableView;
    UIView *nodataView;

    UIButton *qurtBtn;
    UIButton *rightBtn;

    NSMutableArray *_dataSource;

    NSArray *_searchHistoryArr;

    NSInteger totalCount;

    NSString *_searchKeyWord;//顶部搜索词
    int flag;

    XLDingDanModel *selectModel;
    BMDanModel *SelectModel;


}
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *searchBackView;
@property (strong, nonatomic) IBOutlet UIImageView *searchIcon1;
@property (strong, nonatomic) IBOutlet UIButton *cancleBut;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic,assign)NSInteger page;
@end

@implementation XLPersonalDingDanVC

static NSString * const XLConstPersonalShoppingDanCell=@"PersonalShoppingDanCell";
static NSString * const XLConstPersonalShoppingSectionHeaderView=@"PersonalShoppingSectionHeaderView";
static NSString * const XLConstPersonalShoppingSectionFooterView=@"PersonalShoppingSectionFooterView";

/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    _dataSource=[NSMutableArray new];
    // Do any additional setup after loading the view.
}
/*******************************************************      数据请求       ******************************************************/

-(void)getDatas
{
//0商品、1便民
    YLog(@"%@-----",self.ISKindOfShop);
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
        [self getShopData];
    }else
    {
        [self getBMData];
    }

}

//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_dataSource.count) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {

        [self getDatas];
    }
}
//下拉刷新数据
-(void)refreshData
{
    self.page=0;
    [self getDatas];
}
//加载数据
-(void)getShopData
{

    //sigen值为获取用户id page表示分页、status表示状态、空:全部订单，7:代付款订单，0:待发货订单,1:待收货订单,2:交易完成订单
   NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page],@"search_term":_searchKeyWord};

    WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:nil animated:YES];
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];


    YLog(@"params=%@",params);
    NSString *url = [NSString stringWithFormat:@"%@orderSearch_mob.shtml",URL_Str];

  //  NSDictionary *dic = @{@"word":_searchKeyWord,@"flag":[NSString stringWithFormat:@"%d",flag]};

    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        if (codeKey && content) {

            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"xmlStr=%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *responseObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];


            NSLog(@"=====搜索结果===%@",responseObj);

         if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            if ([params[@"page"] isEqualToString:@"0"]) {
                [_dataSource removeAllObjects];

            }
            self.page++;
            NSArray *tempArr=responseObj[@"order_list"];
            totalCount=[responseObj[@"totalCount"] integerValue];
            for (NSDictionary *orderDic in tempArr) {
                XLDingDanModel *model=[XLDingDanModel new];
                [model goodsOrderListFromArray:orderDic[@"goods_order_list"]];
                model.logo=[NSString stringWithFormat:@"%@",orderDic[@"logo"]];
                model.mid=[NSString stringWithFormat:@"%@",orderDic[@"mid"]];
                model.order_batchid=[NSString stringWithFormat:@"%@",orderDic[@"order_batchid"]];
                model.storename=[NSString stringWithFormat:@"%@",orderDic[@"storename"]];
                model.total_freight=[NSString stringWithFormat:@"%@",orderDic[@"total_freight"]];
                model.total_integral=[NSString stringWithFormat:@"%@",orderDic[@"total_integral"]];
                model.total_money=[NSString stringWithFormat:@"%@",orderDic[@"total_money"]];
                model.total_number_goods=[NSString stringWithFormat:@"%@",orderDic[@"total_number_goods"]];
                model.total_status=[NSString stringWithFormat:@"%@",orderDic[@"total_status"]];
                [_dataSource addObject:model];
            }
            if (_dataSource.count==0) {
                [self initview];
            }else
            {
                //[self];
                [_tableView reloadData];
            }


        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];

        [hud dismiss:YES];


        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];

        [hud dismiss:YES];
    }];

}
//
-(void)getBMData
{
    //sigen值为获取用户id page表示分页、status表示状态、空:全部订单，7:代付款订单，0:待发货订单,1:待收货订单,2:交易完成订单
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page],@"search_term":_searchKeyWord};



    WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:nil animated:YES];
    // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];



    NSString *url = [NSString stringWithFormat:@"%@orderSearchToBM_mob.shtml",URL_Str];

   // NSDictionary *dic = @{@"word":_searchKeyWord,@"flag":[NSString stringWithFormat:@"%d",flag]};

    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        if (codeKey && content) {

            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"xmlStr=%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *responseObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];


            NSLog(@"=====搜索结果===%@",responseObj);

            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                if ([params[@"page"] isEqualToString:@"0"]) {
                    [_dataSource removeAllObjects];

                }
                self.page++;
                NSArray *tempArr=responseObj[@"resList"];
                totalCount=[responseObj[@"total_count"] integerValue];
                for (NSDictionary *orderDic in tempArr) {
                    BMDanModel *model=[[BMDanModel alloc] init];
                    model.airport_flight = [NSString stringWithFormat:@"%@",orderDic[@"airport_flight"]];
                    model.airport_name =[NSString stringWithFormat:@"%@",orderDic[@"airport_name"]];
                    model.getdate = [NSString stringWithFormat:@"%@",orderDic[@"getdate"]];
                    model.ID = [NSString stringWithFormat:@"%@",orderDic[@"id"]];
                    model.name = [NSString stringWithFormat:@"%@",orderDic[@"name"]];
                    model.number =[NSString stringWithFormat:@"%@",orderDic[@"number"]];
                    model.order_type = [NSString stringWithFormat:@"%@",orderDic[@"order_type"]];
                    model.orderno = [NSString stringWithFormat:@"%@",orderDic[@"orderno"]];
                    model.pay_integral = [NSString stringWithFormat:@"%@",orderDic[@"pay_integral"]];
                    model.pay_money =[NSString stringWithFormat:@"%@",orderDic[@"pay_money"]];
                    model.pay_order = [NSString stringWithFormat:@"%@",orderDic[@"pay_order"]];
                    model.pay_status =[NSString stringWithFormat:@"%@",orderDic[@"pay_status"]];
                    model.payintegral = [NSString stringWithFormat:@"%@",orderDic[@"payintegral"]];
                    model.paymoney = [NSString stringWithFormat:@"%@",orderDic[@"paymoney"]];
                    model.phone = [NSString stringWithFormat:@"%@",orderDic[@"phone"]];
                    model.remark = [NSString stringWithFormat:@"%@",orderDic[@"remark"]];
                    model.scopeimg = [NSString stringWithFormat:@"%@",orderDic[@"scopeimg"]];
                    model.service_charge = [NSString stringWithFormat:@"%@",orderDic[@"service_charge"]];
                    model.start_time = [NSString stringWithFormat:@"%@",orderDic[@"start_time"]];
                    model.state =[NSString stringWithFormat:@"%@",orderDic[@"state"]];
                    model.status = [NSString stringWithFormat:@"%@",orderDic[@"status"]];
                    model.storename = [NSString stringWithFormat:@"%@",orderDic[@"storename"]];
                    model.che_type = [NSString stringWithFormat:@"%@",orderDic[@"che_type"]];
                    model.checi = [NSString stringWithFormat:@"%@",orderDic[@"checi"]];
                    model.CarNo = [NSString stringWithFormat:@"%@",orderDic[@"carNo"]];
                    model.total_deductPoint = [NSString stringWithFormat:@"%@",orderDic[@"total_deductPoint"]];
                    model.uid = [NSString stringWithFormat:@"%@",orderDic[@"uid"]];
                    model.total_fine = [NSString stringWithFormat:@"%@",orderDic[@"total_fine"]];
                    model.is_refund=[NSString stringWithFormat:@"%@",orderDic[@"is_refund"]];
                    [_dataSource addObject:model];
                }
                if (_dataSource.count==0) {
                    [self initview];
                }else
                {
                    //[self];
                    [_tableView reloadData];
                }


            }else
            {
                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
            }
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];

            [hud dismiss:YES];


        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];

        [hud dismiss:YES];
    }];

}
/*******************************************************      初始化视图       ******************************************************/

-(void)initUI
{
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    self.view.frame=[UIScreen mainScreen].bounds;
    [self.view setBackgroundColor:RGBA(0, 0, 0, 0.4)];
    [self initNavi];
    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
    _scroll.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scroll];
   // [self initScrollView];
    [self readNSUserDefaults];
    [self initTableView];
}

-(void)initNavi
{

    self.searchTextField=[[UITextField alloc] init];
    self.searchBackView=[[UIImageView alloc] init];
    self.searchIcon1=[[UIImageView alloc] init];
    [self.searchBackView setImage:KImage(@"搜索长框")];
    [self.searchIcon1 setImage:KImage(@"xl-Search Icon")];
    _navView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight)];
    _navView.backgroundColor=[UIColor whiteColor];

    [_navView addSubview:self.searchBackView];
    [_navView addSubview:self.searchIcon1];
    [_navView addSubview:self.searchTextField];

    self.searchBackView.frame=CGRectMake(15, 27+KSafeTopHeight, kScreen_Width-30-30-10, 32);
    self.searchIcon1.frame=CGRectMake(30, 37+KSafeTopHeight, 14, 14);
    self.searchTextField.frame=CGRectMake(30+14+5, 34+KSafeTopHeight, kScreen_Width-30-14-5-30-15-10-15, 20);
    self.searchTextField.placeholder=@"可搜索订单号/商品名称";
    self.searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.searchTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    self.searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchTextField.contentVerticalAlignment=NSTextAlignmentCenter;
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.01)];
    self.searchTextField.inputAccessoryView=customView;

    self.searchTextField.delegate = self;
    self.searchTextField.font=KNSFONT(14);

    
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreen_Width-15-30, 28+KSafeTopHeight, 30, 30);
   // [rightBtn setImage:KImage(@"xl-btn-change2") forState:UIControlStateNormal];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateNormal];
    rightBtn.titleLabel.font=KNSFONT(15);
    [rightBtn addTarget:self action:@selector(qurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
  //  rightBtn.hidden=YES;
    [_navView addSubview:rightBtn];
    [self.view addSubview:_navView];

    UIImageView *Line=[[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, kScreen_Width, 1)];
    Line.image=KImage(@"分割线-拷贝");
    [_navView addSubview:Line];

}

-(void)initScrollView
{
    CGFloat leading=Width(12);
    CGFloat butHeight=29;
    CGFloat top=Width(15);

    CGFloat height=0;

    [_scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    /*历史搜索*/
    if (_searchHistoryArr.count>0) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(leading, height+top, 70, 15)];
        lab.font=KNSFONTM(15);
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"历史搜索";
        [_scroll addSubview:lab];

        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(kScreen_Width-top-30, top+height-14, 44, 44);
        [but setImage:KImage(@"xl-垃圾桶") forState:UIControlStateNormal];
        [but addTarget:self action:@selector(deleteAllSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:but];
        height+=top+15+leading;
        CGFloat width=leading;
        CGFloat buttonWith=20;
        for (int i=0; i<_searchHistoryArr.count; i++) {
            NSString *str=_searchHistoryArr[i];

            CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:KMAXSIZE];

            if (width+size.width+buttonWith+leading>kScreenWidth) {
                if (leading+size.width+buttonWith+leading>kScreenWidth) {
                    size=CGSizeMake(kScreen_Width-2*leading-buttonWith, 14);

                }
                if (width==leading) {

                }else
                {
                    width=leading;
                    height+=leading+29;
                }
            }

            UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
            but.frame=CGRectMake(width, height, buttonWith+size.width, butHeight);
            width+=buttonWith+size.width+leading;
            [but.titleLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
            [but setTitle:str forState:UIControlStateNormal];
            [but addTarget:self action:@selector(clickHistoryBtn:) forControlEvents:UIControlEventTouchUpInside];
            but.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);//上，左，下，右
            but.tag=1400+i;
            [but.layer setCornerRadius:3];
            [but setBackgroundColor:RGB(245, 245, 245)];
            [but setTitleColor:RGB(74, 74, 74) forState:UIControlStateNormal];
            but.titleLabel.font=KNSFONT(14);
            [_scroll addSubview:but];
        }
        height+=Width(3)+leading+29;
    }
    _scroll.contentSize=CGSizeMake(kScreen_Width, height);
}
//初始化表视图
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    NSLogRect(self.view.frame);
    _tableView.hidden=YES;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;

    [_tableView registerClass:[PersonalShoppingDanCell class] forCellReuseIdentifier:XLConstPersonalShoppingDanCell];

    [_tableView registerClass:[PersonalShoppingSectionHeaderView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingSectionHeaderView];
    [_tableView registerClass:[PersonalShoppingSectionFooterView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingSectionFooterView];
    [_tableView registerClass:[PersonalBMDanCell class] forCellReuseIdentifier:@"cell"];

    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
    _tableView.mj_footer = footer;

    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshStatePulling];

    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];

    _tableView.mj_header=header;
    [self.view addSubview:_tableView];

}
//
-(void)initview{
    if (!nodataView) {
        nodataView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
        [self.view addSubview:nodataView];
        nodataView.backgroundColor=[UIColor whiteColor];

        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-90)/2, (kScreenHeight-KSafeAreaTopNaviHeight-100-20)/2-KSafeAreaTopNaviHeight, 90, 90)];
        IV.image=[UIImage imageNamed:@"xl-img-empty"];
        [nodataView addSubview:IV];

        UILabel * _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,(kScreenHeight-KSafeAreaTopNaviHeight-100-20)/2+100-KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 20)];
        _lable.font=KNSFONT(15);
        _lable.text = @"还没查询到相关订单";
        _lable.tag = 100;
        _lable.textColor =RGB(74,74,74);
        _lable.textAlignment = NSTextAlignmentCenter;
        [nodataView addSubview:_lable];
    }else
    {
        nodataView.hidden=NO;
        _tableView.hidden=YES;
        _scroll.hidden=YES;
    }

}

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//
-(void)qurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
}
//
-(void)changeValue:(UITextField *)tf
{
    if (tf.text.length==0) {
        _tableView.hidden=YES;
        nodataView.hidden=YES;
        _scroll.hidden=NO;
    }
}
//点击历史记录
-(void)clickHistoryBtn:(UIButton *)sender
{
    NSString *str=_searchHistoryArr[sender.tag-1400];
    [self searchText:str];
}
//删除全部
- (void)deleteAllSearch:(id)sender {

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"确定删除全部历史搜索记录？" preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SearchManager removeAllDingDanArray];
        _searchHistoryArr=@[];
        [self initScrollView];
    }]];
    [self presentViewController:alert animated:YES completion:^{

    }];

}
/*******************************************************      协议方法       ******************************************************/
//确定搜索
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchText:textField.text];
    return YES;
}


-(void)PayCallBack:(NSNotification *)text
{
    [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
        if ([self.ISKindOfShop isEqualToString:@"0"]) {
            PersonalShoppingDanDetailVC *VC=[[PersonalShoppingDanDetailVC alloc] init];
            VC.myDingDanModel=selectModel;
            [self.navigationController pushViewController:VC animated:NO];
        }else
        {
            PersonalBMDetailVC *VC=[[PersonalBMDetailVC alloc] initWithOrderBatchid:SelectModel.orderno AndOrderType:SelectModel.order_type];
            [self.navigationController pushViewController:VC animated:NO];
        }
        [self refreshData];

    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){

        [TrainToast showWithText:@"正在处理中" duration:2.0f];


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){


        [TrainToast showWithText:@"订单支付失败" duration:2.0f];

    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){

        [TrainToast showWithText:@"网络连接出错" duration:2.0f];
    }

}

#pragma mark-表视图协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
        XLDingDanModel *model=_dataSource[section];
        return model.goods_order_list.count;
    }else
    {
        return 1;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
        XLDingDanModel *model=_dataSource[indexPath.section];
        XLShoppingModel *shopModel=model.goods_order_list[indexPath.row];
        shopModel.totalStatus=model.total_status;
        PersonalShoppingDanCell *cell=[tableView dequeueReusableCellWithIdentifier:XLConstPersonalShoppingDanCell forIndexPath:indexPath];
        [cell loadData:shopModel];
        cell.delegate=self;
        return cell;
    }else
    {
        PersonalBMDanCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell loadDataWithModel:_dataSource[indexPath.section]];
        cell.delegate=self;
        return cell;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
        PersonalShoppingSectionHeaderView *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:XLConstPersonalShoppingSectionHeaderView];
        XLDingDanModel *model=_dataSource[section];
        view.dataModel=model;
        view.delegate=self;
        return view;
    }else
    {
        return  [[UIView alloc] init];
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
        PersonalShoppingSectionFooterView *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:XLConstPersonalShoppingSectionFooterView];
        view.dataModel=_dataSource[section];
        view.delegate=self;
        return view;
    }else
    {
        return [[UIView alloc] init];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
        XLDingDanModel *model=_dataSource[indexPath.section];
        //只有一个商品直接返回默认值

        XLShoppingModel *shopModel=model.goods_order_list[indexPath.row];
        return shopModel.cellHeight;
    }else
    {
        BMDanModel *model=_dataSource[indexPath.section];
        YLog(@"%.2f,%@",model.cellHeight,model.ID);
        return [model getCellHeight];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
        return 14+Height(28);
    }else
    {
        return 0.01;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
    XLDingDanModel *model=_dataSource[section];
    return model.sectionFootHeight;
    }else
    {
     return 10;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.ISKindOfShop isEqualToString:@"0"]) {
        XLDingDanModel *model=_dataSource[indexPath.section];
        PersonalShoppingDanDetailVC *vc=[[PersonalShoppingDanDetailVC alloc] init];
        vc.myDingDanModel=model;
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:NO];
    }else
    {

    }


}

#pragma mark-脚视图协议
//退款、退款退货
-(void)refundMoneyWithModel:(XLDingDanModel *)model
{
    XLShoppingModel *shopmodel=model.goods_order_list.firstObject;

    [self refundSingleShoppingWithModel:shopmodel Cell:nil];
    YLog(@"退款");
}
//继续付款
-(void)continuePayWithModel:(XLDingDanModel *)model
{

    YLog(@"继续付款");
    selectModel=model;
    //app付款回调
    [KNotificationCenter addObserver:self selector:@selector(PayCallBack:) name:JMSHTPayCallBack object:nil];
    [[AliPayRequestTools shareAlipayTool] ContinuePayWithOrderNum:model.order_batchid OnViewController:self AndResponseSuccess:^(NSDictionary *responseObj) {


        if ([responseObj[@"resultStatus"] isEqualToString:@"9000"]) {
            PersonalShoppingDanDetailVC *VC=[[PersonalShoppingDanDetailVC alloc] init];
            VC.myDingDanModel=selectModel;
            [self.navigationController pushViewController:VC animated:NO];


                [self refreshData];


        }
        [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    } failed:^(NSError *error) {
        [self refreshData];
        [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    }];
}
//查看物流
-(void)checkLogisticInfoWithModel:(XLDingDanModel *)mdoel
{
    NSDictionary *params=@{@"order_batchid":mdoel.order_batchid};
    //检查包裹个数判断去哪个页面
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    [ATHRequestManager requestforGetLogisticsNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            NSInteger logisticNum=[responseObj[@"total_count"] integerValue];
            //单个包裹
            if (logisticNum==1) {
                PersonalLogisticsDetailVC *VC=[[PersonalLogisticsDetailVC alloc] init];
                VC.model=mdoel;
                [self.navigationController pushViewController:VC animated:NO];

            }else
            {
                PersonalTwoOrMoreLogisticsDetailVC *VC=[[PersonalTwoOrMoreLogisticsDetailVC alloc] init];
                VC.model=mdoel;
                [self.navigationController pushViewController:VC animated:NO];
            }
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshData];
            });
        }
        [hud dismiss:YES];
    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
    }];
    YLog(@"查看物流");
}
//确认收货
-(void)sureReceiveWithModel:(XLDingDanModel *)model
{
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"order_batchid":model.order_batchid};
    //调查询接口是否可以确认收货
    [ATHRequestManager requestforCheckSureReceiveGoodsWithParams:params successBlock:^(NSDictionary *responseObj) {
        //10000为可以确认收货、有确定按钮
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                 cancelTitle:@"取消" titleArray:@[@"确认"] viewController:self confirm:^(NSInteger buttonTag) {
                                     //点击了确认收货调确认收货接口
                                     if (buttonTag==0) {

                                         [ATHRequestManager requestforSureReceiveGoodsWithParams:params successBlock:^(NSDictionary *responseObj) {
                                             if ([responseObj[@"status"] isEqualToString:@"10000"]) {

                                                 PersonalShoppingDanDetailVC *vc=[[PersonalShoppingDanDetailVC alloc] init];
                                                 vc.myDingDanModel=model;
                                                 [self.navigationController pushViewController:vc animated:NO];

                                                     [self refreshData];

                                             }
                                             else
                                             {
                                                 [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                                                      cancelTitle:@"关闭" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                                                                          [self refreshData];
                                                                      }];
                                             }
                                         } faildBlock:^(NSError *error) {

                                         }];
                                     }
                                 }];
        }else
        {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                 cancelTitle:@"关闭" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                                     [self refreshData];
                                 }];
        }

    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:error.localizedDescription duration:2.0];
    }];


}
//删除订单
-(void)deleteDingDanWithModel:(XLDingDanModel *)model
{

    [UIAlertTools showAlertWithTitle:@"" message:@"确认要删除此订单吗？"
                         cancelTitle:@"取消" titleArray:@[] viewController:self confirm:^(NSInteger buttonTag) {
                             if (buttonTag==0) {
                                 YLog(@"删除订单");
                                 NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"order_batchid":model.order_batchid};
                                 [ATHRequestManager requestforDelNotPayOrderWithParams:params successBlock:^(NSDictionary *responseObj) {
                                     if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                                         NSUInteger index=[_dataSource indexOfObject:model];
                                         [_dataSource removeObject:model];
                                         [_tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationRight];
                                     }else
                                     {
                                         [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                             [self refreshData];
                                         });

                                     }
                                 } faildBlock:^(NSError *error) {

                                 }];
                             }
                         }];
}

//查看订单详情
-(void)checkDanDetailWithModel:(XLDingDanModel *)model
{
    PersonalShoppingDanDetailVC *vc=[[PersonalShoppingDanDetailVC alloc] init];
    vc.myDingDanModel=model;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark-头视图协议
-(void)checkStoreDetailWithModel:(XLDingDanModel *)model
{
    YLog(@"店铺详情");
    MerchantDetailViewController *vc=[[MerchantDetailViewController alloc] init];
    vc.mid=model.mid;
    vc.BackString = @"333";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
}
#pragma mark-cell的协议
//单个商品退款
-(void)refundSingleShoppingWithModel:(XLShoppingModel *)model Cell:(UITableViewCell *)cell
{
    //整个订单状态为完成、单笔订单状态为已退款、列表页显示申请记录、
    if ([model.totalStatus isEqualToString:@"2"]) {
        ConsultNounVC *VC=[[ConsultNounVC alloc] init];
        VC.DataModel=model;
        [self.navigationController pushViewController:VC animated:NO];
        return;
    }

    if ([model.status isEqualToString:@"0"]) {
        //0退款 1退货退款
        NSDictionary *params=@{@"ids":model.ID,@"refund_status":@"0"};
        [ATHRequestManager requestforgetRefundNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                NSString *type=[NSString stringWithFormat:@"%@",responseObj[@"total_type"]];//能否退款 0可以 1不可以
                NSString *refund_num=[NSString stringWithFormat:@"%@",responseObj[@"refund_number"]];//退款次数 2需要显示最后一次退款
                model.goodsCount=[NSString stringWithFormat:@"%@",responseObj[@"goods_count"]];

                if ([type isEqualToString:@"0"]) {
                    PersonalShoppingReplyRefundVC *VC=[[PersonalShoppingReplyRefundVC alloc] init];
                    [VC setDataModel:model AndRefundType:@"0" andRefundTime:[refund_num integerValue] andQurtAllDan:YES];
                    [self.navigationController pushViewController:VC animated:NO];

                }else if ([type isEqualToString:@"1"])
                {

                    PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
                    VC.dataModel=model;
                    VC.kefuJieru=YES;
                    [self.navigationController pushViewController:VC animated:NO];

                }
                else
                {
                    [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self refreshData];
                    });
                }


            }else
            {
                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self refreshData];
                });
            }


        } faildBlock:^(NSError *error) {

        }];


    }else if ([model.status isEqualToString:@"1"])
    {
        //0退款 1退货退款
        NSDictionary *params=@{@"ids":model.ID,@"refund_status":@"1"};
        [ATHRequestManager requestforgetRefundNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {

                NSString *type=[NSString stringWithFormat:@"%@",responseObj[@"total_type"]];//能否退款 0可以 1不可以

                NSString *refund_num=[NSString stringWithFormat:@"%@",responseObj[@"refund_number"]];//退款次数 2需要显示最后一次退款
                model.goodsCount=[NSString stringWithFormat:@"%@",responseObj[@"goods_count"]];
                if ([type isEqualToString:@"0"]) {
                    PersonalShoppingRefundTypeVC *VC=[[PersonalShoppingRefundTypeVC alloc] init];
                    VC.dataModel=model;
                    VC.RefundTotalTime=[refund_num integerValue];
                    VC.QurtAllDan=YES;
                    YLog(@"%@",model.order_batchid);
                    [self.navigationController pushViewController:VC animated:NO];
                }else if ([type isEqualToString:@"1"])
                {

                    PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
                    VC.dataModel=model;
                    VC.kefuJieru=YES;
                    [self.navigationController pushViewController:VC animated:NO];

                }
                else
                {
                    [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self refreshData];
                    });
                }


            }else
            {
                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self refreshData];
                });
            }


        } faildBlock:^(NSError *error) {

        }];

    }

    else if ([model.status isEqualToString:@"3"]||[model.status isEqualToString:@"4"]||[model.status isEqualToString:@"5"]||[model.status isEqualToString:@"6"]||[model.status isEqualToString:@"10"]||[model.status isEqualToString:@"11"])
    {

        PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
        VC.dataModel=model;
        [self.navigationController pushViewController:VC animated:NO];

    }
    else if([model.status isEqualToString:@"2"]&&([model.refund_count integerValue]>0||[model.return_goods_count integerValue]>0))
    {

        ConsultNounVC *VC=[[ConsultNounVC alloc] init];
        VC.DataModel=model;
        [self.navigationController pushViewController:VC animated:NO];

    }
    YLog(@"单个商品退款");
}

#pragma
-(void)SelectIndexType:(NSInteger)index
{
    [self refreshData];
}


#pragma BM

#pragma mark-cell协议
-(void)CheckMerchantDetailWithModel:(BMDanModel *)model
{
    if ([model.order_type isEqualToString:@"1"]) {

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag0 = 100;

        [self.navigationController pushViewController:vc animated:NO];


    }else if ([model.order_type isEqualToString:@"2"]){

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag1 = 101;

        [self.navigationController pushViewController:vc animated:NO];


    }else if ([model.order_type isEqualToString:@"3"]){

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag2 = 102;

        [self.navigationController pushViewController:vc animated:NO];

    }else if ([model.order_type isEqualToString:@"4"]){

        BMPlaneAndTrainViewController *vc = [[BMPlaneAndTrainViewController alloc] init];

        vc.tag0 = 100;

        [self.navigationController pushViewController:vc animated:NO];

    }else if([model.order_type isEqualToString:@"5"]){

        BMPlaneAndTrainViewController *vc = [[BMPlaneAndTrainViewController alloc] init];

        vc.tag1 = 101;

        [self.navigationController pushViewController:vc animated:NO];

    }else if([model.order_type isEqualToString:@"6"])
    {
        PeccantViewController *vc=[[PeccantViewController alloc]init];

        [self.navigationController pushViewController:vc animated:NO];

    }
    YLog(@"店铺");

}

-(void)CheckBMDanDetailWithModel:(BMDanModel *)model
{
    PersonalBMDetailVC *VC=[[PersonalBMDetailVC alloc] initWithOrderBatchid:model.orderno AndOrderType:model.order_type];
    VC.delegate=self;
    [self.navigationController pushViewController:VC animated:NO];
    YLog(@"详情");

}

-(void)ContinuePayWithModel:(BMDanModel *)model
{
    SelectModel=model;
    [KNotificationCenter addObserver:self selector:@selector(PayCallBack:) name:JMSHTPayCallBack object:nil];
    [[AliPayRequestTools shareAlipayTool] BMContinuePayWithOrderNum:model.orderno OnViewController:self AndResponseSuccess:^(NSDictionary *responseObj) {
        PersonalBMDetailVC *VC=[[PersonalBMDetailVC alloc] initWithOrderBatchid:SelectModel.orderno AndOrderType:SelectModel.order_type];
        [self.navigationController pushViewController:VC animated:NO];

            [self refreshData];

        [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    } failed:^(NSError *error) {
        [self refreshData];
        [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    }];

    YLog(@"继续付款");
}

-(void)RefundMoneyWithModel:(BMDanModel *)model
{
    if([model.order_type isEqualToString:@"5"]){//火车票退款

        TrainToReturnMoneyViewController *vc = [[TrainToReturnMoneyViewController alloc] init];
        vc.ordrno = model.orderno;
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden = YES;

    }else if ([model.order_type isEqualToString:@"4"]){//飞机票退款

        AirApplyRefundVC *VC=[[AirApplyRefundVC alloc]init];
        VC.orderno=model.orderno;
        [self.navigationController pushViewController:VC animated:NO];

    }
    YLog(@"退款");

}

#pragma mark-详情协议
-(void)BMDetailSelectIndexType:(NSInteger)index
{
    [self refreshData];
}

//
-(void)BMListReloadData:(NSNotification *)noti
{

   // NSDictionary *param=noti.userInfo;

    [self refreshData];

}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(void)searchText:(NSString *)str
{
 //   cancle=YES;
    if (str.length==0) {
        [TrainToast showWithText:@"输入的搜索内容不能为空!" duration:2.0f];
    }else
    {
        self.page=0;
        [self.searchTextField resignFirstResponder];
        [SearchManager SearchDingDanText:str];//缓存搜索记录
        [self readNSUserDefaults];
        [self.searchTextField setText:str];
        _searchKeyWord=str;
        [_dataSource removeAllObjects];
        [self getDatas];

        _scroll.hidden=YES;
        nodataView.hidden=YES;
        _tableView.hidden=NO;

    }

}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    _searchHistoryArr= [userDefaultes arrayForKey:@"myDingDanArray"];
    _searchHistoryArr=[[_searchHistoryArr reverseObjectEnumerator] allObjects];
    [self initScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
