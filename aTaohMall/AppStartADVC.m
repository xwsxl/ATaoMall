//
//  AppStartADVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/9/20.
//  Copyright © 2017年 ysy. All rights reserved.
//
#import "UserMessageManager.h"
#import "AppStartADVC.h"
#import "NewHomeViewController.h"
#import "ClassifyViewController.h"
#import "CartViewController.h"
#import "PersonaViewController.h"
#import "YTGoodsDetailViewController.h"
#import "WKProgressHUD.h"
#import "NineAndNineViewController.h"
#import "YTScoreViewController.h"
static  NSString * const JMSHTImageLoadComplete=@"JMSHTImageLoadComplete";



#define WIDTH (NSInteger)self.view.bounds.size.width
#define HEIGHT (NSInteger)self.view.bounds.size.height


@interface AppStartADVC ()<UIScrollViewDelegate,UITabBarControllerDelegate>
{
    UITabBarController *tabBarController;
    CartViewController *vc4;
   // NSTimer *_timer;
    UIButton *jumpBut;
    NSMutableArray *dataArrM;
    // 创建页码控制器
    UIPageControl *pageControl;
    // 判断是否是第一次进入应用
    BOOL flag;
    UIWebView *webview;
    BOOL update;
    BOOL ADCache;
    
    
    UIView *dataLoadView;
    
    UIView *_AdView;
    
    UIView *_appStartView;
    
    UIView *_noDataView;
    
    UIScrollView *myScrollView;
    NSInteger count;
}
@property (nonatomic,copy) NSString *CartString;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,copy) NSString *sigen;
@property (nonatomic,strong)UITapGestureRecognizer *tap;
@end

@implementation AppStartADVC

- (void)viewDidLoad {
    [super viewDidLoad];
    update=[self isShow];
    count=0;
    ADCache=YES;
    self.carousel_figure=@"";
    //注册通知
    
    [KNotificationCenter addObserver:self selector:@selector(AppDelegateShowNumber) name:JMSHTLogOutSuccessNoti object:nil];
    //不显示购物车件数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppDelegateShowNumber) name:@"AppDelegateShowNumber" object:nil];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackBackCartChangeNumber:) name:@"BackBackCartChangeNumber" object:nil];
    [KNotificationCenter addObserver:self selector:@selector(SetCartBudgeNumber) name:JMSHTLoginSuccessNoti object:nil];
    //图片加载完成
    [KNotificationCenter addObserver:self selector:@selector(ImageLoadComplete) name:JMSHTImageLoadComplete object:nil];
    self.tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump)];
    [self setDataLoadView];
   // [self getAPP];
    update=NO;
    if (update) {
        self.carousel_figure=@"";
        [self setAppStartUI];
    }else if ([kUserDefaults stringForKey:@"AppStart-carousel_figure"].length>0) {

        self.carousel_figure=[kUserDefaults objectForKey:@"AppStart-carousel_figure"];
        self.gid=[kUserDefaults objectForKey:@"APPStart-gid"];
        self.mid=[kUserDefaults objectForKey:@"APPStart-mid"];
        self.type=[kUserDefaults objectForKey:@"APPStart-type"];
        self.ID=[kUserDefaults objectForKey:@"APPStart-id"];
        NSLog(@"self.carcousel=%@",self.carousel_figure);
        [self setUI];

    }else
    {
        ADCache=NO;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    if (!ADCache) {
        [self autoLoginWithJump:@"NO"];
}
}
- (BOOL)isShow
{
    // 读取版本信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [user objectForKey:VERSION_INFO_CURRENT];
    NSString *currentVersion =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"localVersion ===%@", localVersion);
    NSLog(@"currentVersion ===%@", currentVersion);
    if (localVersion == nil || ![currentVersion isEqualToString:localVersion]) {
       
        return YES;
    }else
    {
        return NO;
    }
}
// 保存版本信息
- (void)saveCurrentVersion
{
    NSString *version =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:version forKey:VERSION_INFO_CURRENT];
    [user synchronize];
}

-(void)ImageLoadComplete{
    
        if (count==1) {
            if (dataLoadView) {
                [dataLoadView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [dataLoadView removeFromSuperview];
                dataLoadView=nil;
            }
            if (_noDataView) {
                [_noDataView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [_noDataView removeFromSuperview];
                _noDataView=nil;
            }
            _AdView.hidden=NO;
            [self.view addGestureRecognizer:self.tap];
            [_timer setFireDate:[NSDate distantPast]];
        }
    
}

-(void)setDataLoadView{

    if (!dataLoadView) {
        dataLoadView=[[UIView alloc]initWithFrame:kScreen_Bounds];
        CGSize viewSize =self.view.bounds.size;
        NSString *viewOrientation = @"Portrait";//横屏请设置成 @"Landscape"
        NSString *launchImage = nil;
        NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
        
        for(NSDictionary *dict in imagesDict) {
            CGSize imageSize =CGSizeFromString(dict[@"UILaunchImageSize"]);
            if(CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
                launchImage = dict[@"UILaunchImageName"];
            }
        }
        
        UIImageView *IV=[[UIImageView alloc]initWithImage:KImage(launchImage)];
        [dataLoadView addSubview:IV];
        [self.view addSubview:dataLoadView];
    }
    
    
    
    
}

/*****
 *
 *  Description 初始化广告页
 *
 ******/
-(void)setUI{
    NSLog(@"self.carsou=%@",self.carousel_figure);
    if ((!_AdView)&&(![self.carousel_figure isEqualToString:@""])&&(![self.carousel_figure isEqualToString:@"(null)"]&&(self.carousel_figure)))
  {
      
        _AdView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
       _AdView.hidden=YES;
        [self.view addSubview:_AdView];
        
    UIImageView * IV=[[UIImageView alloc] init];
    IV.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    [_AdView addSubview:IV];
    [IV sd_setImageWithURL:KNSURL(self.carousel_figure) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        count++;
        [KNotificationCenter postNotificationName:JMSHTImageLoadComplete object:nil];
    }];
    
        
    jumpBut=[UIButton buttonWithType:UIButtonTypeCustom];
    jumpBut.backgroundColor=RGBA(0, 0, 0,0.2);
    [jumpBut setTitle:@"跳过\n3s" forState:UIControlStateNormal];
    jumpBut.titleLabel.font=KNSFONT(15);
    jumpBut.titleLabel.numberOfLines=0;
    jumpBut.titleLabel.textAlignment=NSTextAlignmentCenter;
    jumpBut.frame=CGRectMake(kScreen_Width-95, 40, 55, 55);
    jumpBut.layer.cornerRadius=55/2.0;
    [jumpBut addTarget:self action:@selector(jumpButClick:) forControlEvents:UIControlEventTouchUpInside];
    [_AdView insertSubview:jumpBut aboveSubview:IV];

       if (!_timer)
      {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil
                                           repeats:YES];
      }
    [_timer setFireDate:[NSDate distantFuture]];
  }
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 使用 NSUserDefaults 读取用户数据
    if (update) {
        // 如果是第一次进入引导页
        [self setAppStartUI];
    }
}
/*****
 *
 *  Description 初始化引导页
 *
 ******/

-(void)setAppStartUI{
    NSArray *arr=@[@"AppStart-1",@"AppStart-2",@"AppStart-3",@"AppStart-4"];
    if (!_appStartView) {
        _appStartView=[[UIView alloc]initWithFrame:kScreen_Bounds];
        [self.view addSubview:_appStartView];
        _appStartView.hidden=YES;
    
    if (!myScrollView) {
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    }
    for (int i=0; i<arr.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
        // 在最后一页创建按钮
        
        if (i == arr.count-1) {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((WIDTH-247)/ 2, HEIGHT-120, 247, 60);
            [button setImage:KImage(@"button_AppStart") forState:UIControlStateNormal];
            [button addTarget:self action:@selector(autoLogin) forControlEvents:UIControlEventTouchUpInside];
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 247, 60)];
            lab.font=KNSFONT(17);
            lab.textColor=RGB(255, 255, 255);
            lab.text=@"立即体验";
            lab.textAlignment=NSTextAlignmentCenter;
            [button addSubview:lab];
            [imageView addSubview:button];
        }
        [imageView setImage:KImage(arr[i])];
        [myScrollView addSubview:imageView];
    }
    
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(WIDTH * arr.count, HEIGHT);
    myScrollView.delegate = self;
    [_appStartView addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH / 3, HEIGHT * 15 / 16, WIDTH / 3, HEIGHT / 16)];
    // 设置页数
    pageControl.numberOfPages = arr.count;
    // 设置页码的点的颜色
    pageControl.pageIndicatorTintColor = RGB(229, 229, 229);
    // 设置当前页码的点颜色
    pageControl.currentPageIndicatorTintColor = RGB(191, 191, 191);
        if (pageControl.numberOfPages>1) {
            [_appStartView addSubview:pageControl];
        }
    
    }
    
        if ([self.carousel_figure isEqualToString:@""]||[self.carousel_figure isEqualToString:@"(null)"]||(!self.carousel_figure)) {
          
                if (dataLoadView) {
                    [dataLoadView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                    [dataLoadView removeFromSuperview];
                    dataLoadView=nil;
                }
                if (_noDataView) {
                    [_noDataView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                    [_noDataView removeFromSuperview];
                    _noDataView=nil;
                }
         _appStartView.hidden=NO;
           
        }
    
}

//点击广告
- (void)jump{
    NSLog(@"点击广告");
    [_timer invalidate];
    _timer=nil;
    [self autoLoginWithJump:@"YES"];
}

//点击跳过
-(void)jumpButClick:(UIButton *)sender{
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 使用 NSUserDefaults 读取用户数据
    if (update) {
        if (_AdView) {
            [self.view removeGestureRecognizer:self.tap];
            [_AdView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [_AdView removeFromSuperview];
          //  [self getCacheData];
            _AdView=nil;
        }
        // 如果是第一次进入引导页
        _appStartView.hidden=NO;
    }
    else{
        // 否则直接进入应用
        [self autoLoginWithJump:@"NO"];
    }
}

//清空购物车的角标
-(void)AppDelegateShowNumber{
    
    vc4.tabBarItem.badgeValue = nil;
    
}
//改变购物车角标数值
-(void)BackBackCartChangeNumber:(NSNotification *)text{
    
    NSLog(@"===textOne===%@",text.userInfo[@"textOne"]);
    
    if ([text.userInfo[@"textOne"] isEqualToString:@"0"]) {
        
        vc4.tabBarItem.badgeValue = nil;
        
    }else{
        
        vc4.tabBarItem.badgeValue = text.userInfo[@"textOne"];
        
    }
    
}

#pragma mark - UIScrollViewDelegate
//计算当前页数
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat page=(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
    NSLog(@"page=%.2f,number=%ld",page,pageControl.numberOfPages);
    // 计算当前在第几页
    if (page>pageControl.numberOfPages-2+0.1) {
        pageControl.hidden=YES;
    }
    else
    {
    pageControl.hidden=NO;
    pageControl.currentPage = (NSInteger)page;
    }
    
}

//定时器方法
- (void)timeChange{
    static NSInteger time = 3;
    
    if (time == 0) {
        if ([_timer isValid]) {
            [_timer invalidate];
        }
        _timer=nil;
        [self jumpButClick:nil];
        return;
    }
    NSString * timer = [NSString stringWithFormat:@"跳过\n%lds", time];
    [jumpBut setTitle:timer forState:UIControlStateNormal];
    
    time--;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)autoLogin{
    [self saveCurrentVersion];
    [self autoLoginWithJump:@"NO"];
}

-(void)SetCartBudgeNumber
{
    [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":[kUserDefaults objectForKey:@"sigen"]} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        //  NSLog(@"==获取购物车件数==%@===",responseObj);
        
        if (responseObj) {
            
            
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                
                
                if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {
                    self.CartString=@"0";
                    vc4.tabBarItem.badgeValue=nil;
                }else{
                    
                    self.CartString = responseObj[@"goods_sum"];
                    
                    [UserMessageManager AppDelegateCartNumber:responseObj[@"goods_sum"]];
                    vc4.tabBarItem.badgeValue=self.CartString;
                    
                }
                
            }
           
        }else{
            
            
            NSLog(@"error");
            self.CartString=@"0";
            vc4.tabBarItem.badgeValue=nil;
        }
        
        
    }];
    
}

//自动登录
-(void)autoLoginWithJump:(NSString *)str{
    
    if ([kUserDefaults objectForKey:@"new"]!=nil&&[kUserDefaults objectForKey:@"password"]!=nil) {
        
        NSString *account=[NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:@"new"]];
        NSString *password=[NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:@"password"]];
        NSLog(@"acc=%@=========pass=%@",account,password);
        
        if (account.length>0&&password.length>0) {
            NSDictionary *dic=@{@"phone":[kUserDefaults objectForKey:@"new"],@"password":[kUserDefaults objectForKey:@"password"]};
            [ATHRequestManager requestforMineLogInWithParams:dic successBlock:^(NSDictionary *responseObj) {
                
                for (NSDictionary *dic in responseObj) {
                    if ([[NSString stringWithFormat:@"%@",dic[@"status"]] isEqualToString:@"10000"]) {
                        NSNull *null=[[NSNull alloc]init];
                        //缓存用户sigen'
                        [UserMessageManager UserSigen:dic[@"sigen"]];
                        //缓存手机号
                        if (![dic[@"phone"] isEqual:null]) {
                            
                            [UserMessageManager UserPhone:dic[@"phone"]];
                        }
                        //缓存用户积分
                        [UserMessageManager UserInteger:dic[@"integral"]];
                        [UserMessageManager LoginNumber:dic[@"status"]];
                        if ([dic[@"portrait"] isEqual:null] || [dic[@"portrait"] isEqualToString:@""]) {
                            //缓存头像
                            [UserMessageManager UserHeaderImage:@"头像"];
                        }else{
                            
                            //缓存头像
                            [UserMessageManager UserHeaderImage:dic[@"portrait"]];
                        }
                        //缓存userid
                        [UserMessageManager UserId:dic[@"userid"]];
                        [KNotificationCenter postNotificationName:JMSHTLoginSuccessNoti object:nil];
                    }else
                    {
                        [KNotificationCenter postNotificationName:JMSHTLogOutSuccessNoti object:nil];
                        [UserMessageManager removeAllArray];
                        [UserMessageManager LoginStatus:@"NO"];
                        [kUserDefaults setObject:@"" forKey:@"sigen"];
                    }
                }
            } faildBlock:^(NSError *error) {
                //登录失败发送通知
                [UserMessageManager removeAllArray];
                [UserMessageManager LoginStatus:@"NO"];
                [kUserDefaults removeObjectForKey:@"sigen"];
                [kUserDefaults setObject:@"" forKey:@"sigen"];
                [KNotificationCenter postNotificationName:JMSHTLogOutSuccessNoti object:nil];
            }];
        }
        else
        {
            //登录失败发送通知
            [UserMessageManager removeAllArray];
            [UserMessageManager LoginStatus:@"NO"];
            [kUserDefaults removeObjectForKey:@"sigen"];
            [kUserDefaults setObject:@"" forKey:@"sigen"];
            [KNotificationCenter postNotificationName:JMSHTLogOutSuccessNoti object:nil];
        }
    }
    else
    {
        [UserMessageManager removeAllArray];
        [UserMessageManager LoginStatus:@"NO"];
        [kUserDefaults removeObjectForKey:@"sigen"];
        [kUserDefaults setObject:@"" forKey:@"sigen"];
        [KNotificationCenter postNotificationName:JMSHTLogOutSuccessNoti object:nil];
    }

    [self setMainControllerWithJump:str];
   
}
//设置主视图
-(void)setMainControllerWithJump:(NSString *)str
{
    
  //  NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NewHomeViewController *vc1=[[NewHomeViewController alloc] init];
    
    UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:vc1];
    
    
    ClassifyViewController *vc2=[[ClassifyViewController alloc] init];
    UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:vc2];
    
    vc4=[[CartViewController alloc] init];
    UINavigationController *nav4=[[UINavigationController alloc] initWithRootViewController:vc4];
    
    PersonaViewController *vc5=[[PersonaViewController alloc] init];
    UINavigationController *nav5=[[UINavigationController alloc] initWithRootViewController:vc5];
    
    vc1.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"首页111"] selectedImage:[UIImage imageNamed:@"首页选中413"]];
    
    vc2.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"分类111-"] selectedImage:[UIImage imageNamed:@"分类选中413"]];
    
    vc4.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"购物车666"] selectedImage:[UIImage imageNamed:@"购物车-选中413"]];
    vc5.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"我的111"] selectedImage:[UIImage imageNamed:@"我的选中413"]];
    

    
    tabBarController=[[UITabBarController alloc] init];
    tabBarController.viewControllers=@[nav1,nav2,nav4,nav5];
    tabBarController.delegate=self;
    //改变TabBar的默认颜色
    tabBarController.tabBar.tintColor=[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0];
    if ([str isEqualToString:@"YES"]) {
        // 广告图类型：0.商品1. 九块九包邮  2.积分专题
        if ([self.type isEqualToString:@"0"]) {
            YTGoodsDetailViewController *VC=[[YTGoodsDetailViewController alloc]init];
            VC.gid=self.gid;
            VC.mid=self.mid;
            nav1.viewControllers=@[nav1.viewControllers.firstObject,VC];
            nav1.navigationBar.hidden=YES;
            nav1.tabBarController.tabBar.hidden=YES;
        }else if ([self.type isEqualToString:@"1"])
        {
            NineAndNineViewController *VC=[[NineAndNineViewController alloc] init];
            nav1.viewControllers=@[nav1.viewControllers.firstObject,VC];
            nav1.navigationBar.hidden=YES;
            nav1.tabBarController.tabBar.hidden=YES;
        }else
        {
            YTScoreViewController *VC=[[YTScoreViewController alloc] init];
            nav1.viewControllers=@[nav1.viewControllers.firstObject,VC];
            nav1.navigationBar.hidden=YES;
            nav1.tabBarController.tabBar.hidden=YES;
        }
        
    }
    
    self.view.window.rootViewController=tabBarController;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

    static NSString *tabBarDidSelectedNotification = @"tabBarDidSelectedNotification";
    //当tabBar被点击时发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:tabBarDidSelectedNotification object:nil userInfo:nil];

}





@end
