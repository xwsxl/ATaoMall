//
//  MerchantSearchViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantSearchViewController.h"

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

#import "MerchantManager.h"

#import "MerchantSearchResultViewController.h"
#define fontCOLOR [UIColor colorWithRed:163/255.0f green:163/255.0f blue:163/255.0f alpha:1]

@interface MerchantSearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
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
    
    UITextField *searchTextField;
    
    UITableView *myTableView;
    
}

@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组
@property(nonatomic,strong)NSMutableArray *myArrM;

@property(nonatomic,strong)NSMutableArray *deleteArrM;


@end

@implementation MerchantSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initNav];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    _myArrM=[NSMutableArray new];
    
    _deleteArrM=[NSMutableArray new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.myTableView.backgroundColor = BGCOLOR;
    searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    searchTextField.delegate = self;
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStylePlain];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    myTableView.separatorColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0];
    
    myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [myTableView registerNib:[UINib nibWithNibName:@"DeleteCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    
    [self.view addSubview:myTableView];
    
    [self readNSUserDefaults];
    
    [_tableView reloadData];
    
    
}


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
    
    Qurt.frame = CGRectMake(15, 25+KSafeTopHeight, 30, 30);
    
    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UIImageView *searchImgView=[[UIImageView alloc] initWithFrame:CGRectMake(55, 26+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-100, 28)];
    searchImgView.image=[UIImage imageNamed:@"搜索框New"];
    [titleView addSubview:searchImgView];
    
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(55+10, 26+8+KSafeTopHeight, 12, 12)];
    imgView.image=[UIImage imageNamed:@"搜索New"];
    [titleView addSubview:imgView];
    
    searchTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 30+KSafeTopHeight, 240, 20)];
    searchTextField.placeholder=@"请输入您要搜索的商户名";
    searchTextField.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    searchTextField.textAlignment=NSTextAlignmentLeft;
    searchTextField.font=[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [titleView addSubview:searchTextField];
    
}

//商圈
-(void)QurtBtnClick
{
    searchTextField.text = @"";
    [self.view endEditing:YES];
    
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        
        //---------------------------
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:@"NewmyArray"];
        
        if (myArray.count==0) {
            
            [MerchantManager SearchText:textField.text];//缓存搜索记录
            [self readNSUserDefaults];
            
            
            [_myArrM addObject:textField.text];
            
        }else{
            
            
            
            if ([myArray containsObject:textField.text]) {
                
                NSLog(@"****相等*****");
            }else{
                NSLog(@"*****不相等****");
                
                [MerchantManager SearchText:textField.text];//缓存搜索记录
                [self readNSUserDefaults];
                
                
                [_myArrM addObject:textField.text];
                
            }
            
        }
        //----------------------------
        
        [_tableView reloadData];
        
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
    
    if (searchTextField.text.length==0) {
        
        
        [JRToast showWithText:@"输入的搜索内容不能为空!" duration:2.0f];
        
        
        //        XSInfoViewStyle *style = [[XSInfoViewStyle alloc] init];
        //        style.info = @"输入的搜索内容不能为空!";
        //
        //        style.layoutStyle = XSInfoViewLayoutStyleHorizontal;
        //
        //        [XSInfoView showInfoWithStyle:style onView:self.view];
    }else{
        
        //跳转到搜索结果界面
        [_myArrM addObject:searchTextField.text];
        
        MerchantSearchResultViewController *vc=[[MerchantSearchResultViewController alloc] init];
        vc.searchString=searchTextField.text;
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:@"NewmyArray"];
        self.myArray = myArray;
        vc.resultArrM= _myArrM;
        //        NSLog(@"===%@",vc.resultArrM);
        
        [self.navigationController pushViewController:vc animated:NO];
        [_tableView reloadData];
    }
    
    return YES;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_myArray.count>0) {
        return _myArray.count+1;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _myArray.count){
        if (_myArray.count==0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            cell.deleteButton.hidden=YES;
            
            //            cell.NoLabel.text=@"无";
            //            cell.NoLabel.textColor=[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0];
            return cell;
            
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            cell.NoLabel.hidden=YES;
            
            [cell.deleteButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }
        
        
    }else{
        
        UITableViewCell * cell1 = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
        NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
        cell1.textLabel.text = reversedArray[indexPath.row];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [UIScreen mainScreen].bounds.size.height/12;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *name = @"搜索记录";
    return name;
}

//改变header的颜色

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor whiteColor];
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0]];
    header.textLabel.font=[UIFont fontWithName:@"AppleGothic" size:18];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==_myArray.count) {
        return [UIScreen mainScreen].bounds.size.height/14;
    }
    myTableView.estimatedRowHeight = [UIScreen mainScreen].bounds.size.height/14;
    //    self.searchTableView.estimatedRowHeight = 44.0f;
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == _myArray.count) {//清除所有历史记录
        
    }else{
        NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
        NSString *name=reversedArray[indexPath.row];
        
        
        NSLog(@"==%@",name);
        
        [_myArrM addObject:name];
        
        MerchantSearchResultViewController *vc=[[MerchantSearchResultViewController alloc] init];
        vc.searchString=name;
        vc.resultArrM=_myArrM;
        [self.navigationController pushViewController:vc animated:NO];
        
    }
    
    
}

//清除搜索记录
-(void)deleteBtnClick
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除所有搜索记录" message:@"" preferredStyle: UIAlertControllerStyleAlert];
    
    //@“ UIAlertControllerStyleAlert，改成这个就是中间弹出"
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MerchantManager removeAllArray];
        _myArray = nil;
        cell.NoLabel.hidden = NO;
        [myTableView reloadData];
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
    NSArray * myArray = [userDefaultes arrayForKey:@"NewmyArray"];
    self.myArray = myArray;
    
    for (NSString *str in self.myArray) {
        [_deleteArrM addObject:str];
    }
    
    [myTableView reloadData];
    NSLog(@"myArray======%@",myArray);
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//滑动删除操作
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _myArray.count) {
        return NO;
    }
    return YES;
}

//删除一行内容
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"count==%ld\n",_myArray.count);
    if (_myArray.count==0) {
        
        _myArray = [[_myArray reverseObjectEnumerator] allObjects];
        NSMutableArray *array = [NSMutableArray arrayWithArray:_myArray];
        
        [array removeObjectAtIndex:indexPath.row];
        _myArray=nil;
        _myArray = array;
        _myArray = [[array reverseObjectEnumerator] allObjects];
        //其次应该从tableview中删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //缓存数据
        [_myArrM removeAllObjects];
        _myArrM = [NSMutableArray arrayWithArray:_myArray];
        [MerchantManager removeAllArray];//清除所有数据
        for (NSString *str in _myArrM) {
            
            [MerchantManager SearchText:str];//缓存搜索记录
            [self readNSUserDefaults];
        }
        
        cell.NoLabel.text=@"无";
        cell.NoLabel.textColor=[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0];
        cell.deleteButton.hidden=YES;
        cell.NoLabel.hidden=NO;
        
    }else{
        
        _myArray = [[_myArray reverseObjectEnumerator] allObjects];
        NSMutableArray *array = [NSMutableArray arrayWithArray:_myArray];
        
        [array removeObjectAtIndex:indexPath.row];
        _myArray=nil;
        _myArray = array;
        _myArray = [[array reverseObjectEnumerator] allObjects];
        //其次应该从tableview中删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //缓存数据
        [_myArrM removeAllObjects];
        _myArrM = [NSMutableArray arrayWithArray:_myArray];
        [MerchantManager removeAllArray];//清除所有数据
        for (NSString *str in _myArrM) {
            
            [MerchantManager SearchText:str];//缓存搜索记录
            [self readNSUserDefaults];
        }
        cell.deleteButton.hidden=NO;
        cell.NoLabel.hidden=YES;
    }
    
    //    [_tableView reloadData];
    
}


//键盘下落
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    searchTextField.text = @"";
    [self.view endEditing:YES];
    
    [searchTextField resignFirstResponder];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [searchTextField resignFirstResponder];
}

@end
