//
//  XLDingDanSearchVC.m
//  aTaohMall
//
//  Created by Hawky on 2018/3/14.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLDingDanSearchVC.h"
#import "SearchManager.h"


@interface XLDingDanSearchVC ()<UITextFieldDelegate>
{
    UIButton *rightBtn;
    UIScrollView *_scroll;
    UITapGestureRecognizer * tap ;
    NSArray *_searchHistoryArr;

}
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *searchBackView;
@property (strong, nonatomic) IBOutlet UIImageView *searchIcon1;
@property (strong, nonatomic) IBOutlet UIButton *cancleBut;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@end

@implementation XLDingDanSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle =UIModalPresentationCustom;

    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWindow:)];
    [self.view addGestureRecognizer:tap];
    [self initUI];
    // Do any additional setup after loading the view.
}

-(void)initUI
{
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    self.view.frame=[UIScreen mainScreen].bounds;
    [self initNavi];

    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
    _scroll.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scroll];
    // [self initScrollView];
    [self readNSUserDefaults];
    
}
-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    _searchHistoryArr= [userDefaultes arrayForKey:@"myDingDanArray"];
    _searchHistoryArr=[[_searchHistoryArr reverseObjectEnumerator] allObjects];
    [self initScrollView];
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
        lab.text=@"搜索记录";
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
    if (height>(kScreenHeight-KSafeAreaTopNaviHeight)) {
        _scroll.frame=CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight);
    }else
    {
        _scroll.frame=CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, height);
    }
    //  _scroll.backgroundColor=[UIColor blueColor];
    _scroll.contentSize=CGSizeMake(kScreen_Width, height);
}

/*****  <#desc#> *****/
-(void)clickWindow:(UITapGestureRecognizer *)tap
{
    CGPoint point=[tap locationInView:self.view];
    if (point.y>_scroll.frame.size.height+KSafeAreaTopNaviHeight) {
        [self qurtBtnClick];
    }
}

-(void)qurtBtnClick
{
    [self.searchTextField resignFirstResponder];
     [self dismissViewControllerAnimated:YES completion:^{

     }];
}

-(void)initNavi
{

    self.searchTextField=[[UITextField alloc] init];
    self.searchBackView=[[UIImageView alloc] init];
    self.searchIcon1=[[UIImageView alloc] init];
    [self.searchBackView setImage:KImage(@"搜索长框")];
    [self.searchIcon1 setImage:KImage(@"xl-Search Icon")];
    _navView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight)];
    _navView.backgroundColor=[UIColor whiteColor];

    [_navView addSubview:self.searchBackView];
    [_navView addSubview:self.searchIcon1];
    [_navView addSubview:self.searchTextField];

    self.searchBackView.frame=CGRectMake(15, 27+KSafeTopHeight, kScreen_Width-30-30-10, 32);
    self.searchIcon1.frame=CGRectMake(30, 37+KSafeTopHeight, 14, 14);
    self.searchTextField.frame=CGRectMake(30+14+5, 34+KSafeTopHeight, kScreen_Width-30-14-5-30-15-10-15, 20);
    self.searchTextField.placeholder=@"可搜索订单号/商品名称";
    self.searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.searchTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    self.searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchTextField.contentVerticalAlignment=NSTextAlignmentCenter;
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.01)];
    self.searchTextField.inputAccessoryView=customView;

    self.searchTextField.delegate = self;
    self.searchTextField.font=KNSFONT(14);


    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreen_Width-15-30, 28+KSafeTopHeight, 30, 30);
    // [rightBtn setImage:KImage(@"xl-btn-change2") forState:UIControlStateNormal];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGB(74, 74, 74) forState:UIControlStateNormal];
    rightBtn.titleLabel.font=KNSFONT(15);
    [rightBtn addTarget:self action:@selector(qurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //  rightBtn.hidden=YES;
    [_navView addSubview:rightBtn];
    [self.view addSubview:_navView];

    UIImageView *Line=[[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, kScreen_Width, 1)];
    Line.image=KImage(@"分割线-拷贝");
    [_navView addSubview:Line];

}
//
-(void)changeValue:(UITextField *)tf
{
    if (tf.text.length==0) {
       
        _scroll.hidden=NO;
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
//确定搜索
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchText:textField.text];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [SearchManager removeAllDingDanArray];
        _searchHistoryArr=@[];
        [self initScrollView];
    }]];
    [self presentViewController:alert animated:YES completion:^{

    }];

}
-(void)searchText:(NSString *)str
{
    //   cancle=YES;
    if (str.length==0) {
        [TrainToast showWithText:@"输入的搜索内容不能为空!" duration:2.0f];
    }else
    {
        if (_delegate&&[_delegate respondsToSelector:@selector(searchText:)]) {
            [_delegate searchText:str];
            [self qurtBtnClick];
        }
    }
}
@end
