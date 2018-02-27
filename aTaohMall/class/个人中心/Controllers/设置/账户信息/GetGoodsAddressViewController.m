//
//  GetGoodsAddressViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "GetGoodsAddressViewController.h"

#import "GoodsAddressCell1.h"
#import "GoodsAddressCell2.h"

#import "GoodsAddressDetailViewController.h"//地址详情

#import "TianJiaGoodsAddressViewController.h"//添加收货地址

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
//获取缓存sigen
#import "UserMessageManager.h"

#import "UserModel.h"

#import "WKProgressHUD.h"

#import "GoodsAddressDetailViewController.h"

#import "CountMessageViewController.h"

#import "NoDataCell.h"
@interface GetGoodsAddressViewController ()<UITableViewDataSource,UITableViewDelegate,ReshDataDelwgate,ReshDataDelegate1,UIAlertViewDelegate>
{
    NSMutableArray *_datasSource;
    
    UIView *view;
    
}

@end

@implementation GetGoodsAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _datasSource=[NSMutableArray new];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    //获取数据
    [self getDatas];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
   
        [hud dismiss:YES];
    });
    
    
}
//代理刷新方法
-(void)reshData
{
    [_datasSource removeAllObjects];
     //获取数据
    [self getDatas];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{

        [hud dismiss:YES];
    });
}

-(void)reshData1
{
    [_datasSource removeAllObjects];
     //获取数据
    [self getDatas];

    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
       
        [hud dismiss:YES];
    });
}
-(void)getDatas
{
    [_datasSource removeAllObjects];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getReceiptAddress_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigens};
    
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
            
            view.hidden=YES;
            
            NSLog(@"=====收货地址集合===%@",dic);
            for (NSDictionary *dict1 in dic) {
                for (NSDictionary *dict2 in dict1[@"addresslist"]) {
                    UserModel *model=[[UserModel alloc] init];
                    NSString *address=dict2[@"address"];
                    NSString *defaultstate=dict2[@"defaultstate"];
                    NSString *id=dict2[@"id"];
                    NSString *name=dict2[@"name"];
                    NSString *phone=dict2[@"phone"];
                    
                    NSLog(@"==address=%@",address);
                    model.address=address;
                    model.defaultstate=defaultstate;
                    model.id=id;
                    model.name=name;
                    model.phone=phone;
                    
                    [_datasSource addObject:model];
                    
                    //把第一个设为默认地址
                    if ([model.defaultstate isEqualToString:@"1"]) {
                        
                        [_datasSource removeObject:model];
                        
                        [_datasSource insertObject:model atIndex:0];
                    }
                }
            }
            
            if (_datasSource.count==0) {
                self.NoDatasLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 30)];
                self.NoDatasLabel.textColor=[UIColor lightGrayColor];
                self.NoDatasLabel.textAlignment=NSTextAlignmentCenter;
                self.NoDatasLabel.font=[UIFont systemFontOfSize:18];
                
                self.NoDatasLabel.text=@"暂无任何收货地址，请您点击添加";
                
                [self.view addSubview:self.NoDatasLabel];
                
                //        self.tableView.hidden=YES;
            }else{
                
                //创建tableView
                [self initTableView];
                
            }
            
            
            [_tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsAddressCell1" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsAddressCell2" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NoDataCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_datasSource.count==0) {
        return 1;
    }else{
       return _datasSource.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datasSource.count==0) {
        return 60;
    }else{
       return 100;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_datasSource.count==0) {
        NoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UserModel *model=_datasSource[indexPath.row];
        
        if ([model.defaultstate isEqualToString:@"1"]) {
            GoodsAddressCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.NameLabel.text=model.name;
            cell.PhoneLabel.text=model.phone;
            
            
            NSString *string = [NSString stringWithFormat:@"[默认地址]%@",model.address];
            
            NSString *stringForColor = @"[默认地址]";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0/255.0 green:197/255.0 blue:100/255.0 alpha:1.0] range:range];
            
            cell.AddressLabel.attributedText=mAttStri;
            
//            cell.AddressLabel.text=[NSString stringWithFormat:@"                    %@",model.address];
            return cell;
        }else{
            
            
            GoodsAddressCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.NameLabel.text=model.name;
            cell.PhoneLabel.text=model.phone;
            cell.AddressLabel.text=model.address;
            return cell;
        }
        
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datasSource.count==0) {
        
        
    }else{
        
        UserModel *model=_datasSource[indexPath.row];
        
        if ([self.back isEqualToString:@"100"]) {
            
            
            //实现反向传值
            if (_delegate && [_delegate respondsToSelector:@selector(setUserNameWithString:andPhoneWithString:andDetailAddressWithString:andType:andIDWithString: andAddressReloadString:)]) {
                [_delegate setUserNameWithString:model.name andPhoneWithString:model.phone andDetailAddressWithString:model.address andType:@"888" andIDWithString:model.id andAddressReloadString:@"0"];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            
            
            GoodsAddressDetailViewController *vc=[[GoodsAddressDetailViewController alloc] init];
            
            vc.delegate=self;
            
            vc.aid=model.id;
            [self.navigationController pushViewController:vc animated:NO];
            self.navigationController.navigationBar.hidden=YES;
            
        }
    }
    
    
}

//添加
- (IBAction)AddBtnClick:(UIButton *)sender {
    
    if (_datasSource.count==5) {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"您最多只能添加5条收货地址!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        TianJiaGoodsAddressViewController *vc=[[TianJiaGoodsAddressViewController alloc] init];
        
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
    }
    
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}

//删除地址

-(void)deleAddress
{
    
    NSLog(@"%@--%@",self.sigens,self.aid);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@deleteReceiptAddress_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigens,@"id":self.aid};
    
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
            
        }
        
        view.hidden=YES;
        
//        [_tableView reloadData];
        //重新刷新数据
        [self getDatas];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self NoWebSeveice];
        
    }];
}


//设为默认地址

-(void)setAddress
{
    
    NSLog(@"%@--%@",self.sigens,self.aid);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@updateDefaultReceiptAddress_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigens,@"aid":self.aid};
    
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
            
        }
        
        
        view.hidden=YES;
        
        //        [_tableView reloadData];
        //重新刷新数据
        [self getDatas];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self NoWebSeveice];
        
    }];
}
//进入编辑模式，按下出现的编辑按钮后


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UserModel *model=_datasSource[indexPath.row];
//    
//    self.aid=model.id;
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        NSLog(@"删除");
//        NSLog(@"%@",self.aid);
//        
//        
//        
//        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//            
//            //获取数据
//            [self deleAddress];
//            
//            [hud dismiss:YES];
//        });
//        
//    }
//}



-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        UserModel *model=_datasSource[indexPath.row];
    
        self.aid=model.id;
    // 添加一个删除按钮
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了删除");
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"是否删除本条记录" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        alertView.backgroundColor=[UIColor lightGrayColor];
        
        alertView.delegate=self;
        [alertView show];
        
        
        
        
    }];
    
    
    
    
    
    // 添加一个更多按钮
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"设为默认地址" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了更多");
        
         //获取数据
            [self setAddress];
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            [hud dismiss:YES];
        });
        
        
    }];
    
    
    return @[deleteRowAction,moreRowAction];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
         //获取数据
        [self deleAddress];
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
                       [hud dismiss:YES];
        });
        
    }else{
        
    }
}
//以下方法可以不是必须要实现，添加如下方法可实现特定效果：

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


//实现Cell可上下移动，调换位置，需要实现UiTableViewDelegate中如下方法：

//先设置Cell可移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//当两个Cell对换位置后
- (void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    if ([self.back isEqualToString:@"20"]) {
        
//        CountMessageViewController *vc=[[CountMessageViewController alloc] init];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }else{
        
        if (_datasSource.count==0) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(AddressReload)]) {
                
                [_delegate AddressReload];
            }
        }else{
            
            
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"address" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            
            if (_delegate && [_delegate respondsToSelector:@selector(AddressReload:)]) {
                
                [_delegate AddressReload:_datasSource.count];
            }
            
            
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



@end
