
//
//  GoodsDetailMainView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/4/18.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "GoodsDetailMainView.h"
#import "NewGoodsDetailViewController.h"
#import "WKProgressHUD.h"

#import "UserMessageManager.h"

#import "NewLoginViewController.h"

#import "ATHLoginViewController.h"

#import "YTGoodsDetailViewController.h"

#import "SVProgressHUD.h"

#import "TuWenViewController.h"

#import "JRToast.h"

#import "SMProgressHUD.h"
#import "SMProgressHUDActionSheet.h"


#import "QueDingDingDanViewController.h"//确认订单

#import "BackCartViewController.h"

@implementation GoodsDetailMainView
{
    
    UIView *view;
    
    NSString *_ytback;
    
    NSString *_YYYYYYYY;
    
    UIAlertController *alertCon;
    
    
}
@synthesize goodsDetail,choseView,cartchoseView;
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"yangtao" object:nil];
        
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi6) name:@"tankuangxiaoshi" object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AttribiteAddCart:) name:@"AttribiteAddCart" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AttribiteAddCart1:) name:@"AttribiteAddCart1" object:nil];
        
        
    }
    
    return self;
}


-(void)tongzhi6
{
    
    [self dismiss];
    
}


//判断限购

//同店铺的不能购买
-(void)getDatas1
{
    
    NSNull *null=[[NSNull alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getConfirmOrderInfo_mob.shtml",URL_Str];
    
    NSLog(@"=====self.sigen====%@========",self.sigen);
    NSLog(@"=====self.mid====%@========",self.mid);
    NSLog(@"=====self.gid====%@========",self.gid);
    NSLog(@"=====self.logo====%@========",self.logo);
    NSLog(@"=====self.storename====%@========",self.storename);
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"mid":self.mid,@"gid":self.gid,@"logo":@"",@"storename":self.storename};
    //logo可能为空报错
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr==%@",xmlStr);
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=======商品信息555555555555555555555555555%@",dic);
            //            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                
                
                self.NotBuy=dict1[@"status"];
                
                self.NotBuyMessage=dict1[@"message"];
                
                
                NSString *YTType;
                NSString *YTStatus;
                
                for (NSDictionary *dict2 in dict1[@"list"]) {
                    
                    
                    YTType=dict2[@"good_type"];
                    
                    YTStatus=dict2[@"status"];
                    
                }
                
                if ([self.NotBuy isEqualToString:@"10001"]) {
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    
                    
                }else if([self.NotBuy isEqualToString:@"10002"]){
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                   
                    
                }else if([self.NotBuy isEqualToString:@"10000"]){
                    
                    if (([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"0"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"0"])) {
                        
                        [JRToast showWithText:@"请等待，限购商品暂未开抢" duration:3.0f];
                        
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"7"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"7"])) {
                        
                        [JRToast showWithText:@"该商品已结束抢购！" duration:3.0f];
                        
                       
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"6"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"6"])) {
                        
                        [JRToast showWithText:@"该商品已售完！" duration:3.0f];
                        
                        
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"1"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"1"])) {
                        
                        [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                        
                        
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"5"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"5"])) {
                        
                        [JRToast showWithText:@"该商品已删除！" duration:3.0f];
                        
                       
                        
                        
                    }else{
                        
                        if ([self.stock isEqualToString:@"0"]) {
                            
                            [JRToast showWithText:@"库存为0，无法购买" duration:3.0f];
                            
                            
                            
                        }else if([self.YTStatus isEqualToString:@"1"]){
                            
                            [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                            
                            
                        }else{
                            
                            
                            
                            
                        }
                    }
                }
            }
            
            NSLog(@"++++++self.NotBuy++++++%@",self.NotBuy);
            NSLog(@"++++++self.NotBuyMessage++++++%@",self.NotBuyMessage);
            //            [_tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        //        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}


- (void)AttribiteAddCart1:(NSNotification *)text{
    
    
    
//    [self dismiss];
    
    NSLog(@"====sigen====%@",text.userInfo[@"textOne"]);
    NSLog(@"====gid====%@",text.userInfo[@"textTwo"]);
    NSLog(@"====mid====%@",text.userInfo[@"textThree"]);
    NSLog(@"====num====%@",text.userInfo[@"textFour"]);
    NSLog(@"====type====%@",text.userInfo[@"textFive"]);
    NSLog(@"====exchange====%@",text.userInfo[@"textSix"]);
    NSLog(@"====detailId====%@",text.userInfo[@"textSeven"]);
    NSLog(@"====NewGoods_Type====%@",text.userInfo[@"textEight"]);
    NSLog(@"====NewGoods_Type====%@",text.userInfo[@"textNine"]);
    NSLog(@"====NewGoods_Type====%@",text.userInfo[@"textTen"]);
    NSLog(@"====NewGoods_Type====%@",text.userInfo[@"textTen1"]);
    NSLog(@"====NewGoods_Type====%@",text.userInfo[@"textTen2"]);
    NSLog(@"====NewGoods_Type====%@",text.userInfo[@"textTen3"]);
    
    
    self.Goods_Type_Switch = text.userInfo[@"textSix"];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getConfirmOrderInfo_mob.shtml",URL_Str];
    
    NSLog(@"=====self.sigen====%@========",self.sigen);
    NSLog(@"=====self.mid====%@========",self.mid);
    NSLog(@"=====self.gid====%@========",self.gid);
    NSLog(@"=====self.logo====%@========",self.logo);
    NSLog(@"=====self.storename====%@========",self.storename);
    
    NSDictionary *dic = @{@"sigen":text.userInfo[@"textOne"],@"mid":text.userInfo[@"textNine"],@"gid":text.userInfo[@"textTwo"],@"logo":@"",@"storename":text.userInfo[@"textThree"]};
    //logo可能为空报错
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr==%@",xmlStr);
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=======商品信息555555555555555555555555555%@",dic);
            //            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                
                
                self.NotBuy=dict1[@"status"];
                
                self.NotBuyMessage=dict1[@"message"];
                
                
                NSString *YTType;
                NSString *YTStatus;
                
                for (NSDictionary *dict2 in dict1[@"list"]) {
                    
                    
                    YTType=dict2[@"good_type"];
                    
                    YTStatus=dict2[@"status"];
                    
                }
                
                if ([self.NotBuy isEqualToString:@"10001"]) {
                    
                    [self dismiss];
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    
                    
                }else if([self.NotBuy isEqualToString:@"10002"]){
                    
                    [self dismiss];
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    
                    
                }else if([self.NotBuy isEqualToString:@"10000"]){
                    
                    if (([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"0"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"0"])) {
                        
                        [self dismiss];
                        
                        [JRToast showWithText:@"请等待，限购商品暂未开抢" duration:3.0f];
                        
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"7"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"7"])) {
                        
                        [self dismiss];
                        
                        [JRToast showWithText:@"该商品已结束抢购！" duration:3.0f];
                        
                        
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"6"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"6"])) {
                        
                        [self dismiss];
                        
                        [JRToast showWithText:@"该商品已售完！" duration:3.0f];
                        
                        
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"1"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"1"])) {
                        
                        [self dismiss];
                        
                        [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                        
                        
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"5"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"5"])) {
                        
                        [self dismiss];
                        
                        [JRToast showWithText:@"该商品已删除！" duration:3.0f];
                        
                        
                        
                        
                    }else{
                        
                        if ([self.stock isEqualToString:@"0"]) {
                            
                            [self dismiss];
                            
                            [JRToast showWithText:@"库存为0，无法购买" duration:3.0f];
                            
                            
                            
                        }else if([self.YTStatus isEqualToString:@"1"]){
                            
                            [self dismiss];
                            
                            [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                            
                            
                        }else{
                            
                            
                            QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
                            
                            
                            
                            
                            if ([text.userInfo[@"textSix"] integerValue]==1 || [text.userInfo[@"textSix"] integerValue]==2) {
                                
                                self.SendWayType = @"0";
                                
                            }else if ([text.userInfo[@"textSix"] integerValue]==3 || [text.userInfo[@"textSix"] integerValue]==4){
                                
                                
                                self.SendWayType = @"1";
                                
                            }
                            
                            vc.CutLogin = @"100";
                            
                            vc.gid=text.userInfo[@"textTwo"];
                            
                            vc.sigen=text.userInfo[@"textOne"];
                            
                            vc.storename=text.userInfo[@"textThree"];
                            
                            vc.logo=text.userInfo[@"textFour"];
                            
                            vc.GoodsDetailType=text.userInfo[@"textFive"];
                            
                            vc.Goods_Type_Switch=text.userInfo[@"textSix"];
                            
                            vc.SendWayType=text.userInfo[@"textSeven"];
                            
                            vc.MoneyType=text.userInfo[@"textEight"];
                            
                            vc.midddd=text.userInfo[@"textNine"];
                            
                            vc.yunfei=text.userInfo[@"textTen"];
                            
                            vc.attributenum = text.userInfo[@"textTen1"];
                            vc.exchange = text.userInfo[@"textTen2"];
                            vc.detailId = text.userInfo[@"textTen3"];
                            
                            [self.vc.navigationController pushViewController:vc animated:NO];
                            
                            self.vc.navigationController.navigationBar.hidden=YES;
                            
                        }
                    }
                }
            }
            
            NSLog(@"++++++self.NotBuy++++++%@",self.NotBuy);
            NSLog(@"++++++self.NotBuyMessage++++++%@",self.NotBuyMessage);
            //            [_tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        //        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
    
    
    

    
}


- (void)AttribiteAddCart:(NSNotification *)text{
    
    NSLog(@"====sigen====%@",text.userInfo[@"textOne"]);
    NSLog(@"====gid====%@",text.userInfo[@"textTwo"]);
    NSLog(@"====mid====%@",text.userInfo[@"textThree"]);
    NSLog(@"====num====%@",text.userInfo[@"textFour"]);
    NSLog(@"====type====%@",text.userInfo[@"textFive"]);
    NSLog(@"====exchange====%@",text.userInfo[@"textSix"]);
    NSLog(@"====detailId====%@",text.userInfo[@"textSeven"]);
    NSLog(@"====NewGoods_Type====%@",text.userInfo[@"textEight"]);
    NSLog(@"－－－属性－－接收到通知------");
    NSString *exchange=text.userInfo[@"textSix"];
    if ([exchange isEqualToString:@"2"] || [exchange isEqualToString:@"1"]) {
        
        exchange = @"0";
        
    }else{
        exchange=@"1";
    }

    if ([[NSString stringWithFormat:@"%@",text.userInfo[@"textFour"]] integerValue]<0) {
        [TrainToast showWithText:@"添加数目不正确" duration:2.0];
        return;
    }
    
    
    [HTTPRequestManager POST:@"joinShopping_mob.shtml" NSDictWithString:@{@"sigen":text.userInfo[@"textOne"],@"id":text.userInfo[@"textTwo"],@"mid":text.userInfo[@"textThree"],@"pay_number_hidden":text.userInfo[@"textFour"],@"good_type":text.userInfo[@"textFive"],@"detailId":text.userInfo[@"textSeven"],@"exchange_type":exchange} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"====%@===",responseObj);
        
        if (responseObj) {
            
            for (NSDictionary *dict in responseObj) {
                
                //                    NSLog(@"======%@==",dict[@"message"]);
                //                    NSLog(@"======%@==",dict[@"status"]);
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    //                    [JRToast showWithText:dict[@"message"] duration:1.0f];
                    
                    [[SMProgressHUD shareInstancetype] showTip:@"加入购物车成功"];
                    
                    
                    //                    [self dismiss];
                    
                    [self Gosure];
                    
                    
                }else{
                    
                    
                    [JRToast showWithText:dict[@"message"] duration:1.0f];
                    
                    [self dismiss];
                    
                }
                
                
            }
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];
    
    
}


//-(void)initBottomView
//{
//    bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-64-47, self.frame.size.width, 47)];
//    [self addSubview:bottomView];
//    [bottomView.bt_service addTarget:self action:@selector(seleteService) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView.bt_shop addTarget:self action:@selector(seleteShop) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView.bt_collection addTarget:self action:@selector(seleteCollection:) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView.bt_addBasket addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView.bt_buyNow addTarget:self action:@selector(seleteBuy) forControlEvents:UIControlEventTouchUpInside];
//}



- (void)tongzhi:(NSNotification *)text{
    
    
    NSDictionary *dict=text.userInfo;
    
    NSString *user=dict[@"userid"];
    
    NSLog(@"PPPPPPPPPPPPPPPPPPPPPP=====%@",user);
    
    NSLog(@"=++++++++++++^^^^^^^^^&&&&&&&&");
    
    self.back=@"100";
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"+++%@++++%@++++++%@+++++%@++",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"style"],[userDefaultes stringForKey:@"mianliao"]);
    
    self.userId=user;
    
    
    if ([userDefaultes stringForKey:@"color"].length==0 && [userDefaultes stringForKey:@"size"].length==0 && [userDefaultes stringForKey:@"style"].length==0 && [userDefaultes stringForKey:@"mianliao"].length==0) {//1
        
        
    }else if([userDefaultes stringForKey:@"color"].length>0 && [userDefaultes stringForKey:@"size"].length==0 && [userDefaultes stringForKey:@"style"].length==0 && [userDefaultes stringForKey:@"mianliao"].length==0) {
        
        
        self.ShuXingString=[NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"color"]];
        
        NSLog(@"==2=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length==0 && [userDefaultes stringForKey:@"size"].length>0 && [userDefaultes stringForKey:@"style"].length==0 && [userDefaultes stringForKey:@"mianliao"].length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"size"]];
        
        NSLog(@"==3=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length==0 && [userDefaultes stringForKey:@"size"].length==0 && [userDefaultes stringForKey:@"style"].length>0 && [userDefaultes stringForKey:@"mianliao"].length==0){
        
        
        self.ShuXingString=[NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"style"]];
        
        NSLog(@"==4=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
        
    }else if ([userDefaultes stringForKey:@"color"].length==0 && [userDefaultes stringForKey:@"size"].length==0 && [userDefaultes stringForKey:@"style"].length==0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"mianliao"]];
        
        NSLog(@"==5=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length>0 && [userDefaultes stringForKey:@"size"].length>0 && [userDefaultes stringForKey:@"style"].length==0 && [userDefaultes stringForKey:@"mianliao"].length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"size"]];
        
        NSLog(@"==6=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length==0 && [userDefaultes stringForKey:@"size"].length>0 && [userDefaultes stringForKey:@"style"].length>0 && [userDefaultes stringForKey:@"mianliao"].length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"style"]];
        
        NSLog(@"==7=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length==0 && [userDefaultes stringForKey:@"size"].length==0 && [userDefaultes stringForKey:@"style"].length>0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",[userDefaultes stringForKey:@"style"],[userDefaultes stringForKey:@"mianliao"]];
        
        NSLog(@"==8=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length>0 && [userDefaultes stringForKey:@"size"].length==0 && [userDefaultes stringForKey:@"style"].length>0 && [userDefaultes stringForKey:@"mianliao"].length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"style"]];
        
        NSLog(@"==9=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length>0 && [userDefaultes stringForKey:@"size"].length==0 && [userDefaultes stringForKey:@"style"].length==0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"mianliao"]];
        
        NSLog(@"==10=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length==0 && [userDefaultes stringForKey:@"size"].length>0 && [userDefaultes stringForKey:@"style"].length==0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"mianliao"]];
        
        NSLog(@"==11=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length>0 && [userDefaultes stringForKey:@"size"].length>0 && [userDefaultes stringForKey:@"style"].length>0 && [userDefaultes stringForKey:@"mianliao"].length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"style"]];
        
        NSLog(@"==12=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length==0 && [userDefaultes stringForKey:@"size"].length>0 && [userDefaultes stringForKey:@"style"].length>0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@",[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"style"],[userDefaultes stringForKey:@"mianliao"]];
        
        NSLog(@"==13=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length>0 && [userDefaultes stringForKey:@"size"].length==0 && [userDefaultes stringForKey:@"style"].length>0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"style"],[userDefaultes stringForKey:@"mianliao"]];
        
        NSLog(@"==14=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length>0 && [userDefaultes stringForKey:@"size"].length>0 && [userDefaultes stringForKey:@"style"].length==0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"mianliao"]];
        
        NSLog(@"==15=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }else if ([userDefaultes stringForKey:@"color"].length>0 && [userDefaultes stringForKey:@"size"].length>0 && [userDefaultes stringForKey:@"style"].length>0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@_%@",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"style"],[userDefaultes stringForKey:@"mianliao"]];
        
        NSLog(@"==16=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }
    
}
- (UIViewController*)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


-(void)initDetailViewImgArr:(NSArray *)imgarr andWebArr:(NSArray *)webarr;
{

    goodsDetail = [[GoodsDetailView alloc] initWithFrame:CGRectMake(0, -64, self.frame.size.width, 64) andImageArr:imgarr];
   
    [self addSubview:goodsDetail];
    //宝贝详情内容
//    [goodsDetail initdata:[NSDictionary dictionary]];
    
    [goodsDetail.bt_addSize addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [goodsDetail.bt_judge addTarget:self action:@selector(goodsJudge) forControlEvents:UIControlEventTouchUpInside];
    [goodsDetail.bt_shop addTarget:self action:@selector(seleteShop) forControlEvents:UIControlEventTouchUpInside];
    [goodsDetail.bt_share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    //图文详情webview的网址
//    [goodsDetail initWebScro:webarr];
}


-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6
{
    
    
    NSLog(@"属性弹框登录成功！");
    
}



/**
 *  初始化弹出视图
 */
-(void)initChoseViewSizeArr:(NSArray *)sizeArr andColorArr:(NSArray *)colorArr andArr3:(NSArray *)Arr3 andArr4:(NSArray *)Arr4 andArr5:(NSArray *)Arr5 andStockDic:(NSDictionary *)stockDic andGoodsImageView:(NSString *)imgStr andMoney:(NSString *)money andJIFen:(NSString *)jifen andKuCun:(NSString *)kucun andGid:(NSString *)gid andcount:(NSString *)count andGoods_type:(NSString *)goods_type andGoods_status:(NSString *)status andback:(NSString *)Attribute_back andYTBack:(NSString *)ytback andMid:(NSString *)mid andYYYY:(NSString *)yyyyyy andSmallIds:(NSString *)smallIds andStorename:(NSString *)storename andLogo:(NSString *)logo andSendWayType:(NSString *)sendWayType andMoneyType:(NSString *)MoneyType andSid:(NSString *)sid andTf:(NSString *)tf andCut:(NSString *)cut andJinDu:(NSString *)jindu andWeiDu:(NSString *)weidu andAddressString:(NSString *)mapaddress andNewHomeString:(NSString *)NewHomeString
{
    
    self.YTSting = cut;
    
    self.jindu = jindu;
    self.weidu = weidu;
    self.MapStartAddress = mapaddress;
    
    self.tf = tf;
    self.sid = sid;
    self.gid = gid;
    self.mid = mid;
    self.NewGoods_Type = goods_type;
    self.count = count;
    self.Attribute_back = Attribute_back;
    _ytback=ytback;
    self.storename = storename;
    self.logo = logo;
    self.SendWayType = sendWayType;
    self.MoneyType = MoneyType;
    
    self.NewHomeString = NewHomeString;
    
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:choseView];
//    [self show];
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    if ([yyyyyy isEqualToString:@"1"]) {
        
        [choseView.bt_sure addTarget:self action:@selector(addCart) forControlEvents:UIControlEventTouchUpInside];
        
    }else if([yyyyyy isEqualToString:@"666"]){
        
        [choseView.bt_sure addTarget:self action:@selector(changeAttribute) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        
        [choseView.bt_sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    }
//    [choseView.bt_sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [choseView.bt_cart addTarget:self action:@selector(addCart) forControlEvents:UIControlEventTouchUpInside];
    [choseView.bt_nowbuy addTarget:self action:@selector(NowbuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //控制属性框的高度
    choseView.Height = @"1000";
    
    [choseView initTypeView:sizeArr :colorArr :Arr3:Arr4:Arr5:stockDic andGoodsImageView:imgStr andMoney:money andJiFen:jifen andKuCun:kucun andCount:count andGoods_type:goods_type andStatus:status andGid:gid andYTBack:ytback andMid:mid andYYY:yyyyyy andSmallIds:smallIds andStorename:self.storename andLogo:self.logo andSendWayType:self.SendWayType andMoneyType:self.MoneyType andCut:cut];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
    
    
    
    
    
    
}


//加入购物车
-(void)addCart
{
    
    NSLog(@"加入购物车");
    
    [self Cartsure];
    
    
}

//立即购买
-(void)NowbuyBtnClick
{
    
    NSLog(@"立即购买");
    
    //发送通知，创建菊花，立即购买按钮不可点
    NSNotification *notification = [[NSNotification alloc] initWithName:@"ChoseViewReloadData" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    [self NowSure];
    
    
}


-(void)initCartChoseViewSizeArr:(NSArray *)sizeArr andColorArr:(NSArray *)colorArr andArr3:(NSArray *)Arr3 andArr4:(NSArray *)Arr4 andArr5:(NSArray *)Arr5 andStockDic:(NSDictionary *)stockDic andGoodsImageView:(NSString *)imgStr andMoney:(NSString *)money andJIFen:(NSString *)jifen andKuCun:(NSString *)kucun andGid:(NSString *)gid andcount:(NSString *)count andGoods_type:(NSString *)goods_type andGoods_status:(NSString *)status andback:(NSString *)Attribute_back andYTBack:(NSString *)ytback
{
    
    NSLog(@"===Arr3.count====%ld",Arr3.count);
    self.gid = gid;
    self.count = count;
    self.Attribute_back = Attribute_back;
    _ytback=ytback;
    
    //选择尺码颜色的视图
    cartchoseView = [[CartChoseView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:cartchoseView];
    //    [self show];
    [cartchoseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [cartchoseView.bt_sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [cartchoseView initTypeView:sizeArr :colorArr :Arr3:Arr4:Arr5:stockDic andGoodsImageView:imgStr andMoney:money andJiFen:jifen andKuCun:kucun andCount:count andGoods_type:goods_type andStatus:status andGid:gid andYTBack:ytback angCut:@""];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [cartchoseView.alphaiView addGestureRecognizer:tap];
    
}
#pragma mark-bottom action
-(void)showAlert:(NSString *)message
{


    YLog(@"%@",message);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];



}
-(void)seleteService
{
    [self showAlert:@"点击客服"];
}
-(void)seleteShop
{
    [self showAlert:@"进入店铺"];
}
-(void)seleteCollection:(UIButton *)btn
{
    if (btn.selected) {
        btn.selected = NO;
        [self showAlert:@"取消收藏"];
    }else
    {
        btn.selected = YES;
        [self showAlert:@"已收藏"];
    }
}
-(void)seleteBuy
{
    [self showAlert:@"立即购买"];
}
#pragma mark-goosdetail action
-(void)share
{
    [self showAlert:@"分享"];
}
-(void)goodsJudge
{
    [self showAlert:@"宝贝评价"];
}
#pragma mark-action
/**
 *  点击按钮弹出
 */
-(void)show
{
    center = self.center;
    center.y -= 64;
    
//   [self.vc.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        
        goodsDetail.center = center;
        goodsDetail.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        
        choseView.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    } completion: nil];
    
    
}

-(void)Cartshow
{
    
    center = self.center;
    center.y -= 64;
    
    //   [self.vc.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        
        goodsDetail.center = center;
        goodsDetail.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        
        cartchoseView.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    } completion: nil];
    
    
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    
//    NSLog(@"====choseView.countView.tf_count.text=====%@",choseView.countView.tf_count.text);
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
    if ([userDefaultes stringForKey:@"again"].length > 0) {
        
        [UserMessageManager ShuXingString:[userDefaultes stringForKey:@"again"]];
    }
    
    
          
    [UserMessageManager RemberAttributeNumber:choseView.countView.tf_count.text];
    
    [UserMessageManager RemoveHeight];
    
    center.y += 64;
//  [self.vc.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        goodsDetail.center = center;
        goodsDetail.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//        goodsDetail.bt_addSize.headLabel.text = choseView.lb_detail.text;
    } completion: nil];
    
    [self removeFromSuperview];
    
    
    //通知商品详情回显功能
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"dismiss" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    //通知购物车显示tabbar
    
    if ([self.YTSting isEqualToString:@"100"]) {
        
        
        
        
        
        //创建通知
        NSNotification *notification1 =[NSNotification notificationWithName:@"CartTabbarShow" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification1];
        
    }
    
    
    NSLog(@"=====choseView.StockString====%@",choseView.StockString);
    
    //发送通知，商品详情显示加入购物车，不可点击
    
    
    
    
    
//    if ([choseView.StockString isEqualToString:@"0"]) {
    
    
    if (choseView.StockString.length==0) {
        
        
    }else{
        
        NSDictionary *dict1 =[[NSDictionary alloc] initWithObjectsAndKeys:choseView.StockString,@"textOne", nil];
        
        NSNotification *notification3 = [[NSNotification alloc] initWithName:@"ShuXingNoKuCun" object:nil userInfo:dict1];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification3];
        
    }
    
        
        
//    }
    
    //属性弹框出现时，修改属性按钮可以点击
    NSNotification *buttonCanClick = [[NSNotification alloc] initWithName:@"ButtonCanClick" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:buttonCanClick];
    
    
    //发送通知，商品详情左右滑动手势取消
    
    NSNotification *notification4 = [[NSNotification alloc] initWithName:@"notification4" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification4];
    
    
    //创建通知，商品属性只有一个时。默认选中
    
    NSNotification *notification5 = [[NSNotification alloc] initWithName:@"moren" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification5];
    
    
}


//获取属性数据

-(void)NoShowView
{
    
    [self dismiss];
}



-(void)getDatas
{
    
    
    NSLog(@")))))))))))))====(((((((((===%@",self.gid);
    if (![self.back isEqualToString:@"100"]) {
        
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        
        
        self.userId=[userDefaultes stringForKey:@"userid"];
    }
    
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getGoodAttributeDetailListBySmallIds_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    
    NSDictionary *dic = @{@"smallIds":self.ShuXingString,@"userId":self.userId,@"gid":self.gid};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            NSLog(@"===属性====%@",dic2);
            
            view.hidden=YES;
            
            if ([dic2[@"status"] isEqualToString:@"10000"]) {
                
                
                for (NSDictionary *dict in dic2[@"list"]) {
                    
                    
                    self.user_amount=[NSString stringWithFormat:@"%@",dict[@"user_amount"]];
                    
                    //[NSString stringWithFormat:@"%@",dict[@"user_amount"]];
                    NSLog(@"=====++++++=======%@==",self.user_amount);
                    
                    
                    
                }
                
                
            }else if ([dic2[@"status"] isEqualToString:@"10010"]){
                
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:dic2[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
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

-(void)loadData{
    
    
    [self getDatas];
    
}


//直接跳确认订单
-(void)GoToQueRenDingDan
{
    
    
    NSLog(@"****choseView.user_amount***===%@",choseView.user_amount);
    
    NSLog(@"*****self.user_amount**===%@",self.user_amount);
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    
    if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
        
        //            NewLoginViewController *vc=[[NewLoginViewController alloc] init];
        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
        vc.delegate=self;
        
        vc.backString=@"300";
        
        vc.OOOOOOOOO=@"222";
        
        
        self.detailId = choseView.detailId;
        self.good_type = choseView.Goods_type;
        self.yunfei = choseView.yunfei;
        self.exchange = choseView.exchange;
        self.num = choseView.countView.tf_count.text;
        
        
        if ([self.exchange integerValue]==1 || [self.exchange integerValue]==2) {
            
            self.SendWayType = @"0";
            
        }else if ([self.exchange integerValue]==3 || [self.exchange integerValue]==4){
            
            
            self.SendWayType = @"1";
            
        }
        
        
        NSLog(@"666666666=self.yunfei=%@",self.yunfei);
        NSLog(@"666666666=self.gid=%@",self.gid);
        NSLog(@"666666666=self.sigen=%@",self.sigen);
        NSLog(@"666666666=self.storename=%@",self.storename);
        NSLog(@"666666666=self.logo=%@",self.logo);
        NSLog(@"666666666=self.SendWayType=%@",self.SendWayType);
        NSLog(@"666666666=self.good_type=%@",self.good_type);
        NSLog(@"666666666=self.MoneyType=%@",self.MoneyType);
        NSLog(@"666666666=self.mid=%@",self.mid);
        NSLog(@"666666666=self.num=%@",self.num);
        NSLog(@"666666666=self.exchange=%@",self.exchange);
        NSLog(@"666666666=self.detailId=%@",self.detailId);
        
        vc.gid=self.gid;
        
        vc.sigen=self.sigen;
        
        vc.storename=self.storename;
        
        vc.logo=self.logo;
        
        vc.GoodsDetailType=self.SendWayType;
        
        vc.Goods_Type_Switch=self.good_type;
        
        vc.SendWayType=self.SendWayType;
        
        vc.MoneyType=self.MoneyType;
        
        vc.midddd=self.mid;
        
        vc.yunfei=self.yunfei;
        
        vc.attributenum = self.num;
        vc.exchange = self.exchange;
        vc.detailId = self.detailId;
        
        
        [self.vc.navigationController pushViewController:vc animated:NO];
        
        self.vc.navigationController.navigationBar.hidden=YES;
        
        
    }else{
        
        
        if ([choseView.StockString isEqualToString:@"0"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"库存不足" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            
            [alert show];
            
        }else{
            
            //属性框掉下
//            [self dismiss];
            
//            cartchoseView.bt_sure.enabled=NO;
            
        if (choseView.user_amount.length==0) {
            //
            self.yang_str=self.user_amount;
            //
        }else{
            
            self.yang_str=choseView.user_amount;
        }
        
        //    NSLog(@"=================)))))))))==%@",self.yang_str);
        
        NSLog(@"=================)))))))))==%@",self.yang_str);
        
        
        if(choseView.exchange.length !=0 && choseView.detailId.length !=0){
            //获取数据
            
            
            
            ///////////////////////////////////////////////
            
            
//            NSLog(@"qqqqqqqqq=%@==yunfei=%@=====ytback=%@==",choseView.lb_detail.text,choseView.yunfei,_ytback);
//            NSLog(@"===%d",choseView.sizeView.seletIndex);
//            NSLog(@"====%d",choseView.colorView.seletIndex);
//            NSLog(@"====%d",choseView.arr3View.seletIndex);
//            NSLog(@"====%d",choseView.arr4View.seletIndex);
//            NSLog(@"====%@",choseView.exchange);
//            NSLog(@"====%@",choseView.detailId);
            
            
            
            //掉下属性弹框
            
            [self dismiss];
            
            
            QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
            
            //    NewAddAddressViewController *vc=[[NewAddAddressViewController alloc] init];
            
            
//            NSLog(@"===%d",choseView.sizeView.seletIndex);
//            NSLog(@"====%d",choseView.colorView.seletIndex);
//            NSLog(@"====%d",choseView.arr3View.seletIndex);
//            NSLog(@"====%d",choseView.arr4View.seletIndex);
//            NSLog(@"====%@",choseView.exchange);
//            NSLog(@"====%@",choseView.detailId);
            
            
            self.detailId = choseView.detailId;
            self.good_type = choseView.Goods_type;
            self.yunfei = choseView.yunfei;
            self.exchange = choseView.exchange;
            self.num = choseView.countView.tf_count.text;
            
            
            if ([self.exchange integerValue]==1 || [self.exchange integerValue]==2) {
                
                self.SendWayType = @"0";
                
            }else if ([self.exchange integerValue]==3 || [self.exchange integerValue]==4){
                
                
                self.SendWayType = @"1";
                
            }
            
            
            NSLog(@"yyyyyyyyy=self.yunfei=%@",self.yunfei);
            NSLog(@"yyyyyyyyy=self.gid=%@",self.gid);
            NSLog(@"yyyyyyyyy=self.sigen=%@",self.sigen);
            NSLog(@"yyyyyyyyy=self.storename=%@",self.storename);
            NSLog(@"yyyyyyyyy=self.logo=%@",self.logo);
            NSLog(@"yyyyyyyyy=self.SendWayType=%@",self.SendWayType);
            NSLog(@"yyyyyyyyy=self.good_type=%@",self.good_type);
            NSLog(@"yyyyyyyyy=self.MoneyType=%@",self.MoneyType);
            NSLog(@"yyyyyyyyy=self.mid=%@",self.mid);
            NSLog(@"yyyyyyyyy=self.num=%@",self.num);
            NSLog(@"yyyyyyyyy=self.exchange=%@",self.exchange);
            NSLog(@"yyyyyyyyy=self.detailId=%@",self.detailId);
            
            vc.gid=self.gid;
            
            vc.sigen=self.sigen;
            
            vc.storename=self.storename;
            
            vc.logo=self.logo;
            
            vc.GoodsDetailType=self.SendWayType;
            
            vc.Goods_Type_Switch=self.good_type;
            
            vc.SendWayType=self.SendWayType;
            
            vc.MoneyType=self.MoneyType;
            
            vc.midddd=self.mid;
            
            vc.yunfei=self.yunfei;
            
            vc.attributenum = self.num;
            vc.exchange = self.exchange;
            vc.detailId = self.detailId;
            
            
            //发送通知，商品详情显示属性值
            
            NSNotification *notification =[NSNotification notificationWithName:@"GoToGoPayChangeAttribute" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [UserMessageManager HuanCunShangPinGuiGe:choseView.lb_detail.text];
            
            [UserMessageManager TuWen:choseView.lb_detail.text];
            
            [UserMessageManager YTText:choseView.lb_detail.text];
            
            
            [self.vc.navigationController pushViewController:vc animated:NO];
                    
            self.vc.navigationController.navigationBar.hidden=YES;

        }
    }
        
    }
        
}
-(void)Gosure{

    NSLog(@"****choseView.user_amount***===%@",choseView.user_amount);
    
    NSLog(@"*****self.user_amount**===%@",self.user_amount);
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    
    if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
        
        //            NewLoginViewController *vc=[[NewLoginViewController alloc] init];
        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
        vc.delegate=self;
        
        vc.backString=@"300";
        
        
        [self.vc.navigationController pushViewController:vc animated:NO];
        
        self.vc.navigationController.navigationBar.hidden=YES;
        
    }else{
        
        if (choseView.user_amount.length==0) {
            //
            self.yang_str=self.user_amount;
            //
        }else{
            
            self.yang_str=choseView.user_amount;
        }
        
        //    NSLog(@"=================)))))))))==%@",self.yang_str);
        
        NSLog(@"=================)))))))))==%@",self.yang_str);
        
        
        if(choseView.exchange.length !=0 && choseView.detailId.length !=0){
            //获取数据
            
            
            
            ///////////////////////////////////////////////
            
            
            NSLog(@"qqqqqqqqq=%@==yunfei=%@=====ytback=%@==",choseView.lb_detail.text,choseView.yunfei,_ytback);
            NSLog(@"===%d",choseView.sizeView.seletIndex);
            NSLog(@"====%d",choseView.colorView.seletIndex);
            NSLog(@"====%d",choseView.arr3View.seletIndex);
            NSLog(@"====%d",choseView.arr4View.seletIndex);
            NSLog(@"====%@",choseView.exchange);
            NSLog(@"====%@",choseView.detailId);
            YTGoodsDetailViewController *newGoodsVC = [[YTGoodsDetailViewController alloc]init];
            newGoodsVC.JuHuaShow = @"100";
            newGoodsVC.gid = self.gid;
            newGoodsVC.caonima=@"100";
            newGoodsVC.Panduan = @"2";//判断是否点击确定；
            newGoodsVC.YXZattribute = choseView.lb_detail.text;
            newGoodsVC.exchange = choseView.exchange;
            newGoodsVC.detailId = choseView.detailId;
            newGoodsVC.amount = choseView.amount;
            newGoodsVC.good_type=choseView.Goods_type;
            newGoodsVC.status=choseView.Goods_status;
            newGoodsVC.yunfei=choseView.yunfei;
            newGoodsVC.pay_money = choseView.pay_money;
            newGoodsVC.pay_integral = choseView.pay_integral;
            newGoodsVC.Attribute_back = self.Attribute_back;
            newGoodsVC.ytBack=@"100";
            newGoodsVC.NewHomeString = self.NewHomeString;
//            newGoodsVC.CartString = self.CartString;
            
            TuWenViewController *tuwenVC=[[TuWenViewController alloc] init];
            
            tuwenVC.gid = self.gid;
            tuwenVC.caonima=@"100";
            tuwenVC.Panduan = @"2";//判断是否点击确定；
            tuwenVC.YXZattribute = choseView.lb_detail.text;
            tuwenVC.exchange = choseView.exchange;
            tuwenVC.detailId = choseView.detailId;
            tuwenVC.amount = choseView.amount;
            tuwenVC.good_type=choseView.Goods_type;
            tuwenVC.status=choseView.Goods_status;
            tuwenVC.yunfei=choseView.yunfei;
            tuwenVC.pay_money = choseView.pay_money;
            tuwenVC.pay_integral = choseView.pay_integral;
            tuwenVC.Attribute_back = self.Attribute_back;
            tuwenVC.yyBack=@"100";
            tuwenVC.ID=self.gid;
            tuwenVC.YTStock=[NSString stringWithFormat:@"%d",choseView.stock];
            tuwenVC.NewHomeString=self.NewHomeString;
            
            
            [UserMessageManager YTText:choseView.lb_detail.text];
            
            choseView.num = choseView.countView.tf_count.text;
            
            
            //创建一个消息对象传值给图文详情
            NSNotification * notice =[NSNotification notificationWithName:@"TuWenPrice" object:nil userInfo:@{@"tuwenprice":choseView.lb_price.text,@"type":@"100"}];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            //缓存数量
            [UserMessageManager GoodsNumber:choseView.num];
            
            NSLog(@"wwwwwwwwww=%d,=%@,=%@",choseView.stock,choseView.count,choseView.num);
            NSLog(@"wwwwwwwwww=%@,=%@",choseView.pay_integral,choseView.pay_money);
            if ([choseView.num integerValue]>choseView.stock || [choseView.num integerValue]+[self.yang_str integerValue]>[choseView.count integerValue]) {
                
                NSString *message;
                if ([choseView.count integerValue] != 0 || [choseView.num integerValue]>choseView.stock) {
                    choseView.countView.tf_count.text = @"1";
                    if ([choseView.num integerValue]>choseView.stock) {
                        message = [NSString stringWithFormat:@"该组商品库存为%d",choseView.stock];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                    }else if([choseView.num integerValue]+[self.yang_str integerValue]>[choseView.count integerValue]&&[choseView.count integerValue] != 0){
                        
                        
//                        message = [NSString stringWithFormat:@"商品限购%@件,您已购买%@件!",choseView.count,choseView.count];
                        
                        message = [NSString stringWithFormat:@"该商品限购%@件",choseView.count];
                        
                        [JRToast showWithText:message duration:3.0f];
                        
                        
                        
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                        [alert show];
                        
                    }else{
                        newGoodsVC.num = choseView.num;
                        tuwenVC.num=choseView.num;
                        
                        NSLog(@"=====choseView.num===%@",choseView.num);
                        [self dismiss];
                        
                        [[SMProgressHUD shareInstancetype] showTip:@"加入购物车成功"];
                        
                        if ([_ytback isEqualToString:@"100"]) {
                            
                            self.vc.navigationController.navigationBar.hidden=YES;
                            [self.vc.navigationController pushViewController:newGoodsVC animated:NO];
                            
                        }else if ([_ytback isEqualToString:@"200"]){
                            
                            self.vc.navigationController.navigationBar.hidden=YES;
                            [self.vc.navigationController pushViewController:tuwenVC animated:NO];
                        }
                    }
                    
                }else{
                    
                    newGoodsVC.num = choseView.num;
                    tuwenVC.num=choseView.num;
                    
                    NSLog(@"=====choseView.num===%@",choseView.num);
                    [self dismiss];
                    
                    [[SMProgressHUD shareInstancetype] showTip:@"加入购物车成功"];
                    
                    if ([_ytback isEqualToString:@"100"]) {
                        
                        self.vc.navigationController.navigationBar.hidden=YES;
                        [self.vc.navigationController pushViewController:newGoodsVC animated:NO];
                        
                    }else if ([_ytback isEqualToString:@"200"]){
                        
                        self.vc.navigationController.navigationBar.hidden=YES;
                        [self.vc.navigationController pushViewController:tuwenVC animated:NO];
                    }
                }
                
            }
            else{
                
                newGoodsVC.num = choseView.num;
                tuwenVC.num=choseView.num;
                NSLog(@"=====choseView.num===%@",choseView.num);
                [self dismiss];
                
                [[SMProgressHUD shareInstancetype] showTip:@"加入购物车成功"];
                
                
                if ([_ytback isEqualToString:@"100"]) {
                    
                    self.vc.navigationController.navigationBar.hidden=YES;
                    [self.vc.navigationController pushViewController:newGoodsVC animated:NO];
                    
                }else if ([_ytback isEqualToString:@"200"]){
                    
                    self.vc.navigationController.navigationBar.hidden=YES;
                    [self.vc.navigationController pushViewController:tuwenVC animated:NO];
                }
                
            }
            
        }else{
            WKProgressHUD *hud = [WKProgressHUD showInView:self.choseView  withText:nil animated:YES];
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [hud dismiss:YES];
            });
            
        }
        
        
    }
    
}
-(void)panduanNum{
    
}

//立即购买
-(void)NowSure
{
    
    NSLog(@"=$$$$$==%@====%@=====%@=====%@==",choseView.string,choseView.string1,choseView.string5,choseView.string6);
    
    NSLog(@"======%ld===",choseView.arr5.count);
    
    if (choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0) {//1
        
        
        
    }else if (choseView.sizearr.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0 && choseView.arr4.count>0) {//颜色2
        
        if (choseView.string.length ==0&&choseView.string5.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length >0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string.length >0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string.length ==0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
            
        }else if (choseView.string.length ==0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string.length ==0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string.length >0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            
            //            }
            
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if (choseView.colorarr.count==0 && choseView.sizearr.count>0 && choseView.arr3.count>0 && choseView.arr4.count>0){//尺寸3
        
        if (choseView.string1.length ==0&&choseView.string5.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            [self GoodsDownForStore];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if (choseView.arr3.count==0 && choseView.sizearr.count>0 && choseView.arr4.count>0 && choseView.colorarr.count>0){//风格4
        
        if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string1.length >0&&choseView.string.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
        }else if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
            
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
            
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            
            //            }
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if (choseView.arr4.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0 && choseView.sizearr.count>0){//面料5
        
        if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string5.length>0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string1.length >0&&choseView.string.length>0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string5.length>0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count>0){//6
        
        if (choseView.string6.length==0) {
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr4.count==0 && choseView.arr3.count>0){//7
        
        if (choseView.string5.length==0) {
            
            //            [self showAlert:@"请选择 风格"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else{
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.colorarr.count>0){//8
        
        if (choseView.string.length==0) {
            
            //            [self showAlert:@"请选择 尺码"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
            
        }else{
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //            }
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
        }
        
    }else if(choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0){//9
        
        if (choseView.string1.length==0) {
            
            //            [self showAlert:@"请选择 颜色"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
        }
    }else if(choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0 && choseView.colorarr.count>0){//10
        //        choseView.sizeView.seletIndex>0 && choseView.colorView.seletIndex==0
        if (choseView.string1.length==0 && choseView.string.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length>0 && choseView.string.length==0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
            
        }else if (choseView.string1.length==0 && choseView.string.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
            
        }else{
            
           
            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
        }
    }else if(choseView.colorarr.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0 && choseView.arr3.count>0){//11
        
        if (choseView.string1.length==0 && choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.sizearr.count>0 && choseView.arr4.count>0){//12
        
        if (choseView.string1.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if(choseView.sizearr.count==0 && choseView.arr4.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0){//13
        
        if (choseView.string.length==0 && choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length>0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string.length==0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.arr3.count==0 && choseView.colorarr.count>0 && choseView.arr4.count>0){//14
        
        if (choseView.string.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr4.count>0 && choseView.arr3.count>0){//15
        
        if (choseView.string5.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string5.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string5.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            
            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count>0 && choseView.colorarr.count>0 && choseView.arr4.count>0 && choseView.arr3.count>0){//16
        
        
        if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length==0) {//1
            
            //            [self showAlert:@"请选择 颜色 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length>0){//2
            
            //            [self showAlert:@"请选择 颜色 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length==0){//3
            
            //            [self showAlert:@"请选择 颜色 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length==0){//4
            
            //            [self showAlert:@"请选择 颜色 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length==0){//5
            
            //            [self showAlert:@"请选择 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length==0){//6
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length==0){//7
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length>0){//8
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length==0){//9
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length>0){//10
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length>0){//11
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length==0){//12
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length>0){//13
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length>0){//14
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length>0){//15
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else{//16
            
            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //            }
            
            ///////////////////////////////////////////////
            
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            
        }
        
    }else{
        
        //其他
    }
    
}

//确定
-(void)sure
{
    
  
    NSLog(@"=$$$$$==%@====%@=====%@=====%@==",choseView.string,choseView.string1,choseView.string5,choseView.string6);
    
    NSLog(@"======%ld===",choseView.arr5.count);
    
    if (choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0) {//1
        
        
        
    }else if (choseView.sizearr.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0 && choseView.arr4.count>0) {//颜色2
        
        if (choseView.string.length ==0&&choseView.string5.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length >0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string.length >0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string.length ==0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
            
        }else if (choseView.string.length ==0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string.length ==0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string.length >0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            

                
//                [self Gosure];
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if (choseView.colorarr.count==0 && choseView.sizearr.count>0 && choseView.arr3.count>0 && choseView.arr4.count>0){//尺寸3
        
        if (choseView.string1.length ==0&&choseView.string5.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            

            
 //               [self Gosure];
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];

            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if (choseView.arr3.count==0 && choseView.sizearr.count>0 && choseView.arr4.count>0 && choseView.colorarr.count>0){//风格4
        
        if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string1.length >0&&choseView.string.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
        }else if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
            
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
            
        }else{
            
            
//                [self Gosure];
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if (choseView.arr4.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0 && choseView.sizearr.count>0){//面料5
        
        if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string5.length>0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string1.length >0&&choseView.string.length>0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string5.length>0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else{
            

            
//                [self Gosure];
            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count>0){//6
        
        if (choseView.string6.length==0) {
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else{
            
            
//                [self Gosure];
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
            
            ///////////////////////////////////////////////
            
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr4.count==0 && choseView.arr3.count>0){//7
        
        if (choseView.string5.length==0) {
            
            //            [self showAlert:@"请选择 风格"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else{

            
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
//            [self Gosure];
                

            
            ///////////////////////////////////////////////
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.colorarr.count>0){//8
        
        if (choseView.string.length==0) {
            
            //            [self showAlert:@"请选择 尺码"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
            
        }else{

            
            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
//                [self Gosure];
                
//            }
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
        }
        
    }else if(choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0){//9
        
        if (choseView.string1.length==0) {
            
            //            [self showAlert:@"请选择 颜色"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else{
            

            
//                [self Gosure];
            
//            [self GoToQueRenDingDan];
            
                

            [self GoodsDownForStore];
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
        }
    }else if(choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0 && choseView.colorarr.count>0){//10
        //        choseView.sizeView.seletIndex>0 && choseView.colorView.seletIndex==0
        if (choseView.string1.length==0 && choseView.string.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length>0 && choseView.string.length==0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
            
        }else if (choseView.string1.length==0 && choseView.string.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
            
        }else{
            

            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
            
//                [self Gosure];
                
//            }
            
            ///////////////////////////////////////////////
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
        }
    }else if(choseView.colorarr.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0 && choseView.arr3.count>0){//11
        
        if (choseView.string1.length==0 && choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else{
            


//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
//                [self Gosure];
                
//            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.sizearr.count>0 && choseView.arr4.count>0){//12
        
        if (choseView.string1.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
        }else{
            

            
//                [self Gosure];
            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
            
                
//            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if(choseView.sizearr.count==0 && choseView.arr4.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0){//13
        
        if (choseView.string.length==0 && choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length>0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string.length==0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else{
            

            
//                [self Gosure];
            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
                
//            }
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.arr3.count==0 && choseView.colorarr.count>0 && choseView.arr4.count>0){//14
        
        if (choseView.string.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else{
            

            
//            [self GoToQueRenDingDan];
            
            [self GoodsDownForStore];
//                [self Gosure];
                
//            }
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr4.count>0 && choseView.arr3.count>0){//15
        
        if (choseView.string5.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string5.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string5.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            

            
//                [self Gosure];
            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
//            }
            
            ///////////////////////////////////////////////
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count>0 && choseView.colorarr.count>0 && choseView.arr4.count>0 && choseView.arr3.count>0){//16
        
        
        if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length==0) {//1
            
            //            [self showAlert:@"请选择 颜色 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length>0){//2
            
            //            [self showAlert:@"请选择 颜色 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length==0){//3
            
            //            [self showAlert:@"请选择 颜色 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length==0){//4
            
            //            [self showAlert:@"请选择 颜色 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length==0){//5
            
            //            [self showAlert:@"请选择 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length==0){//6
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length==0){//7
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length>0){//8
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length==0){//9
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length>0){//10
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length>0){//11
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length==0){//12
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length>0){//13
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length>0){//14
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length>0){//15
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else{//16
            

            
            
//            [self GoToQueRenDingDan];
            
            
            [self GoodsDownForStore];
            
//                [self Gosure];
                
//            }
            
            ///////////////////////////////////////////////
            
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            
        }
        
    }else{
        
        //其他
    }
}

//商品是否下架
-(void)GoodsDownForStore
{
    
    //发送通知，创建菊花，立即购买按钮不可点
    NSNotification *notification = [[NSNotification alloc] initWithName:@"ChoseViewReloadData1" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    
    if (choseView.stock==0) {
        
        [JRToast showWithText:@"该组商品库存为0" duration:1.0f];
        
    }else{
        
        NSLog(@"****choseView.user_amount***===%@",choseView.user_amount);
        
        NSLog(@"*****self.user_amount**===%@",self.user_amount);
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        
        self.sigen=[userDefaultes stringForKey:@"sigen"];
        
        
        if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
            
            //            NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            vc.delegate=self;
            
            vc.backString=@"300";
            
            vc.OOOOOOOOO=@"222";
            
            
            self.detailId = choseView.detailId;
            self.good_type = choseView.Goods_type;
            self.yunfei = choseView.yunfei;
            self.exchange = choseView.exchange;
            self.num = choseView.countView.tf_count.text;
            
            
            if ([self.exchange integerValue]==1 || [self.exchange integerValue]==2) {
                
                self.SendWayType = @"0";
                
            }else if ([self.exchange integerValue]==3 || [self.exchange integerValue]==4){
                
                
                self.SendWayType = @"1";
                
            }
            
            
            NSLog(@"666666666=self.yunfei=%@",self.yunfei);
            NSLog(@"666666666=self.gid=%@",self.gid);
            NSLog(@"666666666=self.sigen=%@",self.sigen);
            NSLog(@"666666666=self.storename=%@",self.storename);
            NSLog(@"666666666=self.logo=%@",self.logo);
            NSLog(@"666666666=self.SendWayType=%@",self.SendWayType);
            NSLog(@"666666666=self.good_type=%@",self.good_type);
            NSLog(@"666666666=self.MoneyType=%@",self.MoneyType);
            NSLog(@"666666666=self.mid=%@",self.mid);
            NSLog(@"666666666=self.num=%@",self.num);
            NSLog(@"666666666=self.exchange=%@",self.exchange);
            NSLog(@"666666666=self.detailId=%@",self.detailId);
            
            vc.gid=self.gid;
            
            vc.sigen=self.sigen;
            
            vc.storename=self.storename;
            
            vc.logo=self.logo;
            
            vc.GoodsDetailType=self.SendWayType;
            
            vc.Goods_Type_Switch=self.good_type;
            
            vc.SendWayType=self.SendWayType;
            
            vc.MoneyType=self.MoneyType;
            
            vc.midddd=self.mid;
            
            vc.yunfei=self.yunfei;
            
            vc.attributenum = self.num;
            vc.exchange = self.exchange;
            vc.detailId = self.detailId;
            
            
            [self.vc.navigationController pushViewController:vc animated:NO];
            
            self.vc.navigationController.navigationBar.hidden=YES;
            
            
        }else{
            
            [HTTPRequestManager POST:@"getConfirmOrderInfo_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"mid":self.mid,@"gid":self.gid,@"logo":@"",@"storename":self.storename,@"detailId":choseView.detailId} parameters:nil result:^(id responseObj, NSError *error) {
                
                
                //        NSLog(@"====%@===",responseObj);
                
                
                if (responseObj) {
                    
                    for (NSDictionary *dict in responseObj) {
                        
                        NSLog(@"=====status=====%@",dict[@"status"]);
                        
                        if ([dict[@"status"] isEqualToString:@"10000"]) {
                            
//                            [hud dismiss:YES];
                            
                            [self dismiss];
                            
                            //发送通知
                            [self GoToQueRenDingDan];
                            
                            
                        }else if([dict[@"status"] isEqualToString:@"10002"]){
                            
//                            [hud dismiss:YES];
                            
                            [self dismiss];
                            
                            [JRToast showWithText:dict[@"message"] duration:1.0f];
                            
                            
                            
                        }else if ([dict[@"status"] isEqualToString:@"10004"]){
//                            [hud dismiss:YES];
                            
                            [self dismiss];
                            
                            [JRToast showWithText:dict[@"message"] duration:1.0f];
                            
                        }else{
                            
//                            [hud dismiss:YES];
                            [self dismiss];
                            
                            [JRToast showWithText:dict[@"message"] duration:1.0f];
                            
                        }
                        
                        
                    }
                    
                }else{
                    
                    
                    NSLog(@"error");
                    
                }
                
                
            }];
            
        }
        
    }
    
}
-(void)Cartsure
{
    
    
    NSLog(@"=$$$$$==%@====%@=====%@=====%@==",choseView.string,choseView.string1,choseView.string5,choseView.string6);
    
    NSLog(@"======%ld===",choseView.arr5.count);
    
    if (choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0) {//1
        
        
        
    }else if (choseView.sizearr.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0 && choseView.arr4.count>0) {//颜色2
        
        if (choseView.string.length ==0&&choseView.string5.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length >0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string.length >0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string.length ==0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
            
        }else if (choseView.string.length ==0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string.length ==0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string.length >0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            
            //                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if (choseView.colorarr.count==0 && choseView.sizearr.count>0 && choseView.arr3.count>0 && choseView.arr4.count>0){//尺寸3
        
        if (choseView.string1.length ==0&&choseView.string5.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if (choseView.arr3.count==0 && choseView.sizearr.count>0 && choseView.arr4.count>0 && choseView.colorarr.count>0){//风格4
        
        if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string1.length >0&&choseView.string.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
        }else if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
            
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
            
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if (choseView.arr4.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0 && choseView.sizearr.count>0){//面料5
        
        if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string5.length>0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string1.length >0&&choseView.string.length>0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string5.length>0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count>0){//6
        
        if (choseView.string6.length==0) {
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr4.count==0 && choseView.arr3.count>0){//7
        
        if (choseView.string5.length==0) {
            
            //            [self showAlert:@"请选择 风格"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else{
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.colorarr.count>0){//8
        
        if (choseView.string.length==0) {
            
            //            [self showAlert:@"请选择 尺码"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
            
        }else{
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
        }
        
    }else if(choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0){//9
        
        if (choseView.string1.length==0) {
            
            //            [self showAlert:@"请选择 颜色"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
        }
    }else if(choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0 && choseView.colorarr.count>0){//10
        //        choseView.sizeView.seletIndex>0 && choseView.colorView.seletIndex==0
        if (choseView.string1.length==0 && choseView.string.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length>0 && choseView.string.length==0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
            
        }else if (choseView.string1.length==0 && choseView.string.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
            
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
        }
    }else if(choseView.colorarr.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0 && choseView.arr3.count>0){//11
        
        if (choseView.string1.length==0 && choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.sizearr.count>0 && choseView.arr4.count>0){//12
        
        if (choseView.string1.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if(choseView.sizearr.count==0 && choseView.arr4.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0){//13
        
        if (choseView.string.length==0 && choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length>0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string.length==0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count==0 && choseView.arr3.count==0 && choseView.colorarr.count>0 && choseView.arr4.count>0){//14
        
        if (choseView.string.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr4.count>0 && choseView.arr3.count>0){//15
        
        if (choseView.string5.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string5.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string5.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //
            //                vc.backString=@"300";
            //
            //
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
        }
        
    }else if(choseView.sizearr.count>0 && choseView.colorarr.count>0 && choseView.arr4.count>0 && choseView.arr3.count>0){//16
        
        
        if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length==0) {//1
            
            //            [self showAlert:@"请选择 颜色 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length>0){//2
            
            //            [self showAlert:@"请选择 颜色 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length==0){//3
            
            //            [self showAlert:@"请选择 颜色 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length==0){//4
            
            //            [self showAlert:@"请选择 颜色 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length==0){//5
            
            //            [self showAlert:@"请选择 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length==0){//6
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length==0){//7
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length>0){//8
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length==0){//9
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length>0){//10
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length>0){//11
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length==0){//12
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length>0){//13
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length>0){//14
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length>0){//15
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else{//16
            
            //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            //            
            //            if ([userDefaultes stringForKey:@"sigen"].length==0 || [[userDefaultes stringForKey:@"sigen"] isEqualToString:@""]) {
            //                
            ////                NewLoginViewController *vc=[[NewLoginViewController alloc] init];
            //                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            //                vc.delegate=self;
            //                
            //                vc.backString=@"300";
            //                
            //                
            //                [self.viewController.navigationController pushViewController:VC animated:NO];
            //                
            //                self.viewController.navigationController.navigationBar.hidden=YES;
            //                
            //            }else{
            
            [self JoinCart];
            
            //            }
            
            ///////////////////////////////////////////////
            
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",choseView.sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",choseView.colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",choseView.arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",choseView.arr4View.seletIndex]];
            
        }
        
    }else{
        
        //其他
    }
}

-(void)JoinCart
{
    
    if ([choseView.StockString isEqualToString:@"0"]) {
        
        [JRToast showWithText:@"该组商品库存为0" duration:1.0f];
        
    }else{
        
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    //        NSLog(@">>>>>>%@",self.sigen);
    
    
    if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
        
        
        
        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
        vc.delegate=self;
        
        vc.backString=@"300";
        
        vc.OOOOOOOOO = @"111";
        
        vc.choseView_gid=self.gid;
        vc.choseView_mid=self.mid;
        vc.choseView_num=choseView.countView.tf_count.text;
        vc.choseView_detailId=choseView.detailId;
        vc.choseView_exchange=choseView.exchange;
        YLog(@"%@",choseView.exchange);
        vc.choseView_NewGoods_Type = self.NewGoods_Type;
        
        
        [self.vc.navigationController pushViewController:vc animated:NO];
        
        self.vc.navigationController.navigationBar.hidden=YES;
        
    }else{
        
        
        
        NSLog(@"加入购物车成功!");
        
        [UserMessageManager YTText:choseView.lb_detail.text];
        
        choseView.num = choseView.countView.tf_count.text;
        
        NSLog(@"===self.sigen===%@",self.sigen);
        NSLog(@"===self.gid===%@",self.gid);
        NSLog(@"===self.mid===%@",self.mid);
        NSLog(@"===self.good_type===%@",self.NewGoods_Type);
        NSLog(@"===self.detailId===%@",choseView.detailId);
        NSLog(@"===exchange_type===%@",choseView.exchange);
        NSLog(@"=====choseView.num===%@",choseView.num);
        
        
        [self JoinCartReauest];
        
        
    }
    }
    
}


-(void)changeAttribute
{
    
    
    
    NSLog(@"=$$$$$==%@====%@=====%@=====%@==",choseView.string,choseView.string1,choseView.string5,choseView.string6);
    
    NSLog(@"======%ld===",choseView.arr5.count);
    
    if (choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0) {//1
        
        
        
    }else if (choseView.sizearr.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0 && choseView.arr4.count>0) {//颜色2
        
        if (choseView.string.length ==0&&choseView.string5.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length >0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string.length >0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string.length ==0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
            
        }else if (choseView.string.length ==0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string.length ==0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string.length >0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]];
            
            [self YTSureBtnClick];
            
            
        }
        
    }else if (choseView.colorarr.count==0 && choseView.sizearr.count>0 && choseView.arr3.count>0 && choseView.arr4.count>0){//尺寸3
        
        if (choseView.string1.length ==0&&choseView.string5.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string5.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
            
        }else if (choseView.string1.length >0&&choseView.string5.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
           _YYYYYYYY = [NSString stringWithFormat:@"%@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]];
            
            [self YTSureBtnClick];
            
            
        }
    }else if (choseView.arr3.count==0 && choseView.sizearr.count>0 && choseView.arr4.count>0 && choseView.colorarr.count>0){//风格4
        
        if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string1.length >0&&choseView.string.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string6.length>0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
        }else if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
            
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
            
        }else{
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]];
            
            [self YTSureBtnClick];
            
            
        }
    }else if (choseView.arr4.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0 && choseView.sizearr.count>0){//面料5
        
        if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string5.length>0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string1.length >0&&choseView.string.length>0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length==0&&choseView.string5.length>0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
            
        }else if (choseView.string1.length ==0&&choseView.string.length>0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else if (choseView.string1.length >0&&choseView.string.length==0&&choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else{
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]];
            
            [self YTSureBtnClick];
            
            
        }
        
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count>0){//6
        
        if (choseView.string6.length==0) {
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else{
            
           _YYYYYYYY = [NSString stringWithFormat:@"%@",choseView.arr5[3]];
            
            [self YTSureBtnClick];
            
            
        }
        
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr4.count==0 && choseView.arr3.count>0){//7
        
        if (choseView.string5.length==0) {
            
            //            [self showAlert:@"请选择 风格"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else{
           
            _YYYYYYYY = [NSString stringWithFormat:@"%@",choseView.arr5[2]];
            [self YTSureBtnClick];
            
            
        }
        
    }else if(choseView.sizearr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.colorarr.count>0){//8
        
        if (choseView.string.length==0) {
            
            //            [self showAlert:@"请选择 尺码"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
            
        }else{
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@",choseView.arr5[1]];
            [self YTSureBtnClick];
            
            
        }
        
    }else if(choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0){//9
        
        if (choseView.string1.length==0) {
            
            //            [self showAlert:@"请选择 颜色"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else{
            
           
            _YYYYYYYY = [NSString stringWithFormat:@"%@",choseView.arr5[0]];
            [self YTSureBtnClick];
            
            
        }
    }else if(choseView.arr3.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0 && choseView.colorarr.count>0){//10
        //        choseView.sizeView.seletIndex>0 && choseView.colorView.seletIndex==0
        if (choseView.string1.length==0 && choseView.string.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
            
        }else if (choseView.string1.length>0 && choseView.string.length==0){
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
            
        }else if (choseView.string1.length==0 && choseView.string.length==0){
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
            
        }else{
            
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@",choseView.arr5[0],choseView.arr5[1]];
            [self YTSureBtnClick];
            
            
        }
    }else if(choseView.colorarr.count==0 && choseView.arr4.count==0 && choseView.sizearr.count>0 && choseView.arr3.count>0){//11
        
        if (choseView.string1.length==0 && choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else{
            
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@",choseView.arr5[0],choseView.arr5[2]];
            [self YTSureBtnClick];
            
           
        }
        
    }else if(choseView.colorarr.count==0 && choseView.arr3.count==0 && choseView.sizearr.count>0 && choseView.arr4.count>0){//12
        
        if (choseView.string1.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
        }else{
            
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@",choseView.arr5[0],choseView.arr5[3]];
            [self YTSureBtnClick];
            
            
        }
    }else if(choseView.sizearr.count==0 && choseView.arr4.count==0 && choseView.colorarr.count>0 && choseView.arr3.count>0){//13
        
        if (choseView.string.length==0 && choseView.string5.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length>0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string.length==0 && choseView.string5.length==0){
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else{
            
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@",choseView.arr5[1],choseView.arr5[2]];
            [self YTSureBtnClick];
            
            
        }
        
    }else if(choseView.sizearr.count==0 && choseView.arr3.count==0 && choseView.colorarr.count>0 && choseView.arr4.count>0){//14
        
        if (choseView.string.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else if (choseView.string.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else{
            
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@",choseView.arr5[1],choseView.arr5[3]];
            [self YTSureBtnClick];
            
            
        }
    }else if(choseView.sizearr.count==0 && choseView.colorarr.count==0 && choseView.arr4.count>0 && choseView.arr3.count>0){//15
        
        if (choseView.string5.length==0 && choseView.string6.length>0) {
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string5.length>0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string5.length==0 && choseView.string6.length==0){
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else{
            
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@",choseView.arr5[2],choseView.arr5[3]];
            [self YTSureBtnClick];
            
            
        }
        
    }else if(choseView.sizearr.count>0 && choseView.colorarr.count>0 && choseView.arr4.count>0 && choseView.arr3.count>0){//16
        
        
        if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length==0) {//1
            
            //            [self showAlert:@"请选择 颜色 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length>0){//2
            
            //            [self showAlert:@"请选择 颜色 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length==0){//3
            
            //            [self showAlert:@"请选择 颜色 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length==0){//4
            
            //            [self showAlert:@"请选择 颜色 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[0],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length==0){//5
            
            //            [self showAlert:@"请选择 尺码 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@ %@",choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length==0){//6
            
            //            [self showAlert:@"请选择 风格 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[2],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length==0){//7
            
            //            [self showAlert:@"请选择 尺码 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[3]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length==0 && choseView.string6.length>0){//8
            
            //            [self showAlert:@"请选择 尺码 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[1],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length==0){//9
            
            //            [self showAlert:@"请选择 颜色 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length>0){//10
            
            //            [self showAlert:@"请选择 颜色 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[2]]];
        }else if (choseView.string1.length==0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length>0){//11
            
            //            [self showAlert:@"请选择 颜色 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@ %@",choseView.arr5[0],choseView.arr5[1]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length==0){//12
            
            //            [self showAlert:@"请选择 面料"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[3]]];
        }else if (choseView.string1.length==0 && choseView.string.length>0 && choseView.string5.length>0 && choseView.string6.length>0){//13
            
            //            [self showAlert:@"请选择 颜色"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[0]]];
        }else if (choseView.string1.length>0 && choseView.string.length>0 && choseView.string5.length==0 && choseView.string6.length>0){//14
            
            //            [self showAlert:@"请选择 风格"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[2]]];
        }else if (choseView.string1.length>0 && choseView.string.length==0 && choseView.string5.length>0 && choseView.string6.length>0){//15
            
            //            [self showAlert:@"请选择 尺码"];
            [self showAlert:[NSString stringWithFormat:@"请选择 %@",choseView.arr5[1]]];
        }else{//16
            
            
            _YYYYYYYY = [NSString stringWithFormat:@"%@ %@ %@ %@",choseView.arr5[0],choseView.arr5[1],choseView.arr5[2],choseView.arr5[3]];
            [self YTSureBtnClick];
            
            
            
        }
        
    }else{
        
        //其他
    }
    
    
}




-(void)YTSureBtnClick
{
    
    choseView.num = choseView.countView.tf_count.text;
    
    if ([choseView.num integerValue]>choseView.stock) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"该组商品库存为%d",choseView.stock] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
        
    }else{
        
        
        
        
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:choseView.lb_detail.text,@"textOne",_YYYYYYYY,@"textTwo",choseView.StockString,@"textThree",choseView.ShuXingString,@"textFour", nil];
        
        
        [UserMessageManager ShuXingString:choseView.ShuXingString];
        
        //清楚再次缓存
        [UserMessageManager RemoveAgain];
        
        //发送通知，修改cell属性
        
        NSNotification *notification = [[NSNotification alloc] initWithName:@"changecellshuxing" object:nil userInfo:dict];
        
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        if (_delegate && [_delegate respondsToSelector:@selector(ChangeAttributeDelegateClick:andSid:andTf:andStock:andTitle:andYYYYY:andSmallId:)]) {
            
            [_delegate ChangeAttributeDelegateClick:choseView.detailId andSid:self.sid andTf:self.tf andStock:choseView.StockString andTitle:choseView.lb_detail.text andYYYYY:_YYYYYYYY andSmallId:choseView.ShuXingString];
        }
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(ChangeAttributeBackDelegate)]) {
            
            [_delegate ChangeAttributeBackDelegate];
        }
        
        
        [self dismiss];
        
    }
    
}
//加入购物车
-(void)JoinCartReauest
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
    NSString *selectSendWay = [userDefaultes stringForKey:@"selectSendWay"];
    
     NSLog(@"====属性框加入购物车==%@",choseView.exchange);
    
    if ([choseView.exchange isEqualToString:@"2"] || [choseView.exchange isEqualToString:@"1"]) {
        
        choseView.exchange = @"0";
        
    }else{
        
        if ([selectSendWay isEqualToString:@"0"]) {
            
            choseView.exchange = @"0";
            
        }else if([selectSendWay isEqualToString:@"1"]){
            
            choseView.exchange = @"1";
            
        }else{
            
            choseView.exchange = @"0";
        }
        
    }
        
        
    WKProgressHUD *hud = [WKProgressHUD showInView:self.superview withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
        
    });
    
    
    NSLog(@"pay_number_hidden=%@",choseView.num);
    if ([[NSString stringWithFormat:@"%@",choseView.num] integerValue]<0) {
        [TrainToast showWithText:@"添加数目不正确" duration:2.0];
        return;
    }
    
    [HTTPRequestManager POST:@"joinShopping_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"id":self.gid,@"mid":self.mid,@"pay_number_hidden":choseView.num,@"good_type":self.NewGoods_Type,@"detailId":choseView.detailId,@"exchange_type":choseView.exchange} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"====%@===",responseObj);
        
        if (responseObj) {
            
            for (NSDictionary *dict in responseObj) {
                
                //                    NSLog(@"======%@==",dict[@"message"]);
                //                    NSLog(@"======%@==",dict[@"status"]);
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
//                    [JRToast showWithText:dict[@"message"] duration:1.0f];
                    
//                    [[SMProgressHUD shareInstancetype] showTip:@"加入购物车成功"];
                    
                    
//                    [self dismiss];
                    
                    [hud dismiss:YES];
                    
                    self.CartString = @"100";
                    
                    
                    NSNotification *GoodsCart = [[NSNotification alloc] initWithName:@"GoodsCart" object:nil userInfo:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:GoodsCart];
                    
                    
                    [self Gosure];
                    
                    
                }else if([dict[@"status"] isEqualToString:@"10002"]){
                    
                    
//                    [JRToast showWithText:dict[@"message"] duration:1.0f];
                    
                    
                    alertCon = [UIAlertController alertControllerWithTitle:dict[@"message"] message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        
                        //属性框消失
                        [self dismiss];
                        
                        BackCartViewController *vc = [[BackCartViewController alloc] init];
                        
                        vc.sigen=self.sigen;
                        
//                        vc.delegate=self.vc;
                        vc.BackString = @"100";
                        
                        vc.jindu = self.jindu;
                        vc.weidu = self.weidu;
                        vc.MapStartAddress = self.MapStartAddress;
                        
                        [self.vc.navigationController pushViewController:vc animated:NO];
                        
                        
                        
                    }]];
                    
                    [self.vc presentViewController: alertCon animated: YES completion: nil];
                    
                }else if([dict[@"status"] isEqualToString:@"10004"]){
                    
                    [hud dismiss:YES];
                    
                    //                    [JRToast showWithText:dict[@"message"] duration:1.0f];
                    
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:dict[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    
                }else{
                    
                    
                    [hud dismiss:YES];
                    
                    //                    [JRToast showWithText:dict[@"message"] duration:1.0f];
                    
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:dict[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    
                }
                
                
            }
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//删除观察者
//- (void)dealloc{
//    //删除观察者
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"yangtao" object:nil];
//}
@end
