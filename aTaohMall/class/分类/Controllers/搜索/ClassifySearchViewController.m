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

@interface ClassifySearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,SearchResultViewControllerDelegate>
{
    UITableView *_tableView;
    UISearchController *searchController;
    UISearchDisplayController *searchDisplayController;
    
    UIButton *loginBtn;
    UIButton *backBtn;
    
    UIButton *deleteDisBtn;
    
    NSArray *disArr;
    
    UIAlertController *alertCon;
    
    UILabel *SearchRecordLabel;
    
    DeleteCell * cell;

    NSArray *MYTitleArr;
}
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *deleteAllBut;
@property (weak, nonatomic) IBOutlet UIView *FenGeView;
@property (weak, nonatomic) IBOutlet UILabel *searchJiLuLab;

@property (weak, nonatomic) IBOutlet UIView *navView;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组
@property(nonatomic,strong)NSMutableArray *myArrM;

@property(nonatomic,strong)NSMutableArray *deleteArrM;

@end

@implementation ClassifySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    self.view.frame=[UIScreen mainScreen].bounds;
    
    _myArrM=[NSMutableArray new];
    
    _deleteArrM=[NSMutableArray new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.myTableView.backgroundColor = BGCOLOR;
    self.searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchTextField.delegate = self;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myTableView.separatorColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0];
    
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTableView.bounces=NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"DeleteCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
   
    [self readNSUserDefaults];
    [self setTopView];
   [_tableView reloadData];
   
}

- (IBAction)deleteAllSearch:(id)sender {
    [self deleteBtnClick];
}


-(void)setTopView
{
    NSString *str=@"电器 手机 平板 化妆 钟表 IPHONE 笔记本 沐浴露 围巾 毛衣";
    NSArray *titleArr=[str componentsSeparatedByString:@" "];

    MYTitleArr = [titleArr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];

    CGFloat marin=12;
    CGFloat buttonWith=16;
    CGFloat buttonHeight=29;

    CGFloat height=45;

    CGFloat width=marin;
    for (int i=0; i<MYTitleArr.count; i++) {

        NSString *str=MYTitleArr[i];
        CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:KMAXSIZE];

        if (width+size.width+buttonWith+marin>kScreenWidth) {
            width=marin;
            if (height==84) {
                i=(int)titleArr.count;
                break;
            }else
            {
                height=84;
            }
        }
        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(width, height, buttonWith+size.width, buttonHeight);
        width+=buttonWith+size.width+marin;
        [but setTitle:str forState:UIControlStateNormal];
        [but addTarget:self action:@selector(clickReMen:) forControlEvents:UIControlEventTouchUpInside];
        but.tag=1400+i;
        [but.layer setCornerRadius:3];
        [but setBackgroundColor:RGB(245, 245, 245)];
        [but setTitleColor:RGB(74, 74, 74) forState:UIControlStateNormal];
        but.titleLabel.font=KNSFONT(14);
        [_topView addSubview:but];
    }
}

-(void)setTopShow:(BOOL)Show
{
    self.searchJiLuLab.hidden=!Show;
    self.deleteAllBut.hidden=!Show;
    self.FenGeView.hidden=!Show;
    self.lineView.hidden=!Show;
}

-(void)clickReMen:(UIButton *)sender
{

    NSString *str=MYTitleArr[sender.tag-1400];

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    [SearchManager SearchText:str];//缓存搜索记录
    [self readNSUserDefaults];
    [_myArrM addObject:str];
    //跳转到搜索结果界面
    if (1) {
    SearchResultViewController *vc=[[SearchResultViewController alloc] init];
    vc.searchResultTextField.text=str;
        vc.delegate=self;
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    self.myArray = myArray;
    vc.resultArrM= _myArrM;
    [self.navigationController pushViewController:vc animated:NO];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {

        //---------------------------
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];

            
            [SearchManager SearchText:textField.text];//缓存搜索记录
            [self readNSUserDefaults];
            
            
            [_myArrM addObject:textField.text];
            

        
        NSLog(@"搜索被点击了");
        
    }else{
        NSLog(@"请输入查找内容");
    }
    textField.text = @"";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.returnKeyType=UIReturnKeySearch;
    textField.delegate=self;
    
    if (self.searchTextField.text.length==0) {
        
        
        [JRToast showWithText:@"输入的搜索内容不能为空!" duration:2.0f];
        

    }else{
        
        //跳转到搜索结果界面
        [_myArrM addObject:self.searchTextField.text];
        SearchResultViewController *vc=[[SearchResultViewController alloc] init];
        vc.searchResultTextField.text=self.searchTextField.text;
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
        self.myArray = myArray;
        vc.resultArrM= _myArrM;
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:NO];
        [_tableView reloadData];
    }
    
    return YES;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _myArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.imageView.image=KImage(@"xl-时间");
        UIView *lineView1=[[UIView alloc] initWithFrame:CGRectMake(10, 43, kScreenWidth, 1)];
        lineView1.backgroundColor=RGB(242, 242, 242);
        [cell1 addSubview:lineView1];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(42, 0, kScreenWidth-42-83, 44)];
        lab.font=KNSFONT(14);
        lab.textColor=RGB(102, 102, 102);
        lab.tag=500;
        [cell1 addSubview:lab];

    NSArray *reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
    lab.text=reversedArray[indexPath.row];
    return cell1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];

        NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
        NSString *name=reversedArray[indexPath.row];
        [SearchManager SearchText:name];//缓存搜索记录
        [self readNSUserDefaults];
        NSLog(@"==%@",name);
        [_myArrM addObject:name];
        SearchResultViewController *vc=[[SearchResultViewController alloc] init];
        vc.searchResultTextField.text=name;
        vc.resultArrM=_myArrM;
    vc.delegate=self;
        [self.navigationController pushViewController:vc animated:NO];


   
}

-(void)searchNewInformation:(NSString *)str
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    [SearchManager SearchText:str];//缓存搜索记录
    [self readNSUserDefaults];
}

//清除搜索记录
-(void)deleteBtnClick
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除所有搜索记录" message:@"" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SearchManager removeAllArray];
        _myArray = nil;
        [self setTopShow:NO];
        [self.myTableView reloadData];
    }];
    //            UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    //            [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    self.myArray = myArray;
    
    for (NSString *str in self.myArray) {
        [_deleteArrM addObject:str];
    }
    [self setTopShow:self.myArray.count>0?YES:NO];
    [self.myTableView reloadData];
    NSLog(@"myArray======%@",myArray);
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//滑动删除操作
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//删除一行内容
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

        
        _myArray = [[_myArray reverseObjectEnumerator] allObjects];
        NSMutableArray *array = [NSMutableArray arrayWithArray:_myArray];
        
        [array removeObjectAtIndex:indexPath.row];
        YLog(@"array.count=%ld",array.count);
        _myArray=nil;
        //_myArray = array;
        _myArray = [[array reverseObjectEnumerator] allObjects];
        //其次应该从tableview中删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //缓存数据
        [_myArrM removeAllObjects];
        _myArrM = [NSMutableArray arrayWithArray:_myArray];
        [SearchManager removeAllArray];//清除所有数据
        for (NSString *str in _myArrM) {
            [SearchManager SearchText:str];//缓存搜索记录
        }
    if (_myArray.count==0) {
        [self setTopShow:NO];
    }

    
}

//取消按钮
- (IBAction)cancleBtnClick:(UIButton *)sender {
    self.searchTextField.text = @"";
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
}

//键盘下落
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.searchTextField.text = @"";
    [self.view endEditing:YES];
    
    [self.searchTextField resignFirstResponder];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.searchTextField resignFirstResponder];
}

@end
