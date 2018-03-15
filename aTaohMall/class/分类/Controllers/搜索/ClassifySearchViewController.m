//
//  ClassifySearchViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/31.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ClassifySearchViewController.h"

#import "ClassifySearchCell.h"

#import "NewSearchViewController.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "SearchManager.h"

#import "DeleteCell.h"

#import "XSInfoView.h"

#import "JRToast.h"

#import "YTGoodsDetailViewController.h"
#import "XLSingleLineShoppingCollectionCell.h"
#import "AllSingleShoppingModel.h"
#import "XLLookAllCollectionCell.h"
#define fontCOLOR [UIColor colorWithRed:163/255.0f green:163/255.0f blue:163/255.0f alpha:1]

@interface ClassifySearchViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_searchHistoryArr;
    NSArray *_reMenSouSuoArr;
    NSArray *_IDArr;
    NSArray *_searchWordArr;

    UIScrollView *_scroll;
    BOOL isShowRemen;
    UIView  *remenView;
    UIView  *HiddenRemenView;

    NSString *_searchKeyWord;//顶部搜索词
    UICollectionView *_collectionView;
    NSMutableArray *_datasArrM;//搜索数据
    UIView *view;
    int flag;
    NSString *string10;
    NSInteger totalCount;
    BOOL IsShowGongGe;
    BOOL cancle;

    UIButton *qurtBtn;
    UIButton *rightBtn;

    UIView *nodataView;
}

@property (weak, nonatomic) IBOutlet UIView *navView;

@property (strong, nonatomic) IBOutlet UIImageView *searchBackView;
@property (strong, nonatomic) IBOutlet UIImageView *searchIcon1;
@property (strong, nonatomic) IBOutlet UIButton *cancleBut;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@end

@implementation ClassifySearchViewController
static NSString * const reuseIdentifier = @"XLShoppingCollectionCell";
static NSString * const reuseIdentifier1 = @"XLLookAllCollectionCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    [self getKeyWordsData];
}

-(void)initData
{
    _searchHistoryArr=[[NSArray alloc] init];
    _reMenSouSuoArr=[[NSArray alloc] init];
    _searchWordArr=[[NSArray alloc] init];
    _IDArr =[[NSArray alloc] init];
    isShowRemen=YES;

    flag=1;
    _datasArrM=[NSMutableArray new];
}



-(void)initTableView
{


    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight) collectionViewLayout:flowLayout];
    _collectionView.hidden=YES;
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    //去掉右侧滚动条
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerClass:[XLSingleLineShoppingCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [_collectionView registerClass:[XLLookAllCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier1];

    [self.view addSubview:_collectionView];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
    _collectionView.mj_footer = footer;

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

    _collectionView.mj_header=header;

}
//为你推荐
-(void)getKeyWordsData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:_scroll withText:nil animated:YES];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:@"%@getSearchKeywords_mob.shtml",URL_Str];

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

                NSMutableArray *temp=[[NSMutableArray alloc] init];
                NSMutableArray *temp1=[[NSMutableArray alloc] init];
                for (NSDictionary *dic1 in dic[@"list"]) {

                    NSString *keywords=[NSString stringWithFormat:@"%@",dic1[@"keywords"]];
                    NSString *ID=[NSString stringWithFormat:@"%@",dic1[@"id"]];
                    [temp addObject:keywords];
                    [temp1 addObject:ID];
                }
                _reMenSouSuoArr=[temp copy];
                _IDArr=[temp1 copy];
            }
            [self readNSUserDefaults];

        }
        [hud dismiss:YES];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {

        [hud dismiss:YES];
    }];

}
//为你推荐
-(void)setKeyWordNumber:(NSString *)str
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:@"%@upSearchKeywordsToClicks_mob.shtml",URL_Str];

    [manager POST:url parameters:@{@"id":str} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {


    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {

    }];

}

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
    self.searchTextField.placeholder=@"请输入您要搜索的商品名称";
    self.searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.searchTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    self.searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchTextField.contentVerticalAlignment=NSTextAlignmentCenter;
    self.searchTextField.delegate = self;
    self.searchTextField.font=KNSFONT(14);

    qurtBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    qurtBtn.frame=CGRectMake(10, 52, 30, 30);
    [qurtBtn setImage:KImage(@"iconfont-fanhui2副本.png") forState:UIControlStateNormal];
    [qurtBtn addTarget:self action:@selector(qurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    qurtBtn.hidden=YES;
    [_navView addSubview:qurtBtn];
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreen_Width-15-30, 52, 30, 30);
    [rightBtn setImage:KImage(@"xl-btn-change2") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickGongGeBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.hidden=YES;
    [_navView addSubview:rightBtn];

}

-(void)changeValue:(UITextField *)tf
{
    if (tf.text.length==0) {
        _collectionView.hidden=YES;
        nodataView.hidden=YES;
        _scroll.hidden=NO;
    }
}

-(void)qurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
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

    if (_reMenSouSuoArr.count>0&&_searchHistoryArr.count>0) {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, height, kScreen_Width, Width(10))];

    view.backgroundColor = RGB(242, 242, 242);

    [_scroll addSubview:view];

    height +=Width(10);
    }
/*热门搜索*/

    if (_reMenSouSuoArr.count>0) {

        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(leading, height+top, 70, 15)];
        lab.font=KNSFONTM(15);
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"搜索发现";
        [_scroll addSubview:lab];

        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(kScreen_Width-top-30, top+height-14, 44, 44);

        [but addTarget:self action:@selector(qiehuanSearch) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:but];
        height+=top+15+leading;

        if (isShowRemen) {

            [but setImage:KImage(@"睁眼") forState:UIControlStateNormal];

            CGFloat width=leading;
            CGFloat buttonWith=20;
            for (int i=0; i<_reMenSouSuoArr.count; i++) {
                NSString *str=_reMenSouSuoArr[i];

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
                [but addTarget:self action:@selector(clickReMen:) forControlEvents:UIControlEventTouchUpInside];
                but.tag=2400+i;
                but.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);//上，左，下，右

                [but.layer setCornerRadius:3];
                [but setBackgroundColor:RGB(245, 245, 245)];
                [but setTitleColor:RGB(74, 74, 74) forState:UIControlStateNormal];
                but.titleLabel.font=KNSFONT(14);
                [_scroll addSubview:but];
            }
            height+=Width(3)+leading+29;

        }else
        {

            [but setImage:KImage(@"闭眼") forState:UIControlStateNormal];
                UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, height+20, kScreen_Width, 14)];
                lab.font=KNSFONT(14);
                lab.textColor=RGB(155, 155, 155);
                lab.text=@"当前搜索发现已隐藏";
            lab.textAlignment=NSTextAlignmentCenter;
                [_scroll addSubview:lab];
            height+=20+14+20;

        }


    }

    _scroll.contentSize=CGSizeMake(kScreen_Width, height);
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
        [SearchManager removeAllArray];
        _searchHistoryArr=@[];
        [self initScrollView];
    }]];
    [self presentViewController:alert animated:YES completion:^{

    }];
//
//
//    [UIAlertTools showAlertWithTitle:nil message:@"确定删除全部历史搜索记录？" cancelTitle:@"取消" titleArray:@[] viewController:self confirm:^(NSInteger buttonTag) {
//        if (buttonTag==0) {
//            [SearchManager removeAllArray];
//            _searchHistoryArr=@[];
//            [self initScrollView];
//        }
//    }];

}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==self.searchTextField) {
        [self SetNaviWithCancle:YES];
    }

}


//点击热门
-(void)clickReMen:(UIButton *)sender
{

    NSString *str=_reMenSouSuoArr[sender.tag-2400];
    [self setKeyWordNumber:_IDArr[sender.tag-2400]];
    [self searchText:str];
}
//确定搜索
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self searchText:textField.text];
    return YES;

}
//切换
-(void)qiehuanSearch
{
    isShowRemen=!isShowRemen;
    [self initScrollView];

}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
     _searchHistoryArr= [userDefaultes arrayForKey:@"myArray"];
    _searchHistoryArr=[[_searchHistoryArr reverseObjectEnumerator] allObjects];
    [self initScrollView];
}
#pragma mark-协议
-(void)searchNewInformation:(NSString *)str
{
    [SearchManager SearchText:str];//缓存搜索记录
    [self readNSUserDefaults];
}

-(void)searchText:(NSString *)str
{
    cancle=YES;
    if (str.length==0) {
    [JRToast showWithText:@"输入的搜索内容不能为空!" duration:2.0f];
    }else
    {
        flag=1;
        [self.searchTextField resignFirstResponder];
        [SearchManager SearchText:str];//缓存搜索记录
        [self readNSUserDefaults];
        [self.searchTextField setText:str];
         _searchKeyWord=str;
        [self getDatas];
        [self SetNaviWithCancle:NO];
        _scroll.hidden=YES;
        nodataView.hidden=YES;
        _collectionView.hidden=NO;

    }

}

//取消按钮
- (IBAction)cancleBtnClick:(UIButton *)sender {
    if (cancle) {
        [self SetNaviWithCancle:NO];
        [self.searchTextField resignFirstResponder];
        _scroll.hidden=YES;
        _collectionView.hidden=NO;
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    //
}

-(void)SetNaviWithCancle:(BOOL )Cancle
{
    if (Cancle) {

    rightBtn.hidden=YES;
    qurtBtn.hidden=YES;
    _cancleBut.hidden=NO;
    _cancleBut.frame=CGRectMake(kScreen_Width-15-30, 54, 30, 30);
    self.searchBackView.frame=CGRectMake(15, 51, kScreen_Width-30-30-10, 32);
   self.searchIcon1.frame=CGRectMake(30, 61, 14, 14);
    self.searchTextField.frame=CGRectMake(30+14+5, 58, kScreen_Width-30-14-5-30-15-10-15, 20);
    }else
    {
    rightBtn.hidden=NO;
    qurtBtn.hidden=NO;
    _cancleBut.hidden=YES;
    self.searchBackView.frame=CGRectMake(15+30+8, 51, kScreen_Width-15-30-8-30-15-10, 32);
    self.searchIcon1.frame=CGRectMake(30+30+8, 61, 14, 14);
    self.searchTextField.frame=CGRectMake(30+30+8+14+5, 58, kScreen_Width-60-14-8-15-14-30-10, 20);

    }


}

//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_datasArrM.count) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self getDatas];
    }
}
//下拉刷新数据
-(void)refreshData
{

    flag=1;
    [self getDatas];

}

-(void)getDatas
{

    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url = [NSString stringWithFormat:@"%@getGoodsByWord_mob.shtml",URL_Str];

    NSDictionary *dic = @{@"word":_searchKeyWord,@"flag":[NSString stringWithFormat:@"%d",flag]};

    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        if (codeKey && content) {
            if (flag==1) {
                [_datasArrM removeAllObjects];
            }
            flag=flag+1;
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"xmlStr=%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];


            NSLog(@"=====搜索结果===%@",dic);

            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {

                for (NSDictionary *dict2 in dict1[@"list_goods"]) {

                    totalCount = [[NSString stringWithFormat:@"%@",dict1[@"totalCount"]] integerValue];

                    AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];

                    model.amount = [NSString stringWithFormat:@"%@",dict2[@"amount"]];
                    model.ID=[NSString stringWithFormat:@"%@",dict2[@"id"]];



                    model.name=[NSString stringWithFormat:@"%@",dict2[@"name"]];
                    model.pay_integer=[NSString stringWithFormat:@"%@",dict2[@"pay_integer"]];
                    model.pay_maney=[NSString stringWithFormat:@"%@",dict2[@"pay_maney"]];
                    model.scopeimg=[NSString stringWithFormat:@"%@",dict2[@"scopeimg"]];

                    //赋值
                    model.is_attribute = [NSString stringWithFormat:@"%@",dict2[@"is_attribute"]];

                    model.storename = [NSString stringWithFormat:@"%@",dict2[@"storename"]];

                    [_datasArrM addObject:model];

                }
            }
            if (_datasArrM.count==0) {
                [self initview];
            }else
            {
              //  _lable.hidden=YES;
                [_collectionView.mj_header endRefreshing];
                [_collectionView.mj_footer endRefreshing];
                //刷新数据
                [_collectionView reloadData];
            }
            [hud dismiss:YES];


        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        [self NoWebSeveice];
        [hud dismiss:YES];
    }];
}


-(void)NoWebSeveice
{
    if (view) {
        view.hidden=NO;
        return;
    }
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
        _collectionView.hidden=YES;
        _scroll.hidden=YES;
    }

}

-(void)loadData
{

    view.hidden=YES;


    [self getDatas];
}

#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datasArrM.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!IsShowGongGe) {
        return CGSizeMake(kScreenWidth, Width(145));
    }else
    {
        CGFloat WWW=([UIScreen mainScreen].bounds.size.width-Width(18))/2;
        CGFloat HHH=WWW+5*Height(7)+15+26+1+10;
        return CGSizeMake(WWW, HHH);
    }

}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (!IsShowGongGe) {
        return 0;
    }else
    {
        return Width(6);
    }
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (!IsShowGongGe) {
        return 0;
    }else
    {
        return Width(3);
    }
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    if (!IsShowGongGe) {
        return UIEdgeInsetsMake(Width(10), 0, 0, 0  );
    }
    //上,左,下,右
    else{
        return UIEdgeInsetsMake(Width(10), Width(6), Width(6), Width(6));
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!IsShowGongGe) {
        XLLookAllCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
        cell.model=_datasArrM[indexPath.row];
        return cell;
    }else
    {
        XLSingleLineShoppingCollectionCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        AllSingleShoppingModel *model=_datasArrM[indexPath.row];
        cell1.model=model;
        return cell1;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AllSingleShoppingModel *model=_datasArrM[indexPath.row];

    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.type_name;
    vc.gid=model.ID;
    vc.type=@"1";
    vc.attribute = model.is_attribute;
    vc.ID=model.ID;
    [self.navigationController pushViewController:vc animated:NO];

}

- (IBAction)clickGongGeBtn:(UIButton *)sender {
    IsShowGongGe=!IsShowGongGe;
    if (IsShowGongGe) {
        [sender setImage:KImage(@"xl-btn-change") forState:UIControlStateNormal];
    }else
    {
        [sender setImage:KImage(@"xl-btn-change2") forState:UIControlStateNormal];
    }
    [_collectionView reloadData];
}

@end
