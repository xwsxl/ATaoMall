//
//  OrdersDropdownSelection.m
//  CooperChimney
//
//  Created by Karthik Baskaran on 29/09/16.
//  Copyright © 2016 Karthik Baskaran. All rights reserved.
//

#import "SSPopup.h"

#import "UserMessageManager.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <MOBFoundation/MOBFoundation.h>

#import "UIImageView+WebCache.h"
#define KSC ([UIScreen mainScreen].bounds.size.width-150)/4

#define KW ([UIScreen mainScreen].bounds.size.width-240)/4

@interface SSPopup ()
{
    AppDelegate *appDelegate;
    
    NSArray *ordersarray;
    
    UIButton *ParentBtn;
    
    UILabel *_laebl;
    
}

/**
 *  是否开启摇一摇分享
 */
@property (nonatomic) BOOL enableShakeShare;

/**
 *  表格视图
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  面板
 */
@property (nonatomic, strong) UIView *panelView;

/**
 *  加载视图
 */
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end
@implementation SSPopup

- (id)initWithFrame:(CGRect)frame delegate:(id<SSPopupDelegate>)delegate
{
    self = [super init];
    if ((self = [super initWithFrame:frame]))
    {
        self.SSPopupDelegate = delegate;
    }
    
    return self;
}


-(void)CreateTableview:(NSArray *)Contentarray withSender:(id)sender  withTitle:(NSString *)title setCompletionBlock:(VSActionBlock )aCompletionBlock{
    
    
    [self addTarget:self action:@selector(CloseAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.alpha=0;
    self.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.5];
    completionBlock=aCompletionBlock;
    ParentBtn=(UIButton *)sender;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Title=title;

    
   DropdownTable=[[UITableView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-(self.frame.size.width/1.2)/2,self.frame.size.height/2-(self.frame.size.height/3)/2,self.frame.size.width/1.2,self.frame.size.height/3)];
    DropdownTable.backgroundColor=[UIColor whiteColor];
    DropdownTable.dataSource=self;
    DropdownTable.showsVerticalScrollIndicator=NO;
    DropdownTable.delegate=self;
    DropdownTable.layer.cornerRadius=5.0f;
    DropdownTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [self addSubview:DropdownTable];

    
    ordersarray=[[NSArray alloc]initWithArray:Contentarray];
    
    
    NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone,
                    
                    self.alpha=1;
               
)completion:nil];
    
}

-(void)CreateYTView:(NSArray *)Contentarray withSender:(id)sender withTitle:(NSString *)title setCompletionBlock:(VSActionBlock )aCompletionBlock{
    
    
    [self addTarget:self action:@selector(CloseAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.alpha=0;
    self.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.5];
    completionBlock=aCompletionBlock;
    ParentBtn=(UIButton *)sender;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Title=title;

    NSInteger i;
    kScreen_Width>375?(i=3):(i=2);
    CGFloat fixelW = CGImageGetWidth([UIImage imageNamed:@"弹窗1"].CGImage)/i;
    CGFloat fixelH = CGImageGetHeight([UIImage imageNamed:@"弹窗1"].CGImage)/i;

    CGFloat scale=fixelH/fixelW;

    fixelW=kScreen_Width-Width(72);
    fixelH=fixelW*scale;

    
    YTView=[[UIView alloc]initWithFrame:CGRectMake((kScreen_Width-fixelW)/2.0,(kScreenHeight-fixelH)/2.0,fixelW,fixelH)];
    
    YTView.backgroundColor=[UIColor clearColor];
    
    YTView.layer.cornerRadius=5.0f;
    
    
//    
//    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 50)];
//    
//    label.text=@"jdvbjbvndbm";
//    
//    [YTView addSubview:label];
    
    
    [self addSubview:YTView];

    
    imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fixelW, fixelH)];
    
    
    imgView.backgroundColor=[UIColor clearColor];
    
    imgView.image=[UIImage imageNamed:@"弹窗1"];
    
    
    [YTView addSubview:imgView];
    
    UIButton *delete=[UIButton buttonWithType:UIButtonTypeCustom];
    
    delete.frame=CGRectMake(fixelW-15, 5, 30, 30);
    
    
    [delete addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [YTView addSubview:delete];
    
    [delete setBackgroundImage:[UIImage imageNamed:@"删除按钮"] forState:0];
    
    
    
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        
        _laebl = [[UILabel alloc] initWithFrame:CGRectMake(20, fixelH-130, fixelW-40, 50)];
        
    }else{
        
        _laebl = [[UILabel alloc] initWithFrame:CGRectMake(20, fixelH-95, fixelW-40, 50)];
        
    }
    
    NSArray *array = [title componentsSeparatedByString:@"@"];
    
    NSString *con = [array componentsJoinedByString:@"\n"];
    
    _laebl.text = con;
    

    
    _laebl.textAlignment=NSTextAlignmentLeft;
    
    _laebl.font=[UIFont fontWithName:@"PingFangSC-Medium" size:10];
    
    _laebl.textColor=[UIColor whiteColor];
    
    _laebl.numberOfLines=0;
    
    [YTView addSubview:_laebl];
    
    UIButton *goButton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        
        goButton.frame=CGRectMake(80, fixelH-60, fixelW-160, 45);
        
    }else{
        
        goButton.frame=CGRectMake(80, fixelH-40, fixelW-160, 30);
        
    }
    
    [goButton setBackgroundImage:[UIImage imageNamed:@"框"] forState:0];
    
    [goButton setTitle:@"立即升级" forState:0];
    
    goButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:18];
    
    [goButton setTitleColor:[UIColor whiteColor] forState:0];
    
    [goButton addTarget:self action:@selector(goBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [YTView addSubview:goButton];
    
    ordersarray=[[NSArray alloc]initWithArray:Contentarray];
    
    
    NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone,
                    
                    self.alpha=1;
                    
                    )completion:nil];
    
}


-(void)setContent:(NSString *)content
{
    
    NSLog(@"===content===%@",_content);
    
    _content = content;
//    
//    _laebl.text = _content;
    
}

-(void)goBtnClick
{
    
    NSLog(@"6666666666");
    
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"https://itunes.apple.com/cn/app/tao-hui-o2o-dian-shang-ping/id1097442593?mt=8"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}


-(void)QuXiaoBtnClick
{
    
    [self CloseAnimation];
}
-(void)BtnClick
{
    
    [self CloseAnimation];
    
    NSLog(@"888888888888");
    
    
}


//分享弹框
-(void)CreateShallView:(NSArray *)Contentarray withSender:(id)sender withTitle:(NSString *)title setCompletionBlock:(VSActionBlock )aCompletionBlock
{
    
    
//    //加载等待视图
//    self.panelView = [[UIView alloc] initWithFrame:self.view.bounds];
//    self.panelView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.panelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//    
//    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    self.loadingView.frame = CGRectMake((self.view.frame.size.width - self.loadingView.frame.size.width) / 2, (self.view.frame.size.height - self.loadingView.frame.size.height) / 2, self.loadingView.frame.size.width, self.loadingView.frame.size.height);
//    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
//    [self.panelView addSubview:self.loadingView];
    
    
    
    self.href=title;
    
    [self addTarget:self action:@selector(CloseAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.alpha=0;
    self.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.5];
    completionBlock=aCompletionBlock;
    ParentBtn=(UIButton *)sender;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    Title=title;

    YTView=[[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-255,[UIScreen mainScreen].bounds.size.width,255)];
    
    YTView.backgroundColor=[UIColor whiteColor];
    
    
    //微信
    
    UIImageView *weixin=[[UIImageView alloc] initWithFrame:CGRectMake(KSC, 20, 50, 50)];
    weixin.image=[UIImage imageNamed:@"微信"];
    [YTView addSubview:weixin];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(KW+10, 70, 80, 20)];
    label1.text=@"微信好友";
    
//    label1.backgroundColor=[UIColor redColor];
    
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor=[UIColor blackColor];
    label1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [YTView addSubview:label1];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.frame=CGRectMake(KW+10, 20, 80, 90);
    
    [button1 addTarget:self action:@selector(ShallToWeiXinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [YTView addSubview:button1];
    
    
    //朋友圈
    UIImageView *pengyouquan=[[UIImageView alloc] initWithFrame:CGRectMake(KSC*2+50, 20, 50, 50)];
    
    pengyouquan.image=[UIImage imageNamed:@"朋友圈"];
    [YTView addSubview:pengyouquan];
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(KW*2+80, 70, 80, 20)];
    label2.text=@"微信朋友圈";
    label2.textAlignment=NSTextAlignmentCenter;
//    label2.backgroundColor=[UIColor redColor];
    
    label2.textColor=[UIColor blackColor];
    label2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [YTView addSubview:label2];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button2.frame=CGRectMake(KW*2+80, 20, 80, 90);
    
    [button2 addTarget:self action:@selector(ShallToPengYouQuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [YTView addSubview:button2];
    //新浪微博
    
    UIImageView *xinlang=[[UIImageView alloc] initWithFrame:CGRectMake(KSC*3+100, 20, 50, 50)];
    
    xinlang.image=[UIImage imageNamed:@"微博"];
    [YTView addSubview:xinlang];
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(KW*3+160-10, 70, 80, 20)];
    label3.text=@"新浪微博";
    label3.textAlignment=NSTextAlignmentCenter;
//    label3.backgroundColor=[UIColor redColor];
    
    label3.textColor=[UIColor blackColor];
    label3.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [YTView addSubview:label3];
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button3.frame=CGRectMake(KW*3+160-10, 20, 80, 90);
    
    [button3 addTarget:self action:@selector(ShallToXinLangBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [YTView addSubview:button3];
    //QQ好友
    
    UIImageView *QQ=[[UIImageView alloc] initWithFrame:CGRectMake(KSC, 110, 50, 50)];
    
    QQ.image=[UIImage imageNamed:@"QQ"];
    [YTView addSubview:QQ];
    
    UILabel *label4=[[UILabel alloc] initWithFrame:CGRectMake(KW+10, 160, 80, 20)];
    label4.text=@"QQ";
    label4.textAlignment=NSTextAlignmentCenter;
    label4.textColor=[UIColor blackColor];
//    label4.backgroundColor=[UIColor redColor];
    
    label4.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [YTView addSubview:label4];
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button4.frame=CGRectMake(KW+10, 110, 180, 90);
    
    [button4 addTarget:self action:@selector(ShallToQQBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [YTView addSubview:button4];
    
    //QQ空间
    
    UIImageView *Zome=[[UIImageView alloc] initWithFrame:CGRectMake(KSC*2+50, 110, 50, 50)];
    
    Zome.image=[UIImage imageNamed:@"空间"];
    [YTView addSubview:Zome];
    
    UILabel *label5=[[UILabel alloc] initWithFrame:CGRectMake(KW*2+80, 160, 80, 20)];
    label5.text=@"QQ空间";
    label5.textAlignment=NSTextAlignmentCenter;
    label5.textColor=[UIColor blackColor];
//    label5.backgroundColor=[UIColor redColor];
    
    label5.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [YTView addSubview:label5];
    
    UIButton *button5=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button5.frame=CGRectMake(KW*2+80, 110, 80, 90);
    
    [button5 addTarget:self action:@selector(ShallToZomeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [YTView addSubview:button5];
    
    
    UIImageView *fengeline=[[UIImageView alloc] initWithFrame:CGRectMake(0, 255-50-1, [UIScreen mainScreen].bounds.size.width, 1)];
    fengeline.image=[UIImage imageNamed:@"分割线-拷贝"];
    [YTView addSubview:fengeline];
    
    
    UIButton *QuXiao=[UIButton buttonWithType:UIButtonTypeCustom];
    QuXiao.frame=CGRectMake(0, 255-50, [UIScreen mainScreen].bounds.size.width, 50);
    [QuXiao setBackgroundColor:[UIColor whiteColor]];
    [QuXiao setTitle:@"取消" forState:0];
    [QuXiao setTitleColor:[UIColor blackColor] forState:0];
    QuXiao.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [YTView addSubview:QuXiao];
    [QuXiao addTarget:self action:@selector(QuXiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:YTView];
    
    ordersarray=[[NSArray alloc]initWithArray:Contentarray];
    
    
    NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone,
                    
                    self.alpha=1;
                    
                    )completion:nil];
    
    
    
    
}


//分享到微信好友
-(void)ShallToWeiXinBtnClick
{
    
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
//    __weak ViewController *theController = self;
//    [self showLoadingView:YES];
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    NSArray* imageArray = @[[UIImage imageNamed:@"108x108.png"]];
    
    
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"安淘惠，邀朋友注册，享推荐奖励，立即前往"
                                         images:imageArray
                                            url:[NSURL URLWithString:self.href]
                                          title:@"安淘惠•惠生活!"
                                           type:SSDKContentTypeWebPage];
        
        [shareParams SSDKEnableUseClientShare];
        
        //进行分享
        [ShareSDK share:SSDKPlatformSubTypeWechatSession
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
//             [theController showLoadingView:NO];
//             [theController.tableView reloadData];
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"您未安装微信"]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     
                     break;
                 }
                 default:
                     break;
             }
         }];
    }

    
}

//分享到微信朋友圈
-(void)ShallToPengYouQuanBtnClick
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
//    __weak ViewController *theController = self;
//    [self showLoadingView:YES];
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    NSArray* imageArray = @[[UIImage imageNamed:@"108x108.png"]];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"安淘惠，邀朋友注册，享推荐奖励，立即前往"
                                         images:imageArray
                                            url:[NSURL URLWithString:self.href]
                                          title:@"安淘惠•惠生活!"
                                           type:SSDKContentTypeWebPage];
        
        [shareParams SSDKEnableUseClientShare];
        
        //进行分享
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
//             [theController showLoadingView:NO];
//             [theController.tableView reloadData];
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"您未安装微信"]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     [self CloseAnimation];
                     
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     
                     break;
                 }
                 default:
                     break;
             }
         }];
    }

    
    
}

////分享到新浪
-(void)ShallToXinLangBtnClick
{
    
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
//    __weak ViewController *theController = self;
//    [self showLoadingView:YES];
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    NSArray* imageArray = @[[UIImage imageNamed:@"108x108.png"]];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"安淘惠，邀朋友注册，享推荐奖励，立即前往"
                                         images:imageArray
                                            url:[NSURL URLWithString:self.href]
                                          title:@"安淘惠•惠生活!"
                                           type:SSDKContentTypeWebPage];
        
        [shareParams SSDKEnableUseClientShare];
        
        
        //SSDKPlatformTypeSinaWeibo
        
        //进行分享
        [ShareSDK share:SSDKPlatformTypeSinaWeibo
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
//             [theController showLoadingView:NO];
//             [theController.tableView reloadData];
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     [self CloseAnimation];
                     
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"您未安装新浪微博"]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     [self CloseAnimation];
                     
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     break;
                 }
                 default:
                     break;
             }
         }];
    }

}
//分享到QQ
-(void)ShallToQQBtnClick
{
    
    NSLog(@"========%@==",self.href);
    
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
//    __weak ViewController *theController = self;
//    [self showLoadingView:YES];
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    NSArray* imageArray = @[[UIImage imageNamed:@"108x108.png"]];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"安淘惠，邀朋友注册，享推荐奖励，立即前往"
                                         images:imageArray
                                            url:[NSURL URLWithString:self.href]
                                          title:@"安淘惠•惠生活!"
                                           type:SSDKContentTypeWebPage];
        
        [shareParams SSDKEnableUseClientShare];
        
        //进行分享
        [ShareSDK share:SSDKPlatformSubTypeQQFriend
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
//             [theController showLoadingView:NO];
//             [theController.tableView reloadData];
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"您未安装QQ"]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     
                     [self CloseAnimation];
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     [self CloseAnimation];
                     
                     break;
                 }
                 default:
                     break;
             }
         }];
    }

    
}
//分享到空间
-(void)ShallToZomeBtnClick
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
//    __weak ViewController *theController = self;
//    [self showLoadingView:YES];
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    NSArray* imageArray = @[[UIImage imageNamed:@"108x108.png"]];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"安淘惠，邀朋友注册，享推荐奖励，立即前往"
                                         images:imageArray
                                            url:[NSURL URLWithString:self.href]
                                          title:@"安淘惠•惠生活!"
                                           type:SSDKContentTypeWebPage];
        
        [shareParams SSDKEnableUseClientShare];
        
        //进行分享
        [ShareSDK share:SSDKPlatformSubTypeQZone
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
//             [theController showLoadingView:NO];
//             [theController.tableView reloadData];
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"您未安装QQ"]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
//                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                         message:nil
//                                                                        delegate:nil
//                                                               cancelButtonTitle:@"确定"
//                                                               otherButtonTitles:nil];
//                     [alertView show];
                     
                     [self CloseAnimation];
                     
                     break;
                 }
                 default:
                     break;
             }
         }];
    }

    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return tableView.frame.size.height/4;
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *myview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
[myview setBackgroundColor:RGB(227, 9, 50)];
    
    
    UILabel *headLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, myview.frame.size.width, tableView.frame.size.height/4)];
    headLbl.backgroundColor=[UIColor clearColor];
    headLbl.textColor=[UIColor whiteColor];
    headLbl.text=Title?Title:@"Select";
    headLbl.textAlignment=NSTextAlignmentCenter;
    headLbl.font=AvenirMedium(18);
    [myview addSubview:headLbl];
    
    
    return myview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height/4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [ordersarray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.backgroundColor=[UIColor whiteColor];
    
    
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    for (UILabel *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UILabel class]])
        {
            [lbl removeFromSuperview];
        }
    }
    
    
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    UILabel *Contentlbl =[[UILabel alloc]initWithFrame:CGRectMake(10,0,tableView.frame.size.width-20,tableView.frame.size.height/4)];
    Contentlbl.backgroundColor=[UIColor clearColor];
    Contentlbl.text=[ordersarray objectAtIndex:indexPath.row];
    Contentlbl.textColor=[UIColor blackColor];
    Contentlbl.textAlignment=NSTextAlignmentLeft;
    Contentlbl.font=AvenirMedium(16);
    [cell.contentView addSubview:Contentlbl];

    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, Contentlbl.frame.origin.y+Contentlbl.frame.size.height-2,self.frame.size.width, 1.2)];
    lineView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [Contentlbl addSubview:lineView];
    
    if(indexPath.row == [ordersarray count] -1){
        
        lineView.hidden=YES;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor=RGB(248, 218, 218);
    

    [ParentBtn setTitle:[ordersarray objectAtIndex:indexPath.row] forState:UIControlStateNormal]; //Setting title for Button


    if (completionBlock) {
        
         completionBlock((int)indexPath.row);
    }
    
    if ([self.SSPopupDelegate respondsToSelector:@selector(GetSelectedOutlet:)]) {
        
         [self.SSPopupDelegate GetSelectedOutlet:(int)indexPath.row];
    }
    
    
    [self CloseAnimation];
    

}

-(void)CloseAnimation{
    
    
     NSLog(@"7777777777777777777");
    
    [UserMessageManager SaveShenJi:@"YES"];
    
    NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone,
                    
                    DropdownTable.alpha=0;
                    
                    
                    
                    )
completion:^(BOOL finished){
    
    [DropdownTable removeFromSuperview];
    [self removeFromSuperview];
    
    
}];
}

@end
