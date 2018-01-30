//
//  SearchResultViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "SearchResultViewController.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "SearchResultModel.h"

#import "SearchResultCell1.h"
#import "SearchResultCell2.h"
#import "SearchResultCell.h"

#import "NewGoodsDetailViewController.h"//商品详情

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多

#import "NoDataCell.h"

#import "WKProgressHUD.h"

#import "TimeModel.h"//倒计时model

#import "SearchManager.h"

#import "JRToast.h"

#import "YTSearchCell.h"

#import "YTGoodsDetailViewController.h"

#import "YTSearchOtherCell.h"
@interface SearchResultViewController ()<UITableViewDataSource,UITableViewDelegate,FooterViewDelegate,UITextFieldDelegate>
{
    NSString *_searchKeyWord;
    UITableView *_tableView;
    NSMutableArray *_datasArrM;//搜索数据
    HomeLookFooter *footer;
    UIView *view;
    int flag;
    NSString *string10;
    NSInteger totalCount;
}

@property (nonatomic, strong) NSTimer        *m_timer; //定时器
@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组
@property(nonatomic,strong)NSMutableArray *myArrM;

@property(nonatomic,strong)NSMutableArray *deleteArrM;
@property(nonatomic,strong)UILabel *lable;//暂无数据

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame=[UIScreen mainScreen].bounds;
    _datasArrM=[NSMutableArray new];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    NSLog(@"我要的myArry==%@",myArray);
    
    flag=1;
    
    self.searchResultTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchResultTextField.delegate = self;
    
    //标题数据
    for (NSString *str in _resultArrM) {
        self.searchResultTextField.text=str;
        _searchKeyWord=str;
    }
    
    //创建tableView
    [self initTableView];
    //获取数据
    [self getDatas];
}


-(void)initview{
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height/10 , [UIScreen mainScreen].bounds.size.width, 80)];
    _lable.text = @"没有您要搜索的相关商品";
    _lable.tag = 100;
    _lable.textColor = [UIColor lightGrayColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:_lable];
    
}
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SearchResultCell1" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_tableView registerNib:[UINib nibWithNibName:@"SearchResultCell2" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NoDataCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
//    [_tableView registerNib:[UINib nibWithNibName:@"YTSearchCell" bundle:nil] forCellReuseIdentifier:@"ytcell"];
    
    [_tableView registerClass:[YTSearchCell class] forCellReuseIdentifier:@"ytcell"];
    
    [_tableView registerClass:[YTSearchOtherCell class] forCellReuseIdentifier:@"other"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多


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


//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_datasArrM.count) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
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
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getGoodsByWord_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"word":_searchKeyWord,@"flag":[NSString stringWithFormat:@"%d",flag]};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        if (codeKey && content) {
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
                    
                    SearchResultModel *model=[[SearchResultModel alloc] init];
                    
                    
                    NSString *amount = [NSString stringWithFormat:@"%@",dict2[@"amount"]];
                    NSString *id=[NSString stringWithFormat:@"%@",dict2[@"id"]];
                    NSString *good_type=[NSString stringWithFormat:@"%@",dict2[@"good_type"]];
                    
                    
                    NSString *name=[NSString stringWithFormat:@"%@",dict2[@"name"]];
                    NSString *pay_integer=[NSString stringWithFormat:@"%@",dict2[@"pay_integer"]];
                    NSString *pay_maney=[NSString stringWithFormat:@"%@",dict2[@"pay_maney"]];
                    NSString *scopeimg=[NSString stringWithFormat:@"%@",dict2[@"scopeimg"]];
                    NSString *status=[NSString stringWithFormat:@"%@",dict2[@"status"]];
                    NSString *stock =[NSString stringWithFormat:@"%@",dict2[@"stock"]];
                    NSString *start_time = [NSString stringWithFormat:@"%@",dict2[@"start_time_str"]];
                    NSString *end_time = [NSString stringWithFormat:@"%@",dict2[@"end_time_str"]];
                    //赋值
                    model.attribute = [NSString stringWithFormat:@"%@",dict2[@"is_attribute"]];

                    model.storename = [NSString stringWithFormat:@"%@",dict2[@"storename"]];
                    
                    model.amount=amount;
                    model.id=id;
                    model.good_type=good_type;
                    model.name=name;
                    model.pay_integer=pay_integer;
                    model.pay_maney=pay_maney;
                    model.scopeimg=scopeimg;
                    model.status=status;
                    model.stock=stock;
                    
                    if ([good_type isEqualToString:@"1"]) {
                        
                        model.start_time=start_time;
                        model.end_time = end_time;
                        
                    }

                    [_datasArrM addObject:model];

                }
            }
            if (_datasArrM.count==0) {
                [self initview];
            }else
            {
                _lable.hidden=YES;
                [_tableView.mj_header endRefreshing];
                [_tableView.mj_footer endRefreshing];
                //刷新数据
                [_tableView reloadData];
            }
            [hud dismiss:YES];

            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [self NoWebSeveice];
        [hud dismiss:YES];
    }];
}

-(void)loadData
{
    
    view.hidden=YES;

    
    [self getDatas];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_datasArrM.count==0) {
        return 0;
    }else{
        
       return _datasArrM.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datasArrM.count==0) {
        return 0;
    }else{
        return ((kScreenHeight==812)?667:kScreenHeight)/3.5;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000000001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datasArrM.count==0) {
        
        NoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
        
        return cell;
        
    }else{
        
        SearchResultModel *model=_datasArrM[indexPath.row];
        
        
        

            
            YTSearchOtherCell *cell=[tableView dequeueReusableCellWithIdentifier:@"other"];
            
            cell.model=_datasArrM[indexPath.row];
            
            return cell;

        
    }
}

//选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_datasArrM.count==0){
    
    
    }else{
    SearchResultModel *model=_datasArrM[indexPath.row];
    
//    NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
    
        
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.ID=model.id;
    vc.gid=model.id;
    vc.good_type=model.good_type;
    vc.status=model.status;
        
        NSLog(@"====YYYYYYYY=====%@",self.attribute);
        
    vc.attribute = model.attribute;
        
    vc.Attribute_back=@"3";
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    }
    
    [self.view endEditing:YES];
    
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    self.searchResultTextField.text = @"";
  //  self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];

}




-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
        return 0.01;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0) {
        
        [JRToast showWithText:@"输入的搜索内容不能为空!" duration:0.5f];
        
        
    }else{
        flag=1;
        textField.returnKeyType=UIReturnKeySearch;
        
        textField.delegate=self;
        
        _searchKeyWord=self.searchResultTextField.text;
        
        [_datasArrM removeAllObjects];

        if (_delegate &&[_delegate respondsToSelector:@selector(searchNewInformation:)]) {
            [_delegate searchNewInformation:_searchKeyWord];
        }

        _lable.hidden = YES;
        
        [self getDatas];
        
        
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            
            [hud dismiss:YES];
            
        });
        
        [_tableView reloadData];
        
        [textField resignFirstResponder];
        
    }
    
    return YES;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length==0) {
        
        [JRToast showWithText:@"输入的搜索内容不能为空!" duration:0.5f];
        
    }else{
        
        
//        [SearchManager SearchText:textField.text];//缓存搜索记录
//        [self readNSUserDefaults];
//        
//        
//        [_myArrM addObject:textField.text];
        
        //---------------------------
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
        
        if (myArray.count==0) {
            
            [SearchManager SearchText:textField.text];//缓存搜索记录
            [self readNSUserDefaults];
            
            
            [_myArrM addObject:textField.text];
            
        }else{
            
            
            
            if ([myArray containsObject:textField.text]) {
                
                NSLog(@"****相等*****");
            }else{
                NSLog(@"*****不相等****");
                
                [SearchManager SearchText:textField.text];//缓存搜索记录
                [self readNSUserDefaults];
                
                
                [_myArrM addObject:textField.text];
                
            }
            
        }
        //----------------------------
        
        [_tableView reloadData];
        
        NSLog(@"搜索被点击了");
        
    }
//    if (textField.text.length > 0) {
//        
//        
//        
//    }else{
//        NSLog(@"请输入查找内容");
//    }
////    textField.text = @"";
}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    self.myArray = myArray;
    
    for (NSString *str in self.myArray) {
        [_deleteArrM addObject:str];
    }
    
    [_tableView reloadData];
    NSLog(@"myArray======%@",myArray);
}



@end
