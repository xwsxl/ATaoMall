//
//  YTTuWenViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/9.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTTuWenViewController.h"
//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "WKProgressHUD.h"

#import "YTLoginViewController.h"

#import "MJRefresh.h"

#import "YTWebViewViewController.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"

#import "UIImageView+WebCache.h"



#import "GoToShopModel.h"

#import "QueDingPayViewController.h"//确定支付

#import "QueDingDingDanViewController.h"//确定订单

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "NewLoginViewController.h"

#import "UserMessageManager.h"

#import "JRToast.h"

#import "WKProgressHUD.h"//加载小时图

#import "SVProgressHUD.h"


//#import <MJRefresh/MJRefresh.h>

@interface YTTuWenViewController ()<DJRefreshDelegate,UIWebViewDelegate,LoginMessageDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    UITableView *_tableView;
    
    //刷新尾
 //   MJRefreshFooterView *refreshFooterView;
    
    UIView *view;
    UIWebView *_webView;
    
    NSMutableArray *_datas;
    
    UILabel *label2;
    
    BOOL isFirstLoadWeb;
    
    
    UIButton *_zhiding;
    
    UILabel *price;
    
}
@property (nonatomic,strong)DJRefresh *refresh;
@end

@implementation YTTuWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //获取通知中心
    NSNotificationCenter * center =[NSNotificationCenter defaultCenter];
    
    //添加观察者 Observer表示观察者  reciveNotice:表示接收到的消息  name表示再通知中心注册的通知名  object表示可以相应的对象 为nil的话表示所有对象都可以相应
    [center addObserver:self selector:@selector(reciveNotice:) name:@"TuWenPrice" object:nil];
    
    //自动偏移
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.view.frame=[UIScreen mainScreen].bounds;
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
    
    
    NSLog(@"kkkkkkkkkkkk=%@====%@",self.exchange,self.NewPrice);
    
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    NSLog(@">>>>>>%@",self.sigen);
    
    self.sigen=@"";
    
    _datas=[NSMutableArray new];
    
    
    [self getDatas];
    
    
    UIImageView *fenge=[[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    fenge.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:fenge];
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 49)];
    
    view1.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:view1];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 35, 20)];
    label.text=@"小计:";
    label.font=[UIFont systemFontOfSize:15];
    [view1 addSubview:label];
    
    
    price=[[UILabel alloc] initWithFrame:CGRectMake(55, 15, view1.frame.size.width-100-55, 20)];
    price.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    price.font=[UIFont systemFontOfSize:15];
    [view1 addSubview:price];
    
//    price.text=self.NewPrice;
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(view1.frame.size.width-100, 0, 100, 49);
    
    [button setTitle:@"立即购买" forState:0];
    button.titleLabel.font=[UIFont systemFontOfSize:16];
    //    button.titleLabel.font=[UIFont fontWithName:@"" size:<#(CGFloat)#>]
    button.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button addTarget:self action:@selector(BuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:button];
    
    
    
    
}
- (void)reciveNotice:(NSNotification *)notification{
    
    NSLog(@"收到消息啦!!!");
    
    NSLog(@"====收到消息啦==%@=",[notification.userInfo objectForKey:@"tuwenprice"]);
    
    self.PriceShow=[notification.userInfo objectForKey:@"tuwenprice"];
    
    self.ShowString=[notification.userInfo objectForKey:@"type"];
    
    price.text=self.PriceShow;
    
}

-(void)BuyBtnClick
{
    
    NSLog(@"=====图文页页点击了购买");
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 50;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
    
}
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}


-(void)getDatas
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMerchantsGoodsDetails_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"id":self.ID};//,@"page":@"0",@"currentPageNo":@"1"};
    
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr%@",xmlStr);
            
            [hud dismiss:YES];
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"tuwen  = %@",dic);
            view.hidden=YES;
            for (NSDictionary *dict in dic) {
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    for (NSDictionary *dict1 in dict[@"list_goods"]) {
                        GoToShopModel *model=[[GoToShopModel alloc] init];
                        model.pay_integer=dict1[@"pay_integer"];
                        model.pay_maney=dict1[@"pay_maney"];
                        model.scopeimg=dict1[@"scopeimg"];
                        model.type=dict1[@"type"];
                        model.detailId=dict1[@"detailId"];
                        
                        self.pay_maney=dict1[@"pay_maney"];
                        self.pay_integer=dict1[@"pay_integer"];
                        self.freight=dict1[@"freight"];
                        
                        self.note=dict1[@"note"];
                        
                        self.gid=dict1[@"id"];
                        
                        self.name=dict1[@"name"];
                        self.scopeimg=dict1[@"scopeimg"];
                        
                        self.mid=dict1[@"mid"];
                        
                        self.stock=dict1[@"stock"];
                        
                        self.Good_status=dict1[@"status"];
                        
                        self.good_type=dict1[@"good_type"];
                        
                        self.detailId2=dict1[@"detailId"];
                        
                        self.is_attribute=dict1[@"is_attribute"];
                        
                        self.exchange=dict1[@"exchange"];
                        
                        
                        [_datas addObject:model];
                    }
                    
                    self.logo=dict[@"merchants_map"][@"logo"];
                    
                    self.storename=dict[@"merchants_map"][@"storename"];
                    
                }else{
                    
                    
                    //                   self.gid=[NSString stringWithFormat:@"1"];
                }
                
                
            }
            
        }
        
        
        //        UIScrollView *webScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49-65)];
        //
        //        webScrollView.delegate=self;
        //
        //        webScrollView.pagingEnabled=YES;
        //
        //        webScrollView.bounces=NO;
        //
        //        webScrollView.showsVerticalScrollIndicator=YES;
        //
        //        webScrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
        //
        //        webScrollView.contentSize = CGSizeMake(0, 2*[UIScreen mainScreen].bounds.size.height);
        //
        //        [self.view addSubview:webScrollView];
        //
        
        //
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -[UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-50)];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.scopeimg]];
        
        
        //        [webScrollView addSubview:imgView];
        
        UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, -40, [UIScreen mainScreen].bounds.size.width-20, 40)];
        
        nameLabel.font=[UIFont systemFontOfSize:16];
        nameLabel.numberOfLines=0;
        nameLabel.text=self.name;
        //
        //        [webScrollView addSubview:nameLabel];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -35, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49-35)];
        
        //滑动
                _webView.scrollView.scrollEnabled=YES;
        
        
        //       _webView.scrollView.contentInset=UIEdgeInsetsMake([UIScreen mainScreen].bounds.size.height/2, 0, 0, 0);
        
        //        [_webView.scrollView addSubview:imgView];
        //        [_webView.scrollView addSubview:nameLabel];
        
        //缩放到屏幕大小0
        _webView.scalesPageToFit=YES;
        //
        //        [_webView setScalesPageToFit:YES];
        _webView.delegate = self;
        
        _webView.scrollView.delegate=self;
        
        
        _webView.scrollView.bounces = NO;
        
        
//        UIPanGestureRecognizer *apan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(goPanNext:)];
//        apan.delegate = self;
//        apan.maximumNumberOfTouches=1;
//        apan.minimumNumberOfTouches=1;
//        [_webView addGestureRecognizer:apan];
//        
//        for (UIView* scrollView in _webView.subviews) {
//            scrollView.userInteractionEnabled = YES;
//            [scrollView addGestureRecognizer:apan];
//            for (UIView* browserView in scrollView.subviews) {
//                browserView.userInteractionEnabled = YES;
//                [browserView addGestureRecognizer:apan];
//            }
//        }
        
        //NSLog(@"%@",self.imgUrlstr)
        
        
        NSString *bb = self.note;
        NSLog(@"888888888==%@",bb);
        [_webView loadHTMLString:bb baseURL:nil];
        //        [_webView loadHTMLString:self.note baseURL:nil];
        
        
        [self.view addSubview:_webView];
        
        NSLog(@"====YTYTYT====%ld===",_webView.scrollView.frame.size.height);
        
        
        
       

        
        
        
        
        _zhiding=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _zhiding.hidden=YES;
        
        _zhiding.frame=CGRectMake(_webView.frame.size.width-44, _webView.frame.size.height-40, 44, 44);
//        _zhiding.backgroundColor=[UIColor orangeColor];
        [_zhiding setBackgroundImage:[UIImage imageNamed:@"置顶"] forState:0];
        _zhiding.layer.masksToBounds = YES;
        _zhiding.layer.cornerRadius = _zhiding.bounds.size.width*0.5;
        
          
        
        
        [_zhiding addTarget:self action:@selector(gotoYT) forControlEvents:UIControlEventTouchUpInside];
        
        [_webView addSubview:_zhiding];
        
        
        //显示价格
        
//        NSNull *null=[[NSNull alloc] init];
//        
//        
//        if ([self.ShowString isEqualToString:@"100"]) {
//            
//            
//            price.text=self.PriceShow;
//            
//        }else{
//            
//            if ([self.freight isEqual:null] || [self.freight isEqualToString:@"0.00"] || [self.freight isEqualToString:@"0"] || [self.freight isEqualToString:@""]) {
//                
//                if ([self.pay_integer isEqual:null] || [self.pay_integer isEqualToString:@"0.00"] || [self.pay_integer isEqualToString:@"0"] || [self.pay_integer isEqualToString:@""]) {
//                    
//                    price.text=[NSString stringWithFormat:@"￥%.02f",[self.pay_maney floatValue]];
//                    
//                }else if ([self.pay_maney isEqual:null] || [self.pay_maney isEqualToString:@"0.00"] || [self.pay_maney isEqualToString:@"0"] || [self.pay_maney isEqualToString:@""]){
//                    
//                    
//                    price.text=[NSString stringWithFormat:@"%.02f积分",[self.pay_integer floatValue]];
//                    
//                }else{
//                    
//                    price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[self.pay_maney floatValue],[self.pay_integer floatValue]];
//                }
//                
//            }else{
//                
//                if ([self.pay_integer isEqual:null] || [self.pay_integer isEqualToString:@"0.00"] || [self.pay_integer isEqualToString:@"0"] || [self.pay_integer isEqualToString:@""]) {
//                    
//                    price.text=[NSString stringWithFormat:@"￥%.02f",[self.pay_maney floatValue]+[self.freight floatValue]];
//                    
//                }else if ([self.pay_maney isEqual:null] || [self.pay_maney isEqualToString:@"0.00"] || [self.pay_maney isEqualToString:@"0"] || [self.pay_maney isEqualToString:@""]){
//                    
//                    
//                    price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[self.freight floatValue],[self.pay_integer floatValue]];
//                    
//                }else{
//                    
//                    price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[self.pay_maney floatValue]+[self.freight floatValue],[self.pay_integer floatValue]];
//                }
//                
//            }
        
//        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self NoWebSeveice];
        
    }];
}


//- (void)goPanNext:(UIPanGestureRecognizer *)sender
//{
//    CGPoint begainPoint;
//    CGPoint endPoint;
//    
//    CGPoint mainSC=[UIScreen mainScreen].bounds.origin;
//    
//    CGFloat scan=[UIScreen mainScreen].bounds.size.height;
//    
//    
//    
//    if (sender.state==UIGestureRecognizerStateBegan) {
//        begainPoint =[sender translationInView:_webView];
//        
//        
//        NSLog(@"=====开始坐标==%f===%f",begainPoint.x,begainPoint.y);
//    }
//    if (sender.state==UIGestureRecognizerStateEnded) {
//        endPoint =[sender translationInView:_webView];
//        
//        
//        NSLog(@"=====结束坐标==%f===%f",endPoint.x,endPoint.y);
//        
//        NSLog(@"=====屏幕坐标==%f===%f",mainSC.x,mainSC.y);
//        
//        NSLog(@"=**==%f===**===%f====%f=",begainPoint.y,endPoint.y,scan);
//        
//        
//        NSLog(@"=====坐标差==%f==",endPoint.y-begainPoint.y);
//        
//        NSLog(@"=====&&&&====%f",endPoint.y-scan);
//        
//        
//        if (endPoint.y<-scan) {
//            
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                NSLog(@"&&&&&&&&&&&&");
//                
//                _zhiding.hidden=NO;
//                
//            } completion:^(BOOL finished) {
//            }];
//            
//        }else{
//            
//             NSLog(@"*************");
//            _zhiding.hidden=YES;
//            
//        }
////        if (endPoint.x-begainPoint.x<0) {
////            [UIView animateWithDuration:0.5 animations:^{
////                
////                
////            } completion:^(BOOL finished) {
////            }];
////
////            
////        }else{
////            
////            
////        }
//    }
//}

//=======================================================================
#pragma mark- UIWebView添加手势，必须实现
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


-(void)loadData{
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    
    [self getDatas];
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
    
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label3.text=@"请检查你的网络";
    
    label3.textAlignment=NSTextAlignmentCenter;
    
    label3.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label3.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label3];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)gotoYT
{
    
    NSLog(@"gotoYT");
    
//    [self getDatas];
    
    //回到头部
    [_webView.scrollView setContentOffset:CGPointZero animated:YES];
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
        
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [hud dismiss:YES];
        });
    }else if (direction==DJRefreshDirectionBottom){
        
        NSLog(@"22222");
        
        YTLoginViewController *vc=[[YTLoginViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
        
    }
    
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    
}

//#pragma  mark - MJRefreshBaseViewDelegate
////开始刷新
//-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
//{
//    //刷新头部, 下拉刷新
//    if (refreshView == refreshFooterView) {
//
//        //只获取第一页的数据
//
//        YTWebViewViewController *vc=[[YTWebViewViewController alloc] init];
//
//        [self.navigationController pushViewController:vc animated:NO];
//
//        self.navigationController.navigationBar.hidden=YES;
//
//
//
//    }
//
//
//}


//-(void)dealloc
//{
//    //释放资源(移除kvo)
//
//    [refreshFooterView free];
//
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
    CGFloat offset = webView.scrollView.contentSize.height;
    
   
    NSLog(@"===$$$$$$==%f",offset);
    
    NSLog(@"=============小朋友，叫爸爸");
    //程序会一直调用该方法，所以判断若是第一次加载后就使用我们自己定义的js，此后不在调用JS,否则会出现网页抖动现象
//    if (!isFirstLoadWeb) {
//        isFirstLoadWeb = YES;
//    }else
//        return;
    //给webview添加一段自定义的javascript
    
    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function myFunction() { "
     
     //     //注意这里的Name为搜索引擎的Name,不同的搜索引擎使用不同的Name
     //     //<input type="text" name="word" maxlength="64" size="20" id="word"/> 百度手机端代码
     //     "var field = document.getElementsByName('word')[0];"
     //
     //     //给变量取值，就是我们通常输入的搜索内容，这里为 code4app.com
     //     "field.value='code4app.com';"
     //
     //     "document.forms[0].submit();"
     
     "var objs = document.getElementsByTagName('img');"
     "for(var i=0;i<objs.length;i++){"
     "var img=objs[i];"
     "img.style.width = '100%';"
     "img.style.height = 'auto'"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    //开始调用自定义的javascript
    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    
    //以上内容均参考自互联网，再次分享给互联网
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    return YES;
}

#pragma  mark - scrollView 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    NSInteger index = offset.y / [UIScreen mainScreen].bounds.size.height;
    
    //
    
    
}


//正在滚动中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //使用偏移量获取当前的页
    NSInteger currentPage = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height;
    
    
    NSLog(@"===888888======%ld",currentPage);
    
    if (currentPage==0) {
        
        
        _zhiding.hidden=YES;
        
    }else{
        
        _zhiding.hidden=NO;
        
    }
    
}


@end
