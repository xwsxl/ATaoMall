//
//  JXSelectDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "JXSelectDetailViewController.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"
#import "WKProgressHUD.h"

#import "DPModel.h"
#import "TrainToast.h"

#import "UIImageView+WebCache.h"
#import "YTGoodsDetailViewController.h"
@interface JXSelectDetailViewController ()<UIWebViewDelegate>
{
    
    UIWebView *_webView;
    UIView *NoView;
    UIImageView *NoImgView;
    UILabel *NOLabel;
    
}
@end

@implementation JXSelectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self initNav];
    
    [self getdatas];
    
}

-(void)getdatas
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
    });
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict=@{@"id":self.ID};
    
    NSString *url=[NSString stringWithFormat:@"%@getSelectionListingDetails_mob.shtml",URL_Str];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"====清单之前===xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict in dic[@"list"]) {
                        
                        
                    self.mid = [NSString stringWithFormat:@"%@",dict[@"mid"]];
                    self.content = [NSString stringWithFormat:@"%@",dict[@"content"]];
                    self.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
                    self.summary = [NSString stringWithFormat:@"%@",dict[@"summary"]];
                }
                
                [self initWebView];

                
            }else if([dic[@"status"] isEqualToString:@"10001"]){
                
                [self initNoView];
                
            }else{
                
                [TrainToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            
            [hud dismiss:YES];
            
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [hud dismiss:YES];
        
        
        
        NSLog(@"errpr = %@",error);
    }];
    
}
//创建导航栏
-(void)initNav
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"icon-back"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"清单详情";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initWebView
{
    
    NSLog(@"=======%@",self.title);
    NSLog(@"=======%@",self.summary);
    
    [NoView removeFromSuperview];
    [NoImgView removeFromSuperview];
    [NOLabel removeFromSuperview];
    
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    CGSize textSize = [self.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, textSize.height)];
    
    nameLabel.font=[UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.numberOfLines=0;
    nameLabel.text=self.title;

//    NSString *string = @"jgfjvjfv";
//    UIFont *Otherfont = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
//    CGSize OthertextSize = [self.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : Otherfont} context:nil].size;
    
    UILabel *OthernameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, textSize.height+20, [UIScreen mainScreen].bounds.size.width-20, 40)];
    
    OthernameLabel.font=[UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
//    OthernameLabel.textAlignment = NSTextAlignmentCenter;
    OthernameLabel.numberOfLines=0;
    OthernameLabel.text=self.summary;
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -(40+textSize.height+20), [UIScreen mainScreen].bounds.size.width, 40+textSize.height+20)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    [bgView addSubview:nameLabel];
    [bgView addSubview:OthernameLabel];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];

    _webView.scalesPageToFit=NO;
    
    _webView.delegate = self;
    
    //解决加载黑边问题
    _webView.opaque = NO;
    
    _webView.backgroundColor = [UIColor whiteColor];
    
    [_webView loadHTMLString:self.content baseURL:nil];
    
    [self.view addSubview:_webView];
    
    //滑动
    _webView.scrollView.scrollEnabled=YES;
    
    
    _webView.scrollView.contentInset=UIEdgeInsetsMake(40+textSize.height+20, 0, 0, 0);
    
    [_webView.scrollView addSubview:bgView];
    
//    [_webView.scrollView addSubview:nameLabel];
//    [_webView.scrollView addSubview:OthernameLabel];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    NSString *URLString = [NSString stringWithFormat:@"%@",request.URL];
    
    NSArray *array = [URLString componentsSeparatedByString:@"="];
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        NSLog(@"====%@==URLString=%@",array[1],URLString);
        
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        
        vc.type= @"3";
        vc.ID = array[1];
        vc.gid = array[1];
        self.navigationController.navigationBar.hidden=YES;
        //    self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:vc animated:NO];
        
        return NO;
    }
    return YES;
    
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    
//    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
//    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    
//    NSLog(@"===点击====%@=====%@",currentURL,title);
//    
//}

//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    
//    //程序会一直调用该方法，所以判断若是第一次加载后就使用我们自己定义的js，此后不在调用JS,否则会出现网页抖动现象
//    //    if (!isFirstLoadWeb) {
//    //        isFirstLoadWeb = YES;
//    //    }else
//    //        return;
//    //给webview添加一段自定义的javascript
//    
//    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function myFunction() { "
//     
//     //     //注意这里的Name为搜索引擎的Name,不同的搜索引擎使用不同的Name
//     //     //<input type="text" name="word" maxlength="64" size="20" id="word"/> 百度手机端代码
//     //     "var field = document.getElementsByName('word')[0];"
//     //
//     //     //给变量取值，就是我们通常输入的搜索内容，这里为 code4app.com
//     //     "field.value='code4app.com';"
//     //
//    "document.forms[0].submit();"
//     "var objs = document.getElementsByTagName('img');"
//     "for(var i=0;i<objs.length;i++){"
//     "var img=objs[i];"
//     "img.style.width = '100%';"
//     "img.style.height = 'auto'"
//     "}"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    //开始调用自定义的javascript
//    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
//    
//    
////    //修改字体大小
////    
////    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];//修改百分比即可
////    
////    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=self.view.frame.size.width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\""];
////    
////    [webView stringByEvaluatingJavaScriptFromString:meta];
////    
////    
////    //字体颜色
////    
////    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'"];
//
//}

-(void)initNoView
{
    
    [_webView removeFromSuperview];
    
    NoView = [[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 300)];
    [self.view addSubview:NoView];
    
    NoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-131.5)/2, 100, 131.5, 95)];
    NoImgView.image = [UIImage imageNamed:@"no-found"];
    [NoView addSubview:NoImgView];
    
    NOLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 245.5, [UIScreen mainScreen].bounds.size.width, 15.5)];
    NOLabel.text = @"很抱歉，您查找的文章不存在，可能已下架。";
    NOLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    NOLabel.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    NOLabel.textAlignment = NSTextAlignmentCenter;
    [NoView addSubview:NOLabel];
    
    
}
-(void)QurtBtnClick
{
    
    if ([self.Back isEqualToString:@"100"]) {
        
        [self.navigationController popViewControllerAnimated:NO];
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=NO;
    }else{
        
        [self.navigationController popViewControllerAnimated:NO];
        self.navigationController.navigationBar.hidden=YES;
    }
    
    
}

@end
