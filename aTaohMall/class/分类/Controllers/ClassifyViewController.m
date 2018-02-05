//
//  ClassifyViewController.m
//  ATAoHuiMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 yt. All rights reserved.
//

#import "ClassifyViewController.h"

#import "ClassifyCell.h"

#import "ClassifyControllectionCell.h"

#import "LookAllViewController.h"

#import "GoodsDetailViewController.h"//商品详情

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"

#import "ClassifyModel.h"

#import "ClassifySearchViewController.h"//搜索界面

#import "ClassifyLeftCell.h"

#import "goodListModel.h"

#import "UIImageView+WebCache.h"

#import "ClassifyHeader.h"

#import "WKProgressHUD.h"

#import "CollectionReusableHeadrView.h"

#import "YTGoodsDetailViewController.h"

#import "JRToast.h"

#import "NewClassifyHeaderView.h"
#import "NewLookAllViewController.h"
#import "FenLeiHeaderView.h"

#import "NoDataFenLeiCell.h"
#import "FenLeiCell.h"
#import "HomeDPModel.h"
#import "HomeDaiPaiSuggestListVC.h"
#import "DPCommandDetailViewController.h"
#define KSWeidth [UIScreen mainScreen].bounds.size.width*0.26667

@interface ClassifyViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *_datasArray;//存储一级标题
    NSMutableArray *_secondArray;//存储二级标题
    NSMutableArray *_goodsArray;//存储商品信息
    NSMutableArray *_goodsArray1;
    NSMutableArray *_goodsArray2;
    NSMutableArray *_goodsArray3;
    NSMutableArray *_goodsArray4;
    
    NSMutableArray *_otherArray;


    NSMutableArray *_leftFenLeiArray;



    UIScrollView *_titleScroll;
    ClassifyLeftCell *cell1;

    UIScrollView *_RemenScroll;

    UIView *view;//没网络的视图

    UIImageView *HeaderIV;
    UITableView *_tableView;

    NSString *selectStr;
    NSInteger selectIndex;
    UIView *_slidView;

    UIView *headerView1;
}
@property (nonatomic,strong)NSMutableArray *DataSource;
@property (nonatomic,strong)NSMutableArray *statusArray;
@property (nonatomic,strong)ClassifyModel *DataModel;
@property (nonatomic,strong)NSMutableArray *RemenFenLeiArray;

@end

@implementation ClassifyViewController

/*******************************************************      控制器生命周期       ******************************************************/
//视图初始化时候添加监听通知
-(instancetype)init
{
    self=[super init];
    selectStr=@"";
    [KNotificationCenter addObserver:self selector:@selector(JumpToLeimu:) name:@"homeClick" object:nil];
    return self;
}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _datasArray=[NSMutableArray new];

    _secondArray=[NSMutableArray new];
    _goodsArray=[NSMutableArray new];
    _otherArray=[NSMutableArray new];


    _goodsArray1=[NSMutableArray new];
    _goodsArray2=[NSMutableArray new];
    _goodsArray3=[NSMutableArray new];
    _goodsArray4=[NSMutableArray new];

    self.navigationController.navigationBar.hidden=YES;

    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];

    view1.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:view1];

    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(Width(15), 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-Width(30), 28)];
    searchView.backgroundColor = RGB(237, 237, 237);
    searchView.layer.cornerRadius  = 3;
    searchView.layer.masksToBounds = YES;
    [view1 addSubview:searchView];


    NSString *str=@"快速查找商品";
    CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:KMAXSIZE];
    //搜索添加手势
    searchView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imgRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headSearchClick:)];
    [searchView addGestureRecognizer:imgRecongnizer];


    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-Width(30)-(size.width+14+5))/2, 7, 14, 14)];
    imgView.image=[UIImage imageNamed:@"xl-Search Icon"];
    [searchView addSubview:imgView];

    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-Width(30)-(size.width+14+5))/2+14+5, 7, size.width, 14)];
    label.text=str;
    //  label.textAlignment=NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    label.textColor=RGB(136, 136, 136);
    [searchView addSubview:label];

    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, kScreenWidth, 1)];
    lineView.backgroundColor=RGB(225, 225, 225);
    [self.view addSubview:lineView];

    self.view.frame=[UIScreen mainScreen].bounds;
    self.classId=@"";

    self.view.backgroundColor = [UIColor whiteColor];

    [self initTableView];
    //获取数据
    [self getFenleiLeftDatas];

}
//
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;

}

/*******************************************************      数据请求       ******************************************************/
//左侧一级分类
-(void)getFenleiLeftDatas
{


    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:@"%@getHomePageClassification_mob.shtml",URL_Str];

    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];


        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"=======xmlStr%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                ClassifyModel *model=[[ClassifyModel alloc] init];
                model.name=@"为你推荐";
                model.GoodsId=@"";
                [_datasArray addObject:model];
                self.statusArray=[[NSMutableArray alloc] init];
                [self.statusArray addObject:@"0"];
                [self.DataSource addObject:@[]];
                for (NSDictionary *dic1 in dic[@"list1"]) {

                    ClassifyModel *model=[[ClassifyModel alloc] init];
                    model.name=dic1[@"name"];
                    model.GoodsId=dic1[@"id"];

                    [_datasArray addObject:model];
                    [self.statusArray addObject:@"0"];
                    [self.DataSource addObject:@[]];
                }
                [self initScollview];
            }

        }
        [hud dismiss:YES];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {

        [hud dismiss:YES];
    }];

}
//
-(void)getRightSencondCateData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url=[NSString stringWithFormat:@"%@getClassificationSecondLevelData_mob.shtml",URL_Str];

    [manager POST:url parameters:@{@"id":self.classId} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];


        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"====112345667===xmlStr%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                ClassifyModel *model=[[ClassifyModel alloc] init];
                model.logo1=[NSString stringWithFormat:@"%@",dic[@"picture"]];
                model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                NSMutableArray *temp=[[NSMutableArray alloc] init];
                for (NSDictionary *dic1 in dic[@"list"]) {
                    ClassifyModel *model=[[ClassifyModel alloc] init];
                    NSMutableArray *temp1=[[NSMutableArray alloc] init];
                    model.GoodsId=dic1[@"id"];
                    model.name=dic1[@"name"];

                    for (NSDictionary *dict4 in dic1[@"goodsList"]) {
                        goodListModel *model=[[goodListModel alloc] init];

                      /*  "type": "149",
                        "level": "1",
                        "carousel_figure": "",
                        "gid": 7442,
                        "mid": "2242",
                        "name": "小风扇",
                        "amount": "0",
                        "stock": "200",
                        "pay_integer": "100.00",
                        "pay_maney": "100.00",
                        "scopeimg": "http://image.anzimall.com/union/upload/9d6fda9200009b0a.jpg",
                        "status": "0",
                        "is_attribute": "1",
                        "storename": "领家小吃"*/
                        model.amount=[NSString stringWithFormat:@"%@",dict4[@"amount"]];
                        model.goods_name=[NSString stringWithFormat:@"%@",dict4[@"name"]];
                        model.gid=[NSString stringWithFormat:@"%@",dict4[@"gid"]];
                        model.pay_integer=[NSString stringWithFormat:@"%@",dict4[@"pay_integer"]];
                        model.pay_maney=[NSString stringWithFormat:@"%@",dict4[@"pay_maney"]];
                        model.scopeimg=[NSString stringWithFormat:@"%@",dict4[@"scopeimg"]];
                        model.sort_type=[NSString stringWithFormat:@"%@",dict4[@"sort_type"]];
                        model.type=[NSString stringWithFormat:@"%@",dict4[@"type"]];
                        model.attribute = [NSString stringWithFormat:@"%@",dict4[@"is_attribute"]];//属性判断
                        model.storename = [NSString stringWithFormat:@"%@",dict4[@"storename"]];
                        model.status = [NSString stringWithFormat:@"%@",dict4[@"status"]];
                        model.stock = [NSString stringWithFormat:@"%@",dict4[@"stock"]];
                        [temp1 addObject:model];
                    }
                    model.goodsList=[temp1 copy];
                    [temp addObject:model];
                }
                model.goodsList=[temp copy];
                _DataModel=model;
                YLog(@"%@",model.logo1);
                if ([model.logo1 isEqualToString:@""]||[model.logo1 containsString:@"null"]) {
                    HeaderIV.frame=CGRectZero;
                    headerView1.frame=CGRectZero;
                    //_tableView.tableHeaderView=nil;
                }else
                {

                    headerView1.frame=CGRectMake(0, 0, kScreen_Width-Width(80), (kScreenWidth-Width(80)-30)*96/264.0+15);
                    HeaderIV.frame=CGRectMake(15, 15,kScreenWidth-Width(80)-30,(kScreenWidth-Width(80)-30)*96/264.0);
                    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBanner:)];
                    HeaderIV.userInteractionEnabled=YES;

                    HeaderIV.layer.cornerRadius=2;
                    tap.numberOfTapsRequired=1;
                    [HeaderIV addGestureRecognizer:tap];
                    [HeaderIV sd_setImageWithURL:KNSURL(model.logo1) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
                }
                [self.DataSource replaceObjectAtIndex:selectIndex withObject:model];
                [self.statusArray replaceObjectAtIndex:selectIndex withObject:@"1"];
            }
        }
        _tableView.hidden=NO;
        _RemenScroll.hidden=YES;
        [_tableView reloadData];
        [hud dismiss:YES];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [hud dismiss:YES];
    }];

}
//为你推荐
-(void)getForYouSelectData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:@"%@getClassificationRecommendData_mob.shtml",URL_Str];

    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];


        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];




            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"=======xmlStr%@",dic);
            if ([dic[@"status"] isEqualToString:@"10000"]) {

                ClassifyModel *model=[[ClassifyModel alloc] init];
                model.logo1=[NSString stringWithFormat:@"%@",dic[@"picture"]];
                model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                NSMutableArray *temp=[[NSMutableArray alloc] init];
                for (NSDictionary *dic1 in dic[@"SelectedBrand_list"]) {
                    HomeDPModel *model=[[HomeDPModel alloc] init];
                    model.ID=[NSString stringWithFormat:@"%@",dic1[@"id"]];
                    model.cream_name=[NSString stringWithFormat:@"%@",dic1[@"cream_name"]];
                    model.represent=[NSString stringWithFormat:@"%@",dic1[@"represent"]];
                    model.picpath=[NSString stringWithFormat:@"%@",dic1[@"selected_path"]];
                    [temp addObject:model];
                }
                model.SelectedBrand_list=[temp copy];
                [self.RemenFenLeiArray removeAllObjects];
                for (NSDictionary *dic1 in dic[@"SmallClass_list"]) {
                    ClassifyModel *model=[[ClassifyModel alloc] init];
                    model.GoodsId=[NSString stringWithFormat:@"%@",dic1[@"id"]];
                    model.name=[NSString stringWithFormat:@"%@",dic1[@"name"]];
                    [self.RemenFenLeiArray addObject:model];
                }
                model.SmallClass_list=[self GetReMenFenleiArrayWith:nil];
                _DataModel=model;
                [self.DataSource replaceObjectAtIndex:selectIndex withObject:model];
                [self.statusArray replaceObjectAtIndex:selectIndex withObject:@"1"];
                [self initReMenFenlei];

            }

        }
        [hud dismiss:YES];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {

        [hud dismiss:YES];
    }];

}
/*******************************************************      初始化视图       ******************************************************/
//创建左边的滚动视图
-(void)initScollview{

    if (_titleScroll) {
        return;
    }
    NSLog(@"kkkkkk%ld",_datasArray.count);
    CGFloat bheight = ([UIScreen mainScreen].bounds.size.height-108)/12;

    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight,Width(80), [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-1-49-KSafeAreaBottomHeight)];
    _titleScroll.contentSize = CGSizeMake(Width(80), _datasArray.count*(bheight));
    _titleScroll.bounces=NO;
    //Button的高


    //创建左边的按钮

    for (int i=0; i<_datasArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, bheight*i, Width(80)-1, bheight)];

        UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake(Width(80)-1, bheight*i, 1, bheight+1)];
        fenge.image = [UIImage imageNamed:@"分割线YT"];


        btn.backgroundColor = [UIColor whiteColor];
        ClassifyModel *model=_datasArray[i];
        [btn setTitle:model.name forState:UIControlStateNormal];
        btn.tag = 100+i;
        fenge.tag = 200+i;

        //退款框
        [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:0];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];


        if ([selectStr isEqualToString:@""]) {
            selectIndex=0;
            if (i==0) {

            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];

            self.classId=model.GoodsId;
            [self getForYouSelectData];
            }
        }else
        {

            if ([model.name isEqualToString:selectStr]) {
                [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                self.classId=model.GoodsId;
                [self getRightSencondCateData];
                selectIndex=i;

            }

        }

        [_titleScroll addSubview:btn];
        [_titleScroll addSubview:fenge];


    }
    if (!_slidView) {
        _slidView=[[UIView alloc] init];
        [_slidView setBackgroundColor:[UIColor redColor]];
    }
    [_titleScroll addSubview:_slidView];
     [_slidView setFrame:CGRectMake(0, bheight*selectIndex+(bheight-20)/2, 3, 20)];
    _titleScroll.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_titleScroll];



}
//初始化表视图
-(void)initTableView
{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(Width(80), KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width-Width(80), [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-49-KSafeAreaBottomHeight) style:UITableViewStyleGrouped];

    _tableView.delegate=self;

    _tableView.dataSource=self;

    _tableView.bounces=NO;

    _tableView.backgroundColor = [UIColor whiteColor];

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];

    [_tableView registerClass:[FenLeiCell class] forCellReuseIdentifier:@"cell1"];

    [_tableView registerClass:[NoDataFenLeiCell class] forCellReuseIdentifier:@"nodata"];

    [_tableView registerClass:[NewClassifyHeaderView class] forHeaderFooterViewReuseIdentifier:@"hedaer"];

    [_tableView registerNib:[UINib nibWithNibName:@"FenLeiHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"FenLeiHeaderView"];

    headerView1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width-Width(80), (kScreenWidth-Width(80)-30)*96/264.0+15)];

    HeaderIV=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15,kScreenWidth-Width(80)-30,(kScreenWidth-Width(80)-30)*96/264.0)];
    [headerView1 addSubview:HeaderIV];
    _tableView.tableHeaderView=headerView1;

}
//初始化热门分类
-(void)initReMenFenlei
{
    _tableView.hidden=YES;
    _RemenScroll.hidden=NO;
    if (!_RemenScroll) {
        _RemenScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(Width(80), KSafeAreaTopNaviHeight, kScreenWidth-Width(80), kScreenHeight-KSafeAreaTopNaviHeight-49-KSafeAreaBottomHeight)];
        _RemenScroll.delegate=self;
        [self.view addSubview:_RemenScroll];
    }else
    {
        [_RemenScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    YLog(@"%@,%ld,%ld",_DataModel.logo1,_DataModel.SmallClass_list.count,_DataModel.SelectedBrand_list.count);
    CGFloat height=0;
    if (!([_DataModel.logo1 isEqualToString:@""]||[_DataModel.logo1 containsString:@"null"])) {
        UIImageView *headerIV=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15,kScreenWidth-Width(80)-30,(kScreenWidth-Width(80)-30)*96/264.0)];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBanner:)];
        headerIV.layer.cornerRadius=2;
        headerIV.userInteractionEnabled=YES;
        tap.numberOfTapsRequired=1;
        [headerIV addGestureRecognizer:tap];
        [headerIV sd_setImageWithURL:KNSURL(_DataModel.logo1) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [_RemenScroll addSubview:headerIV];
        height +=15+(kScreenWidth-Width(80)-30)*96/264.0;
    }
    if (_DataModel.SmallClass_list.count>0) {
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, height+15, 70, 14)];
    lab.font=KNSFONT(14);
    lab.textColor=RGB(51, 51, 51);
    lab.text=@"热门分类";
    [_RemenScroll addSubview:lab];

    UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(kScreenWidth-Width(80)-15-70, height+15, 70, 14);
    [but setImage:KImage(@"xl-icon-F5") forState:UIControlStateNormal];
        [but setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [but setTitle:@"换一换" forState:UIControlStateNormal];
    [but setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
    but.titleLabel.font=KNSFONT(14);
    [but addTarget:self action:@selector(HuanYiHuan:) forControlEvents:UIControlEventTouchUpInside];
    [_RemenScroll addSubview:but];

    height+=15+14;

    CGFloat leading=(kScreenWidth-Width(80)-Width(65)*3)/4.0;

    CGFloat IVwidth=leading;
    CGFloat IVHeight=Width(10);

    CGFloat width=(kScreenWidth-Width(80))/3;
    CGFloat butHeight=5+14+Width(65)+Width(20);

    for (int i=0; i<_DataModel.SmallClass_list.count; i++) {
        IVwidth=leading+(leading+Width(65))*(i%3);
        IVHeight=height+Width(20)+(5+14+Width(65)+Width(20))*(i/3);

        ClassifyModel *model=_DataModel.SmallClass_list[i];
        UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(IVwidth, IVHeight, Width(65), Width(65))];
        [IV setImage:KImage(model.name)];
        [_RemenScroll addSubview:IV];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(IVwidth, IVHeight+Width(65)+5, Width(65), 14)];
        lab.font=KNSFONT(13);
        lab.textColor=RGB(155, 155, 155);
        lab.text=model.name;
        lab.textAlignment=NSTextAlignmentCenter;
        [_RemenScroll addSubview:lab];

        width=((kScreenWidth-Width(80))/3)*(i%3);
        butHeight=(5+14+Width(65)+Width(20))*(i/3)+height;
        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(width, butHeight, (kScreenWidth-Width(80))/3, 5+14+Width(65)+Width(20));
        but.tag=1000+i;
        [but addTarget:self action:@selector(clickFenLei:) forControlEvents:UIControlEventTouchUpInside];
        [_RemenScroll addSubview:but];

    }
    height+=((_DataModel.SmallClass_list.count+2)/3)*(5+14+Width(65)+Width(20))+15;

    }

    if (_DataModel.SelectedBrand_list.count>0) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, height+15, 70, 18)];
        lab.font=KNSFONT(14);
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"精选品牌";
        [_RemenScroll addSubview:lab];

        height+=15+18;
        CGFloat leading=(kScreenWidth-Width(80)-Width(65)*3)/4.0;

        CGFloat IVwidth=leading;
        CGFloat IVHeight=Width(10);

        CGFloat width=(kScreenWidth-Width(80))/3;
        CGFloat butHeight=5+14+Width(65)+Width(20);
        for (int i=0; i<_DataModel.SelectedBrand_list.count; i++) {
            IVwidth=leading+(leading+Width(65))*(i%3);
            IVHeight=height+Width(20)+(5+14+Width(65)+Width(20))*(i/3);

            HomeDPModel *model=_DataModel.SelectedBrand_list[i];
            UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(IVwidth, IVHeight, Width(65), Width(65))];
            [IV sd_setImageWithURL:KNSURL(model.picpath) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
            [_RemenScroll addSubview:IV];
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(IVwidth, IVHeight+Width(65)+5, Width(65), 14)];
            lab.font=KNSFONT(14);
            lab.textColor=RGB(155, 155, 155);
            lab.text=model.cream_name;
            lab.textAlignment=NSTextAlignmentCenter;
            [_RemenScroll addSubview:lab];

            width=((kScreenWidth-Width(80))/3)*(i%3);
            butHeight=(5+14+Width(65)+Width(20))*(i/3)+height;
            UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
            but.frame=CGRectMake(width, butHeight, (kScreenWidth-Width(80))/3, 5+14+Width(65)+Width(20));
            but.tag=2000+i;
            [but addTarget:self action:@selector(clickDP:) forControlEvents:UIControlEventTouchUpInside];
            [_RemenScroll addSubview:but];
        }
            height+=((_DataModel.SelectedBrand_list.count+2)/3)*(5+14+Width(65)+Width(20));

    }

    _RemenScroll.contentSize=CGSizeMake(0, height+20);

}


/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//首页点击通知
-(void)JumpToLeimu:(NSNotification *)noti
{

    selectStr=noti.userInfo[@"text"];
    if (_titleScroll) {

        for (int i=0; i<_datasArray.count; i++) {
            ClassifyModel *model=_datasArray[i];

            if ([selectStr isEqualToString:model.name]) {
                UIButton *btn=[self.view viewWithTag:100+i];
                [self click:btn];
            }

        }
    }
    NSLog(@"%@",noti.userInfo[@"text"]);
}
//点击搜索
-(void)headSearchClick:(UIImageView *)image
{
    ClassifySearchViewController *vc=[[ClassifySearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    //隐藏
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}
//点击左侧按钮
-(void)click:(UIButton*)btn1{

    [self selectIndex:btn1.tag-100];
}
//查看更多
-(void)LookAllBtnClick:(UIButton*)btn
{

    ClassifyModel *model=_DataModel.goodsList[btn.tag-1];
    //直接重数据源取相应的值！！！！
    NSLog(@"查看全部被点击了");

    NewLookAllViewController *vc=[[NewLookAllViewController alloc] init];
    vc.gid = model.GoodsId;
    vc.titleName = model.name;
    NSLog(@"kkkkkkkk=%@",vc.titleName);
    [self.navigationController pushViewController:vc animated:NO];

    self.navigationController.navigationBar.hidden=YES;

    self.tabBarController.tabBar.hidden=YES;

}
//换一换
-(void)HuanYiHuan:(UIButton *)sender
{
   _DataModel.SmallClass_list=[self GetReMenFenleiArrayWith:_DataModel.SmallClass_list];
    [self initReMenFenlei];
}
//
-(void)clickFenLei:(UIButton *)sender
{
    ClassifyModel *model=_DataModel.SmallClass_list[sender.tag-1000];
    //直接重数据源取相应的值！！！！
    NSLog(@"查看全部被点击了");

    NewLookAllViewController *vc=[[NewLookAllViewController alloc] init];
    vc.gid = model.GoodsId;
    vc.titleName = model.name;
    NSLog(@"kkkkkkkk=%@",vc.titleName);
    [self.navigationController pushViewController:vc animated:NO];

    self.navigationController.navigationBar.hidden=YES;

    self.tabBarController.tabBar.hidden=YES;

}
//大牌
-(void)clickDP:(UIButton *)sender
{
    HomeDPModel *model=_DataModel.SelectedBrand_list[sender.tag-2000];
    DPCommandDetailViewController *VC=[[DPCommandDetailViewController alloc] init];
    VC.Title=model.cream_name;
    VC.ID=model.ID;
    [self.navigationController pushViewController:VC animated:NO];
    self.tabBarController.tabBar.hidden=YES;
}
//顶部banner
-(void)clickBanner:(UIButton *)sender
{

    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.ID=_DataModel.gid;
    vc.gid=_DataModel.gid;
    [self.navigationController pushViewController:vc animated:NO];

    self.navigationController.navigationBar.hidden=YES;

    self.tabBarController.tabBar.hidden=YES;
    

}
/*******************************************************      协议方法       ******************************************************/
#pragma
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _DataModel.goodsList.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    ClassifyModel *model=_DataModel.goodsList[section];
    return (model.goodsList.count==0)?1:model.goodsList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyModel *model1=_DataModel.goodsList[indexPath.section];
    if (model1.goodsList.count==0) {
        NoDataFenLeiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nodata"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        goodListModel *model=model1.goodsList[indexPath.row];
      //  YLog(@"%@%@%@%@",model.name);
        FenLeiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.StoreLabel.text = model.storename;

        cell.Status = model.status;
        cell.stock=model.stock;
       
        [cell.LogoImgView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        cell.NameLabel.text=model.goods_name;

        if ([model.pay_maney isEqualToString:@"0"]) {

            cell.PriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];

        }else if ([model.pay_integer isEqualToString:@"0"]){

            cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",[model.pay_maney floatValue]];

        }else{

            cell.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
        }
        cell.AmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 40;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    FenLeiHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FenLeiHeaderView"];

    ClassifyModel *model=_DataModel.goodsList[section];
    header.TypeLabel.text=model.name;
    header.MoreButton.tag=section+1;
    self.ggid=model.gid;
    self.titleName = model.name;

    [header.MoreButton addTarget:self action:@selector(LookAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    return header;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ClassifyModel *model1=_DataModel.goodsList[indexPath.section];
    if (model1.goodsList.count==0) {

        return;
    }else
    {
        goodListModel *model=model1.goodsList[indexPath.row];

        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];

        vc.type=@"1";//判断返回界面
        vc.NewHomeString = @"1";
        vc.ID=model.gid;
        vc.gid=model.gid;
        vc.attribute = model.attribute;
        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;

    }



}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/
/*
 选择了第N个
 */
-(void)selectIndex:(NSInteger )index
{

    if(selectIndex==index)
    {
        return;
    }




    selectIndex=index;
    for (NSInteger i = 0; i <_datasArray.count; i ++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:100+i];
        [button setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:0];
        if (selectIndex ==i) {
            [button setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
        }
        CGFloat bheight = ([UIScreen mainScreen].bounds.size.height-108)/12;
        [_slidView setFrame:CGRectMake(0, bheight*selectIndex+(bheight-20)/2, 3, 20)];
    }

    if([_statusArray[selectIndex] isEqualToString:@"1"])
    {
        _DataModel=self.DataSource[selectIndex];
        if(selectIndex==0)
        {
            [self initReMenFenlei];
        }else
        {
            _tableView.hidden=NO;
            _RemenScroll.hidden=YES;
            [_tableView reloadData];
        }

    }else
    {
    if (selectIndex==0) {
        [self getForYouSelectData];
    }else
    {
    ClassifyModel *model=_datasArray[selectIndex];
    self.classId=model.GoodsId;
    [self getRightSencondCateData];
    }
    }
}
/*
获取热门分类
 */
-(NSArray *)GetReMenFenleiArrayWith:(NSArray *)arr
{
    NSMutableArray *tempArr=[self.RemenFenLeiArray mutableCopy];
    NSMutableArray *resultArr=[[NSMutableArray alloc] init];
    if (arr) {
        for (int i=0; i<arr.count; i++) {
            ClassifyModel *model=arr[i];
            if ([tempArr containsObject:model]) {
            [tempArr removeObject:model];
            }
        }
    }

    tempArr  = [[tempArr sortedArrayUsingComparator:^NSComparisonResult(ClassifyModel *model1, ClassifyModel *model2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [model1.name compare:model2.name];
        } else {
            return [model2.name compare:model1.name];
        }
    }] mutableCopy];

    for (int i=0; i<12; i++) {
        [resultArr addObject:tempArr[i]];
    }
    return [resultArr copy];
}



-(void)NoWebSeveice
{
        
        view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight)];
        
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
    view.hidden=YES;
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    if (_titleScroll) {
        if (selectIndex==0) {
            [self getForYouSelectData];
        }else
        {
        [self getRightSencondCateData];
        }
    }else
    {
    [self getFenleiLeftDatas];
    }
}

-(ClassifyModel *)DataModel
{
    if (!_datasArray) {
        _DataModel=[[ClassifyModel alloc] init];
    }
    return _DataModel;
}
-(NSMutableArray *)DataSource
{
    if (!_DataSource) {
        _DataSource=[[NSMutableArray alloc] init];
    }
    return _DataSource;
}
-(NSMutableArray *)RemenFenLeiArray
{
    if (!_RemenFenLeiArray) {
        _RemenFenLeiArray=[[NSMutableArray alloc] init];
    }
    return _RemenFenLeiArray;
}
@end
