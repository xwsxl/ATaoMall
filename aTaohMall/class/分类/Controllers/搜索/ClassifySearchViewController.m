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

#import "SearchResultViewController.h"//搜索结果

#import "XSInfoView.h"

#import "JRToast.h"
#define fontCOLOR [UIColor colorWithRed:163/255.0f green:163/255.0f blue:163/255.0f alpha:1]

@interface ClassifySearchViewController ()<UITextFieldDelegate,SearchResultViewControllerDelegate>
{
    NSArray *_searchHistoryArr;
    NSArray *_reMenSouSuoArr;
    NSArray *_IDArr;
    NSArray *_searchWordArr;

    UIScrollView *_scroll;
    BOOL isShowRemen;
    UIView  *remenView;
    UIView  *HiddenRemenView;
}

@property (weak, nonatomic) IBOutlet UIView *navView;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation ClassifySearchViewController

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
}

//为你推荐
-(void)getKeyWordsData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
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

}
-(void)initNavi
{
    self.searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchTextField.delegate = self;
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
        but.frame=CGRectMake(kScreen_Width-top-16, top+height, 16, 16);
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
        but.frame=CGRectMake(kScreen_Width-top-16, top+height, 16, 16);

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
                lab.text=@"当前发现已隐藏";
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
    [UIAlertTools showAlertWithTitle:nil message:@"确定删除全部历史搜索记录？" cancelTitle:@"取消" titleArray:@[] viewController:self confirm:^(NSInteger buttonTag) {
        if (buttonTag==0) {
            [SearchManager removeAllArray];
            _searchHistoryArr=@[];
            [self initScrollView];
        }
    }];

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
    if (str.length==0) {
    [JRToast showWithText:@"输入的搜索内容不能为空!" duration:2.0f];
    }else
    {
        [SearchManager SearchText:str];//缓存搜索记录
        [self readNSUserDefaults];
        //跳转到搜索结果界面
        SearchResultViewController *vc=[[SearchResultViewController alloc] init];
        vc.searchResultTextField.text=str;
        vc.delegate=self;
        vc.resultArrM= [[NSArray arrayWithObject:str] mutableCopy];
        [self.navigationController pushViewController:vc animated:NO];
    }

}

//取消按钮
- (IBAction)cancleBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
