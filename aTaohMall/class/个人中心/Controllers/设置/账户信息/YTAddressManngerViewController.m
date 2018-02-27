//
//  YTAddressManngerViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTAddressManngerViewController.h"

#import "YTAddressCell.h"

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

#import "YTAddressViewController.h"

#import "YTChangeViewController.h"

#import "JRToast.h"
@interface YTAddressManngerViewController ()<UITableViewDelegate,UITableViewDataSource,ReshDataDelwgate,ReshDataDelegate1,UIAlertViewDelegate,YTDelwgate,YTGetGoodsAdddressDelegate>
{
    UIView *view;
    NSMutableArray *_datasSource;
}
@end

@implementation YTAddressManngerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initTableView];
    
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

-(void)initTableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-49) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"YTAddressCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NoDataCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
}


-(void)YTAddressReload
{
    
    [_datasSource removeAllObjects];
    //获取数据
    [self getDatas];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [hud dismiss:YES];
    });
    
    [_tableView reloadData];
    
}
//代理刷新方法
-(void)reshData
{
    NSLog(@"=========");
    
    [_datasSource removeAllObjects];
    //获取数据
    [self getDatas];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
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
            
            NSLog(@"xmlStr====收货地址==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            view.hidden=YES;
//            NSLog(@"=====收货地址集合===%@",dic);
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

-(void)loadData
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas];
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
        return 124;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datasSource.count==0) {
        NoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        
        return cell;
        
    }else{
        
        UserModel *model=_datasSource[indexPath.row];
        
        YTAddressCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.YTNameLabel.text=model.name;
        cell.YTPhoneLabel.text=model.phone;
        cell.YTAddressLabel.text=model.address;
        
        
        if ([model.defaultstate isEqualToString:@"1"]) {
            
            cell.YTMoRenImageView.image=[UIImage imageNamed:@"勾"];
            
        }else{
            
            cell.YTMoRenImageView.image=[UIImage imageNamed:@"为勾选"];
        }
        
        
        cell.YTMoRenButton.tag = 100 + indexPath.row;
        cell.YTBianJiButton.tag = 200 +indexPath.row;
        cell.YTDeleteButton.tag = 300 +indexPath.row;
        
        [cell.YTMoRenButton addTarget:self action:@selector(morenBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.YTBianJiButton addTarget:self action:@selector(bianjiBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.YTDeleteButton addTarget:self action:@selector(deleteBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

-(void)morenBtnClick:(UIButton*)button event:(id)event
{
    NSLog(@"morenBtnClick");
    
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tableView];
    NSIndexPath *indexPath= [_tableView indexPathForRowAtPoint:currentTouchPosition];
    if (button.tag-100 == indexPath.row ){
        
        
        
        UserModel *model=_datasSource[indexPath.row];
        
        NSLog(@"===================%@",model.id);
        
        
        NSLog(@"%@--%@",self.sigens,model.id);
        
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            [hud dismiss:YES];
        });
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *url = [NSString stringWithFormat:@"%@updateDefaultReceiptAddress_mob.shtml",URL_Str];
        
        NSDictionary *dic = @{@"sigen":self.sigens,@"aid":model.id};
        
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
}

-(void)bianjiBtnClick:(UIButton*)button event:(id)event
{
    
    NSLog(@"bianjiBtnClick");
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tableView];
    NSIndexPath *indexPath= [_tableView indexPathForRowAtPoint:currentTouchPosition];
    if (button.tag-200 == indexPath.row ){
        
        
        
        UserModel *model=_datasSource[indexPath.row];
        
        NSLog(@"===================%@",model.id);
        
        YTChangeViewController *vc=[[YTChangeViewController alloc] init];
        
//        vc.delegate=self;
        
//        vc.aid=model.id;
        vc.MoRen=model.defaultstate;
        vc.aid=model.id;
        vc.sigens=self.sigens;
        
        vc.delegate=self;
        
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
    }
    
}

-(void)deleteBtnClick:(UIButton*)button event:(id)event
{
    
    NSLog(@"deleteBtnClick");
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确定要删除该地址吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"确认");
        
        NSSet *touches =[event allTouches];
        UITouch *touch =[touches anyObject];
        CGPoint currentTouchPosition = [touch locationInView:_tableView];
        NSIndexPath *indexPath= [_tableView indexPathForRowAtPoint:currentTouchPosition];
        if (button.tag-300 == indexPath.row ){
            
            
            
            UserModel *model=_datasSource[indexPath.row];
            
            NSLog(@"===================%@",model.id);
            
            NSLog(@"%@--%@",self.sigens,model.id);
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            NSString *url = [NSString stringWithFormat:@"%@deleteReceiptAddress_mob.shtml",URL_Str];
            
            NSDictionary *dic = @{@"sigen":self.sigens,@"id":model.id};
            
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
                
                self.back=@"200";
                
                self.deleteString=@"100";
                //重新刷新数据
                [self getDatas];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
                
                [self NoWebSeveice];
                
            }];
        }
        
    }]];
    
    [alert addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"取消");
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
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
            
            
        }else if ([self.deleteString isEqualToString:@"100"]){
            
            //实现反向传值
            if (_delegate && [_delegate respondsToSelector:@selector(setUserNameWithString:andPhoneWithString:andDetailAddressWithString:andType:andIDWithString: andAddressReloadString:)]) {
                [_delegate setUserNameWithString:model.name andPhoneWithString:model.phone andDetailAddressWithString:model.address andType:@"888" andIDWithString:model.id andAddressReloadString:@"0"];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
//    UserModel *model=_datasSource[indexPath.row];
    
//    NSLog(@"=====%@",model.id);
    
}

- (IBAction)backBtnClick:(UIButton *)sender {
    
    
//    if (_delegate && [_delegate respondsToSelector:@selector(AddressReload)]) {
//        
//        [_delegate AddressReload];
//    }
    
    if ([self.back isEqualToString:@"20"]) {
        
        //        CountMessageViewController *vc=[[CountMessageViewController alloc] init];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        
    }else if([self.back isEqualToString:@"100"]){
        
        if (_datasSource.count==0) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(AddressReload)]) {
                
                [_delegate AddressReload];
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if([self.back isEqualToString:@"200"]){
        
        NSLog(@"数据源为空，进到这里来了");
        
        if (_datasSource.count==0) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(DeleteTheLastAddress)]) {
                
                [_delegate DeleteTheLastAddress];
            }
        }
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(AddressReload)]) {
        
            [_delegate AddressReload];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
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

- (IBAction)YTAddAddress:(UIButton *)sender {
    
    if (_datasSource.count>=5) {
        
//        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"最多只能添加5条收货地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alert addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        
//        [self presentViewController:alert animated:YES completion:nil];
        
        [JRToast showWithText:@"最多只能添加5条收货地址" duration:3.0f];
        
    }else{
        
        YTAddressViewController *vc=[[YTAddressViewController alloc] init];
        
        vc.YTString=self.YTString;
        
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
    }
}

@end
