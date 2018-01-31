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

    [self readNSUserDefaults];

}
-(void)initData
{
    _searchHistoryArr=[[NSMutableArray alloc] init];
    _reMenSouSuoArr=[[NSMutableArray alloc] init];
    _searchWordArr=[[NSMutableArray alloc] init];
    isShowRemen=YES;
}

-(void)initUI
{
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    self.view.frame=[UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavi];
    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
    [self.view addSubview:_scroll];

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
        but.frame=CGRectMake(kScreen_Width-top-16, top, 16, 16);
        [but setImage:KImage(@"") forState:UIControlStateNormal];
        [but addTarget:self action:@selector(deleteAllSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:but];
        height+=top+15+leading;
        CGFloat width=leading;
        CGFloat buttonWith=20;
        for (int i=0; i<_searchHistoryArr.count; i++) {
            NSString *str=_searchHistoryArr[i];

            CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:KMAXSIZE];

            if (width+size.width+buttonWith+leading>kScreenWidth) {
                if (width==leading) {
                    size=CGSizeMake(kScreen_Width-2*leading-buttonWith, 14);
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
        }
        height+=Width(3)+leading+29;
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
        but.frame=CGRectMake(kScreen_Width-top-16, top, 16, 16);

        [but addTarget:self action:@selector(deleteAllSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:but];
        height+=top+15+leading;

        if (isShowRemen) {
            HiddenRemenView.hidden=YES;
            remenView.hidden=NO;
            [but setImage:KImage(@"睁眼") forState:UIControlStateNormal];
            if (!remenView) {
                remenView=[[UIView alloc] init];

            }else
            {

                [remenView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            }
            CGFloat width=leading;
            CGFloat buttonWith=20;
            for (int i=0; i<_reMenSouSuoArr.count; i++) {
                NSString *str=_reMenSouSuoArr[i];

                CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:KMAXSIZE];

                if (width+size.width+buttonWith+leading>kScreenWidth) {
                    if (width==leading) {
                        size=CGSizeMake(kScreen_Width-2*leading-buttonWith, 14);
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
            }
            height+=Width(3)+leading+29;
            [_scroll addSubview:remenView];
        }else
        {
            HiddenRemenView.hidden=NO;
            remenView.hidden=YES;
            [but setImage:KImage(@"闭眼") forState:UIControlStateNormal];
            if (!HiddenRemenView) {
                HiddenRemenView=[[UIView alloc] init];
                UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, height+20, kScreen_Width, 14)];
                lab.font=KNSFONT(14);
                lab.textColor=RGB(155, 155, 155);
                lab.text=@"当前发现已隐藏";
                [_scroll addSubview:lab];

            }
            height+=20+14+20;
            [_scroll addSubview:HiddenRemenView];
        }


    }

    _scroll.contentSize=CGSizeMake(kScreen_Width, height);
}



//点击历史记录
-(void)clickHistoryBtn:(UIButton *)sender
{
    NSString *str=_reMenSouSuoArr[sender.tag-1400];
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
    [self searchText:str];
}
//确定搜索
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self searchText:textField.text];
    return YES;
}


-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
     _searchHistoryArr= [userDefaultes arrayForKey:@"myArray"];
    [self initScrollView];
}
#pragma mark-协议
-(void)searchNewInformation:(NSString *)str
{
    [self searchText:str];
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
