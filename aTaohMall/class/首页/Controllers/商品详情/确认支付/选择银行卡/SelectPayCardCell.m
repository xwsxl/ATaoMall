//
//  SelectPayCardCell.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "SelectPayCardCell.h"

#import "PayCardModel.h"
#import "WKProgressHUD.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UserMessageManager.h"

@implementation SelectPayCardCell
{
    BOOL m_bTransform;
    
    NSString *_bankId;
    UIView *view;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)deleteWayWithCell:(NSInteger)index
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)];
    [self addGestureRecognizer:lpgr];
    
    UITapGestureRecognizer *tapGestureTel2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoPressGestureRecognizer:)];
    [tapGestureTel2 setNumberOfTapsRequired:1];
    [tapGestureTel2 setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:tapGestureTel2];
    
    
    
    NSLog(@"=======%ld==",(long)index);
    
    NSLog(@"$$$$$$$$");
}

-(void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr// event:(id)event
{
    
    //        NSSet *touches =[event allTouches];
    //        UITouch *touch =[touches anyObject];
    //        CGPoint currentTouchPosition = [touch locationInView:_tableview];
    //        NSIndexPath *indexPath= [_tableview indexPathForRowAtPoint:currentTouchPosition];
    CGPoint p = [gr locationInView:_tableview];
    
    NSIndexPath *indexPath = [_tableview indexPathForRowAtPoint:p];//获取响应的长按的indexpath
    
    
    
    
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        
        //        NSLog(@"====indexPath====%ld=",indexPath.row);
        
        PayCardModel *model=_ArrM[indexPath.row];
        
        _bankId=model.id;
        
        //        NSLog(@"===model.id===%@",model.id);
        
        if (m_bTransform)
            return;
        
        self.BankDeleteButton.hidden=NO;
        [self.BankDeleteButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        m_bTransform = YES;
        
        
    }
    
}

-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr// event:(id)event
{
    
    if(m_bTransform==NO)
        return;
    self.BankDeleteButton.hidden=YES;
    
    m_bTransform = NO;
    
}


-(void)click
{
    
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"您确定要删除此银行卡！" message:nil delegate:self
                                        cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [alert show];
    
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        NSLog(@"=======%@==+++=====",_bankId);
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        NSLog(@"===>>>>%@==%@=",[userDefaultes stringForKey:@"status"],[userDefaultes stringForKey:@"sigen"]);
        
        
        //获取数据
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *url = [NSString stringWithFormat:@"%@delUserBankcard_mob.shtml",URL_Str];
        //saveUserExchange_mob.shtml
        NSDictionary *dic = @{@"sigen":[userDefaultes stringForKey:@"sigen"],@"id":_bankId};
        
        //        NSDictionary *dic=nil;
        //        NSDictionary *dic = @{@"classId":@"129"};
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
                for (NSDictionary *dict in dic) {
                    
                    if ([dict[@"status"] isEqualToString:@"10000"]) {
                        
                        NSLog(@"ooooooooo");
                        
                        [self getDatas];
                        
                        [_tableview reloadData];
                    }
                }
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            [self NoWebSeveice];
            
        }];
        
    }else{
        
        
    }
}


-(void)loadData
{
    
    [self getDatas];
}
-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200)];
    
    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:view];
    
    
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
    //清空数据源
    [_datas removeAllObjects];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
//    NSLog(@"===>>>>%@==%@=",[userDefaultes stringForKey:@"status"],[userDefaultes stringForKey:@"sigen"]);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@queryUserBankCard_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":[userDefaultes stringForKey:@"sigen"]};
    
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
                    
                    //                    self.bankcardno=bankcardno;
                    
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
                        
                        self.footer.hidden=YES;
                        
                    }else{
                        
                        self.footer.hidden=NO;
                    }
                }
                [_tableview reloadData];
            }
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络异常" inView:self duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}



-(void)setArrM:(NSMutableArray *)ArrM
{
    _ArrM=ArrM;
    
    //    NSLog(@"=====_ArrM.count===%ld===",_ArrM.count);
}

-(void)setIndexPath:(NSInteger)indexPath
{
    _indexPath=indexPath;
    
    //    NSLog(@"=====_indexPath===%ld===",_indexPath);
}

@end
