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

@interface XLPersonalDingDanVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
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

}
@property (weak, nonatomic) IBOutlet UIView *navView;
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

//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_dataSource.count) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page]};
        [self getDatasWithParams:params];
    }
}
//下拉刷新数据
-(void)refreshData
{
    self.page=0;
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page]};
    [self getDatasWithParams:params];
}
//加载数据
-(void)getDatasWithParams:(NSDictionary *)params
{
    if (!params) {
        //sigen值为获取用户id page表示分页、status表示状态、空:全部订单，7:代付款订单，0:待发货订单,1:待收货订单,2:交易完成订单
        params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page],@"status":@""};
    }

    WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:nil animated:YES];

    [ATHRequestManager requestforGetShoppingListWithParams:params successBlock:^(NSDictionary *responseObj) {
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

    } faildBlock:^(NSError *error) {
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavi];
    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
    [self.view addSubview:_scroll];
    [self initScrollView];
    [self initTableView];
}

-(void)initNavi
{
    self.searchTextField=[[UITextField alloc] init];
    self.searchBackView=[[UIImageView alloc] init];
    self.searchIcon1=[[UIImageView alloc] init];
    [self.searchBackView setImage:KImage(@"搜索长框")];
    [self.searchIcon1 setImage:KImage(@"xl-Search Icon")];


    [_navView addSubview:self.searchBackView];
    [_navView addSubview:self.searchIcon1];
    [_navView addSubview:self.searchTextField];

    self.searchBackView.frame=CGRectMake(15, 51, kScreen_Width-30-30-10, 32);
    self.searchIcon1.frame=CGRectMake(30, 61, 14, 14);
    self.searchTextField.frame=CGRectMake(30+14+5, 58, kScreen_Width-30-14-5-30-15-10-15, 20);
    self.searchTextField.placeholder=@"请输入你要搜索的商品名称";
    self.searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.searchTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    self.searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchTextField.contentVerticalAlignment=NSTextAlignmentCenter;
    self.searchTextField.delegate = self;
    self.searchTextField.font=KNSFONT(14);

    
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreen_Width-15-30, 52, 30, 30);
    [rightBtn setImage:KImage(@"xl-btn-change2") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(qurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.hidden=YES;
    [_navView addSubview:rightBtn];

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
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 45, kScreen_Width, kScreen_Height-45-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    NSLogRect(self.view.frame);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;

    [_tableView registerClass:[PersonalShoppingDanCell class] forCellReuseIdentifier:XLConstPersonalShoppingDanCell];

    [_tableView registerClass:[PersonalShoppingSectionHeaderView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingSectionHeaderView];
    [_tableView registerClass:[PersonalShoppingSectionFooterView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingSectionFooterView];

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
        _lable.text = @"抱歉，没有搜索到相关商品~";
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
       // [SearchManager removeAllArray];
        _searchHistoryArr=@[];
        [self initScrollView];
    }]];
    [self presentViewController:alert animated:YES completion:^{

    }];

}
/*******************************************************      协议方法       ******************************************************/

/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(void)searchText:(NSString *)str
{
 //   cancle=YES;
    if (str.length==0) {
        [TrainToast showWithText:@"输入的搜索内容不能为空!" duration:2.0f];
    }else
    {
        flag=1;
        [self.searchTextField resignFirstResponder];
//        [SearchManager SearchText:str];//缓存搜索记录
//        [self readNSUserDefaults];
//        [self.searchTextField setText:str];
//        _searchKeyWord=str;
//        [self getDatas];
//        [self SetNaviWithCancle:NO];
//        _scroll.hidden=YES;
//        nodataView.hidden=YES;
//        _collectionView.hidden=NO;

    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
