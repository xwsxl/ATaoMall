//
//  MyPayCardViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "MyPayCardViewController.h"

#import "MyPayCardCell.h"
#import "SelectPayCardCell.h"


#import "AddMyPayCardViewController.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "PayCardModel.h"

#import "MyPayCardFooter.h"

#import "WKProgressHUD.h"
@interface MyPayCardViewController ()<UITableViewDataSource,UITableViewDelegate,AddBankCardDelegae>
{
    UITableView *_tableView;
    UITableViewHeaderFooterView *_footerView;
    
    NSMutableArray *_datas;
    
    BOOL m_bTransform;
    
    SelectPayCardCell *cell;
    
    UIView *view;
    
    
//    MyPayCardFooter *footer;
}
@end

@implementation MyPayCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _datas=[NSMutableArray new];
    //创建tableView
    [self initTableView];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    //获取数据
        [self getDatas];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
}

//代理方法
-(void)addCard
{       //获取数据
        [self getDatas];

    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
               
        [hud dismiss:YES];
    });
}
-(void)getDatas
{
    //清空数据源
    [_datas removeAllObjects];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@queryUserBankCard_mob.shtml",URL_Str];
    
    
    NSLog(@"===self.sigen===%@",self.sigen);
    
    NSDictionary *dic = @{@"sigen":self.sigen};
    
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic);
            
            view.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {
                for (NSDictionary *dict2 in dict1[@"bankcardlist"]) {
                    PayCardModel *model=[[PayCardModel alloc] init];
                    
                    NSString *bankcardno=dict2[@"bankcardno"];
                    
                    self.bankcardno=bankcardno;
                    
                    NSString *bankname=dict2[@"bankname"];
                    NSString *bankno=dict2[@"bankno"];
                    NSString *id=dict2[@"id"];
                    NSString *identity=dict2[@"identity"];
                    NSString *realname=dict2[@"realname"];
                    
                    
                    model.bankcardno=bankcardno;
                    model.bankname=bankname;
                    model.bankno=bankno;
                    model.id=id;
                    model.identity=identity;
                    model.realname=realname;
                    
                    [_datas addObject:model];
                    
                    //最多添加五张银行卡
                    if (_datas.count==5) {
                        
                        _footer.hidden=YES;
                    }else{
                        _footer.hidden=NO;
                    }
                }
                [_tableView reloadData];
            }
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}


-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label2.text=@"请检查你的网络";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label2];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)loadData{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas];
    
}
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    //去掉分割线
    _tableView.separatorStyle=NO;
    
    [self.view addSubview:_tableView];
    
    
    _tableView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyPayCardCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"SelectPayCardCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyPayCardFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"footer"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datas.count==0) {
        
        
        return nil;
        
    }else{
        
        PayCardModel *model=_datas[indexPath.row];
        
        NSString *str=model.bankname;
        
        cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.tableview = _tableView;
        cell.ArrM=_datas;
        cell.datas = _datas;
        cell.footer = _footer;
        cell.indexPath=indexPath.row;
        
        
        cell.BankDeleteButton.hidden=YES;
        
        cell.BankNameLabel.text=model.bankname;
        
        NSString *string=@"**** **** ****";
        
        self.bankId=model.id;
        NSLog(@"====1=%@====",self.bankId);
        
        cell.BankNumberLabel.text=[NSString stringWithFormat:@"%@ %@ %@",[model.bankcardno substringToIndex:3],string,[model.bankcardno substringFromIndex:model.bankcardno.length-4]];
        
        
        NSLog(@"======2==%@",cell.BankNumberLabel.text);
        //    lpgrTapView.tag=indexPath.row+1;
        
        //    tapGestureTel2View.tag=indexPath.row+1;
        
        
        if ([str isEqualToString:@"中国建设银行"]) {
            
            cell.BankImageView.image=[UIImage imageNamed:@"建行@2x (2)"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"蓝标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"中国工商银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"工行@2x 11-27-35-189"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"红标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"招商银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"招行@2x"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"红标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"中国银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"中行@2x"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"红标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"平安银行"]){
            
            
            cell.BankImageView.image=[UIImage imageNamed:@"平安@2x 11-27-34-958"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"橙色标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"浦发银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"浦发@2x (2)"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"蓝标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"中国邮政储蓄银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"邮储@2x 11-27-35-274"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"绿标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"农业银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"农行@2x"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"绿标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"中信银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"中信@2x (2)"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"红标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"兴业银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"兴业@2x 11-27-34-931"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"蓝标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"广发银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"广发@2x"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"红标识底色@2x"];
            
        }else if ([str isEqualToString:@"中国民生银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"民生@2x (2)"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"绿标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"交通银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"交行@2x"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"蓝标识底色@2x"];
            
        }else if ([str isEqualToString:@"华夏银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"华夏@2x"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"红标识底色@2x"];
            
            
        }else if ([str isEqualToString:@"中国光大银行"]){
            
            cell.BankImageView.image=[UIImage imageNamed:@"光大@2x"];
            cell.BackgoundImageView.image=[UIImage imageNamed:@"紫色标识底色-拷贝@2x"];
        }
        
        [cell deleteWayWithCell:indexPath.row];
        
        return cell;
        
    }
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        PayCardModel *model=_datas[indexPath.row];
        
        NSLog(@"====model===%@",model.id);
    }
    
}
//添加银行卡事件
-(void)addPayCardBtnClick
{
    AddMyPayCardViewController *vc=[[AddMyPayCardViewController alloc] init];
    
    vc.sigen=self.sigen;
    
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.tabBar.hidden=NO;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    //添加银行卡事件
    [_footer.AddBankCardButton addTarget:self action:@selector(addPayCardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return _footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 130;
}

//- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr
//{
//    NSLog(@"0000000000000000000000000");
//    if (gr.state == UIGestureRecognizerStateBegan)
//    {
//        if (m_bTransform)
//            return;
//        
//        cell.BankDeleteButton.hidden=NO;
//        [cell.BankDeleteButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//        m_bTransform = YES;
////        [self BeginWobble];
//    }
//}
//
//
//
//-(void)click
//{
//    NSLog(@"========");
//    
//    
//    
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        
//        //获取数据
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        
//        NSString *url = [NSString stringWithFormat:@"%@delUserBankcard_mob.shtml",URL_Str];
//        //saveUserExchange_mob.shtml
//        NSDictionary *dic = @{@"sigen":self.sigen,@"id":self.bankId};
//        
//        //        NSDictionary *dic=nil;
//        //        NSDictionary *dic = @{@"classId":@"129"};
//        [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
//            NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
//            
//            
//            
//            
//            if (codeKey && content) {
//                NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
//                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//                
//                //NSLog(@"xmlStr%@",xmlStr);
//                
//                
//                NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
//                
//                
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                
//                NSLog(@"%@",dic);
//                
//                for (NSDictionary *dict in dic) {
//                    
//                    if ([dict[@"status"] isEqualToString:@"10000"]) {
//                        
//                        [self getDatas];
//                    }
//                }
//                
//            }
//            
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"%@",error);
//        }];
//        
//        
//        
//        [hud dismiss:YES];
//    });
//    
//    
//    
//    
//}
//-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr
//{
//    if(m_bTransform==NO)
//        return;
//    cell.BankDeleteButton.hidden=YES;
//    
//    m_bTransform = NO;
////    [self EndWobble];
//}






@end
