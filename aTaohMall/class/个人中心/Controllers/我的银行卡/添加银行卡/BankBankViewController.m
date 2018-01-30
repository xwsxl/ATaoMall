//
//  BankBankViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/7.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "BankBankViewController.h"

#import "BankBankCell.h"

#import "BankBankModel.h"
@interface BankBankViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_ImageArray;
    NSArray *_NameArray;
    NSArray *_BankArray;
    
    NSMutableArray *_datas;
}
@end

@implementation BankBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _datas=[NSMutableArray new];
    
    [self initTableView];
    
    [self getDatas];
    
    // code1
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // code2
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    
    
}

-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-66) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"BankBankCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

-(void)getDatas
{
    _BankArray=@[@"105100000017",@"102100099996",@"308584000013",@"104100000004",@"307584007998",@"310290000013",@"403100000004",@"103100000026",@"302100011000",@"309391000011",@"306581000003",@"305100000013",@"301290000007",@"304100040000",@"303100000006"];
    _ImageArray=@[@"建行@2x 11-27-35-271",@"工商@2x",@"招商@2x",@"中行@2x 11-27-34-990",@"平安@2x",@"浦发@2x",@"邮政@2x",@"农行@2x 11-27-35-193",@"中信@2x11-27",@"兴业@2x",@"广发@2x 11-27-35-257",@"民生@2x11-27",@"交通@2x",@"华夏@2x 11-27-34-893",@"光大@2x 11-27-35-270"];
    _NameArray=@[@"中国建设银行",@"中国工商银行",@"招商银行",@"中国银行",@"平安银行",@"浦发银行",@"中国邮政储蓄银行",@"农业银行",@"中信银行",@"兴业银行",@"广发银行",@"中国民生银行",@"交通银行",@"华夏银行",@"中国光大银行"];
    
    for (int i=0; i<_ImageArray.count; i++) {
        BankBankModel *model=[[BankBankModel alloc] init];
        NSString *str1=_ImageArray[i];
        NSString *str2=_NameArray[i];
        NSString *str3=_BankArray[i];
        
        model.BankImage=str1;
        model.BankName=str2;
        model.BankNumber=str3;
        
        [_datas addObject:model];
    }
    
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _NameArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankBankModel *model=_datas[indexPath.row];
    BankBankCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.BankImageView.image=[UIImage imageNamed:model.BankImage];
    cell.BankNameLabel.text=model.BankName;
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankBankModel *model=_datas[indexPath.row];
    NSString *name=model.BankName;
    
    NSString *number=model.BankNumber;
    NSLog(@"%@",name);
    NSLog(@"%@",number);
    //实现反向传值
    if (_delegate && [_delegate respondsToSelector:@selector(setBankNameWithString:andBankNumberWithString:)]) {
        [_delegate setBankNameWithString:name andBankNumberWithString:number];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
