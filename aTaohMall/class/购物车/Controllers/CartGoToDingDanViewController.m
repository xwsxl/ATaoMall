//
//  CartGoToDingDanViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CartGoToDingDanViewController.h"

#import "CartAddressCell.h"

#import "CartDingDanHeader.h"

#import "CartDingDanCell.h"

#import "CartDingDanFooter.h"

#import "CartUseScoreCell.h"

#import "CartAddressModel.h"

#import "CartGoodsModel.h"

#import "CartStoreModel.h"

#import "UIImageView+WebCache.h"

#import "YTAddressViewController.h"//新增收货地址

#import "YTAddressManngerViewController.h"//收货地址管理

#import "GotoShopLookViewController.h"

#import "JRToast.h"
//配送方式 弹出视图
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"
#import "CustomActionSheet.h"
//获得iOS版本
#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue]

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "PersonalAllDanVC.h"
#import "AppDelegate.h"

#import "UserMessageManager.h"

#import "WKProgressHUD.h"
@interface CartGoToDingDanViewController ()<UITableViewDelegate,UITableViewDataSource,YTDelwgate,GetGoodsAdddressDelegate,CartDingDanFooterDelegate,CustomActionSheetDelagate,CartDingDanCellDelegate,UITextFieldDelegate,UITextViewDelegate,GoToLookDelegate>
{
    
    UITableView *_tableView;
    
    NSMutableArray *_AddressArrM;//地址
    
    NSMutableArray *_StoreArrM;//店铺
    
    NSMutableArray *_GoodsArrM;//商品
    
    NSMutableArray *_LabelArrM;//合计
    
    NSMutableArray *_RedArrM;//金钱
    
    NSMutableArray *_WordTextViewTag;
    
    CartDingDanFooter *footer;
    
    CartAddressCell *cell1;//收货地址
    
    NSInteger _GoodsCount;//商品数量
    
    float _GoodsAllPrice;//商品总价
    
    float _MaxInteger;//用户能兑换的最大积分
    
    UILabel *priceLabel;//商品总价
    
    BOOL isButtonOn;
    
    NSString *_isIntegerAdd_Reduce;//判断是否积分兑换
    
    NSInteger _SelectCell;//选中的cell
    
    NSInteger _SelectSection;//选中的cell

    NSInteger _SelectIndexPath;//选中的cell
    
    NSInteger _WordSection;//选中的cell
    
    
    CGRect textField_rect;
    
    CartUseScoreCell *ScoreCell;
    
    NSInteger _WordTfTag;
    
    NSString *deductionIntegral;
    
    
    
}
@end

@implementation CartGoToDingDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden=YES;
    
    isButtonOn=1;
    
    _WordTfTag = 0;
    
    deductionIntegral = @"";
    
    self.AddressReloadString = @"66";
    
    _isIntegerAdd_Reduce = @"11";
    
    _GoodsCount = 0;
    
    _GoodsAllPrice = 0;
    
    _MaxInteger = 0;
    
    _SelectSection = 0;
    
    _SelectIndexPath = 0;
    
    _WordSection = 0;
    
    _AddressArrM  = [NSMutableArray new];
    
    _StoreArrM = [NSMutableArray new];
    
    _GoodsArrM = [NSMutableArray new];
    
    _LabelArrM = [NSMutableArray new];
    
    _RedArrM = [NSMutableArray new];
    
    _WordTextViewTag = [NSMutableArray new];

    _NewAddressArrM  =[NSMutableArray new];
    
    
    //创建Nav
    [self initNav];
    
    //创建底部视图
    [self initBottomView];
    
    //创建tableview
    [self initTableView];
    
    //获取商品数据
    [self getDatas];
    
    
    
 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘的掉下
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultStatus:) name:@"resultStatus" object:nil];
    
    
}

-(void)AddressReload
{
    
    [_AddressArrM removeAllObjects];

    //
    [self XLAddressgetdatas];

}

-(void)XLAddressgetdatas
{
    [HTTPRequestManager POST:@"getSettlementGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"json":self.json} parameters:nil result:^(id responseObj, NSError *error) {
        for (NSDictionary *dict in responseObj) {
            if ([dict[@"status"] isEqualToString:@"10000"]) {
                self.responseObj=responseObj;
                for (NSDictionary *dic in self.responseObj) {

                    for (NSDictionary *dict1 in dic[@"addresslist"]) {
                        CartAddressModel *model = [[CartAddressModel alloc] init];
                        model.name = dict1[@"name"];
                        model.phone = dict1[@"phone"];
                        model.defaultstate = dict1[@"defaultstate"];
                        model.province = dict1[@"province"];
                        model.city = dict1[@"city"];
                        model.county = dict1[@"county"];
                        model.address = dict1[@"address"];
                        model.addressId = dict1[@"id"];
                        [_AddressArrM addObject:model];
                        YLog(@"%@,%@",model.addressId,self.AddressAid);
                        if ([[NSString stringWithFormat:@"%@",model.addressId]  isEqualToString:[NSString stringWithFormat:@"%@",self.AddressAid]]) {
                            cell1.Name.text = [NSString stringWithFormat:@"收货人：%@",model.name];
                            cell1.Phone.text = [NSString stringWithFormat:@"%@",model.phone];
                            cell1.Address.text = [NSString stringWithFormat:@"收货地址：%@",model.address];
                            self.AddressPhone = model.phone;
                        }
                    }
                }

            }
        }
    }];
}


//收货地址为空
-(void)DeleteTheLastAddress
{
    
    NSLog(@"（（（（（收货地址为空）））））");
    
    [_AddressArrM removeAllObjects];
    
    self.UserType = @"333";
    
    self.AddressPhone = @"";
    
    [_tableView reloadData];
    
}

-(void)initNav
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UIButton *BackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    BackButton.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    [BackButton setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [BackButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:BackButton];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"确认订单";
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:20];
    
    label.textColor = [UIColor blackColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    UIImageView *imgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    imgLine.image = [UIImage imageNamed:@"分割线YT"];
    
    [self.view addSubview:imgLine];
    
    
}


-(void)initBottomView
{
    
    UIView *priceView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 49)];
    
    [self.view addSubview:priceView];
    
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line1];
    
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width-125, 20)];
    priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    
    priceLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    priceLabel.textAlignment=NSTextAlignmentRight;
//    priceLabel.text = @"共3件，合计：￥830.00";
    
    
    
    
    [priceView addSubview:priceLabel];
    
    
    UIButton *SubmitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SubmitButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 49);
    [SubmitButton setTitle:@"提交订单" forState:0];
    [SubmitButton setTintColor:[UIColor whiteColor]];
    SubmitButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    SubmitButton.backgroundColor=  [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [SubmitButton addTarget:self action:@selector(SubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [priceView addSubview:SubmitButton];
    
    
    
}
-(void)initTableView
{
    
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-50-KSafeAreaBottomHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    //去除系统分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[CartAddressCell class] forCellReuseIdentifier:@"address"];
    
    [_tableView registerClass:[CartDingDanHeader class] forHeaderFooterViewReuseIdentifier:@"Header"];
    
    [_tableView registerClass:[CartDingDanFooter class] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    [_tableView registerClass:[CartDingDanCell class] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerClass:[CartUseScoreCell class] forCellReuseIdentifier:@"cell2"];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    // code1
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // code2
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}



-(void)getDatas
{

    isButtonOn=1;

    _WordTfTag = 0;

    deductionIntegral = @"";

    self.AddressReloadString = @"66";

    _isIntegerAdd_Reduce = @"11";

    _GoodsCount = 0;

    _GoodsAllPrice = 0;

    _MaxInteger = 0;

    _SelectSection = 0;

    _SelectIndexPath = 0;

    _WordSection = 0;
    [_StoreArrM removeAllObjects];

    [_GoodsArrM removeAllObjects];

    [_LabelArrM removeAllObjects];

    [_RedArrM removeAllObjects];

    [_WordTextViewTag removeAllObjects];

    [_NewAddressArrM removeAllObjects];
    NSLog(@"====确认订单json====%@",self.json);
    
//    [HTTPRequestManager POST:@"getSettlementGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"json":self.json} parameters:nil result:^(id responseObj, NSError *error) {
        

//        NSLog(@"==确认订单获取数据源==%@===",responseObj);
        
        
        if (self.responseObj) {
            
            for (NSDictionary *dict in self.responseObj) {
                
                NSLog(@"%@",dict);
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    self.UserInteger=[NSString stringWithFormat:@"%@",dict[@"integral"]];
                    //地址信息
                    
                    for (NSDictionary *dict1 in dict[@"addresslist"]) {
                        
                        
                            CartAddressModel *model = [[CartAddressModel alloc] init];
                            
                            model.name = dict1[@"name"];
                            model.phone = dict1[@"phone"];
                            model.defaultstate = dict1[@"defaultstate"];
                            model.province = dict1[@"province"];
                            model.city = dict1[@"city"];
                            model.county = dict1[@"county"];
                            model.address = dict1[@"address"];
                            model.addressId = dict1[@"id"];
                            [_AddressArrM addObject:model];
                    }
                    
                    
                    //商品信息
                    
                    for (NSDictionary *dict2 in dict[@"goods"]) {
                        
                        CartStoreModel *model1 = [[CartStoreModel alloc] init];
                        
                        model1.storename = dict2[@"storename"];
                        
                        model1.mid = dict2[@"mid"];
                        
                        
                        [model1 configGoodsArrayWithArray:[dict2 objectForKey:@"goodsList"]];
                        
                        [_StoreArrM addObject:model1];
                        
                        
                    }
                    
                }
                
                
                        NSMutableArray *priceArrM = [NSMutableArray new];
                
                        NSMutableArray *OtherArrM = [NSMutableArray new];
                
                
                        NSInteger nnnnn = 0;
                
                        float number = 0;
                
                        for (int i=0; i < _StoreArrM.count; i++) {
                
                            CartStoreModel *model = _StoreArrM[i];
                
//                            nnnnn = model.goodsList.count;
//                            _GoodsCount += model.goodsList.count;//商品总件数
                            
                            footer.goodsArray  = model.goodsList;
                
                            for (int j=0; j < model.goodsList.count; j++) {
                
                                CartGoodsModel *goods = model.goodsList[j];
                
                                
                                nnnnn += [goods.number intValue];
                                _GoodsCount += [goods.number intValue];//商品总件数
                                
                                
                                NSString *price ;
                                
                                //判断配送方式
                                if ([goods.exchange_type isEqualToString:@"0"]) {
                                    
                                    
                                    if ([goods.freight isEqualToString:@"0"]) {
                                        
                                        price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue]];
                                        
                                    }else{
                                        
                                        price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue] + [goods.freight floatValue] * [goods.number floatValue]];
                                        
                                    }
                                    
                                    
                                }else{
                                    
                                    
                                    price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue]];
                                    
                                }
                                
                                
                                _MaxInteger +=[goods.pay_integer floatValue] *[goods.number floatValue];
                                
                                [priceArrM addObject:price];
                
                
                
                            }
                
                
//                            NSLog(@"==666===%@",priceArrM);
                
                            OtherArrM = [[NSMutableArray alloc] initWithArray:priceArrM];
                
                            
                
                
                
                
                            for (NSString *price in priceArrM) {
                
                
//                                NSLog(@"==price==%@",price);
                                
                                number += [price floatValue];
                                
                                _GoodsAllPrice += [price floatValue];
                                
                
                            }
                            
                           [priceArrM removeAllObjects];
                            
                            NSString *string = [NSString stringWithFormat:@"共%ld件商品 小计：￥%.02f",nnnnn,number];
                            
 //                           NSLog(@"===111====%@",string);
                            
                            NSString *red = [NSString stringWithFormat:@"￥%.02f",number];
                            
 //                           NSLog(@"===222====%@",red);
                            
                            [_LabelArrM addObject:string];
                            
                            [_RedArrM addObject:red];
                            
                            number=0;
                            nnnnn=0;
                            
                            
                            
                        }
                
                
                //刷新数据源
                [_tableView reloadData];
                
            }
        }
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _StoreArrM.count+2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return 1;
        
    }if (section==_StoreArrM.count+1) {
        
        return 1;
        
    }else{
        
        CartStoreModel *model = _StoreArrM[section-1];
        
        
        return model.goodsList.count;
        
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"address"];
    
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //新增收货地址回显
        if ([self.UserType isEqualToString:@"888"]) {
            
            NSLog(@"1111111111111111");
            
            cell1.UserType = self.UserType;
            
            cell1.ShuoMingLabel.hidden=YES;
            
            cell1.Name.text = [NSString stringWithFormat:@"收货人：%@",self.UserName];
            
            cell1.Phone.text = [NSString stringWithFormat:@"%@",self.UserPhone];
            
            cell1.Address.text = [NSString stringWithFormat:@"收货地址：%@",self.UserAddress];
            
            
        }else{
            
            cell1.AddressArray = _AddressArrM;
            
//            cell1.AddressArray = _NewAddressArrM;
            
            NSLog(@"====_AddressArrM.count====%ld",_AddressArrM.count);
            
            for (CartAddressModel *model in _AddressArrM) {
                
                if (_AddressArrM.count==0) {
                    
                    NSLog(@"222222222222222");
                    
                    cell1.ShuoMingLabel.hidden=NO;
                    cell1.Name.hidden=YES;
                    cell1.Address.hidden=YES;
                    cell1.Phone.hidden=YES;
                    
                }else{
                    
                    cell1.ShuoMingLabel.hidden=YES;
                    
                    if ([model.defaultstate isEqualToString:@"1"]) {
                        
                        NSLog(@"3333333333333");
                        
                        cell1.Name.text = [NSString stringWithFormat:@"收货人：%@",model.name];
                        cell1.Phone.text = [NSString stringWithFormat:@"%@",model.phone];
                        cell1.Address.text = [NSString stringWithFormat:@"收货地址：%@",model.address];
                        
                        
                        self.AddressAid = model.addressId;
                        
                        self.AddressPhone = model.phone;
                        
                        
                        
                        
                        break;
                        
                    }else{
                        
                        NSLog(@"444444444444444");
                        
                        cell1.Name.text = [NSString stringWithFormat:@"收货人：%@",model.name];
                        cell1.Phone.text = [NSString stringWithFormat:@"%@",model.phone];
                        cell1.Address.text = [NSString stringWithFormat:@"收货地址：%@",model.address];
                        
                        
                        self.AddressAid = model.addressId;
                        
                        self.AddressPhone = model.phone;
                        
                        
                    }
                }
            }
            
        }
        
        if ([_isIntegerAdd_Reduce isEqualToString:@"11"]) {
            
            
            //用户积分大于抵扣积分
            if ([self.UserInteger floatValue] >= _MaxInteger) {
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice-_MaxInteger];
                NSLog(@"==111==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice-_MaxInteger];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = [NSString stringWithFormat:@"%.02f",_MaxInteger];
                
                
            }else{//用户积分小于抵扣积分
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计:￥%.02f",(long)_GoodsCount,_GoodsAllPrice-[self.UserInteger floatValue]];
                NSLog(@"==222==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice-[self.UserInteger floatValue]];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = [NSString stringWithFormat:@"%@",self.UserInteger];
            }
            
            
        }else{
            
            
            
            NSString *string = [NSString stringWithFormat:@"共%ld件，合计:￥%.02f",(long)_GoodsCount,_GoodsAllPrice];
            
            NSLog(@"==333==string==%@====",string);
            
            NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice];
            
            NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
            
            
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            NSRange range1 = [string rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
            
            
            priceLabel.attributedText=mAttStri;
            
            
            deductionIntegral = @"0";
            
        }
        
        
        
        return cell1;
        
    }else if(indexPath.section==_StoreArrM.count+1){
        
        ScoreCell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        ScoreCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        if ([self.UserInteger floatValue] >= _MaxInteger) {
            
            ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",_MaxInteger];
            ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",_MaxInteger];
            ScoreCell.ScoreLabel.text =[NSString stringWithFormat:@"你有%.02f积分，最多使用%.02f积分",[self.UserInteger floatValue],_MaxInteger];
            
        }else{
            
            ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",[self.UserInteger floatValue]];
            ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",[self.UserInteger floatValue]];
            ScoreCell.ScoreLabel.text =[NSString stringWithFormat:@"你有%.02f积分，最多使用%.02f积分",[self.UserInteger floatValue],[self.UserInteger floatValue]];
        }
        
        
        
        if ([_isIntegerAdd_Reduce isEqualToString:@"11"]) {
            
            //用户积分大于抵扣积分
            if ([self.UserInteger floatValue] >= _MaxInteger) {
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice-_MaxInteger];
                
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice-_MaxInteger];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = [NSString stringWithFormat:@"%.02f",_MaxInteger];
                
            }else{//用户积分小于抵扣积分
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计:￥%.02f",(long)_GoodsCount,_GoodsAllPrice-[self.UserInteger floatValue]];
                
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice-[self.UserInteger floatValue]];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = [NSString stringWithFormat:@"%@",self.UserInteger];
            }
            
            
            
        }else{
            
            NSString *string = [NSString stringWithFormat:@"共%ld件，合计:￥%.02f",(long)_GoodsCount,_GoodsAllPrice];
            
            NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice];
            
            NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
            
            
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            NSRange range1 = [string rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
            
            
            priceLabel.attributedText=mAttStri;
            
            
            deductionIntegral = @"0";
            
        }
        
        
        
        //使用积分开关事件
        [ScoreCell.UseJiFenSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        ScoreCell.UseJiFenSwitch.tag=300;
        
        ScoreCell.ScoreTF.delegate=self;
        ScoreCell.ScoreTF.tag=100;
        ScoreCell.ScoreTF.keyboardType = UIKeyboardTypeNamePhonePad;
        ScoreCell.ScoreTF.returnKeyType=UIReturnKeyDone;
        return ScoreCell;
        
    }else{
        
        CartDingDanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        cell.delegate=self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CartStoreModel *model = _StoreArrM[indexPath.section-1];
        
        CartGoodsModel *model1 = model.goodsList[indexPath.row];
        
        
        _SelectCell = indexPath.section + indexPath.row;
        
        
        
        cell.tag = _SelectCell;
        
        [cell.GoodsImg sd_setImageWithURL:[NSURL URLWithString:model1.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        
        cell.GoodsNameLab.text = model1.name;
        
        cell.NewGoodsNameLab.text = model1.name;
        
        cell.GoodsAttributeLab.text = model1.attribute_str;
        
        cell.Attribute_str=  model1.attribute_str;
        
        cell.GoodsNumberLab.text = [NSString stringWithFormat:@"x%@",model1.number];
        
        cell.GoodsPriceLab.text = [NSString stringWithFormat:@"￥%.02f+%.02f",[model1.pay_maney floatValue],[model1.pay_integer floatValue]];
        
        cell.NewGoodsPriceLab.text = [NSString stringWithFormat:@"￥%.02f+%.02f",[model1.pay_maney floatValue],[model1.pay_integer floatValue]];
        
        
        if ([model1.exchange_type isEqualToString:@"0"]) {
            
            //快递邮寄显示的邮费为总的邮费数
            cell.GoodsKuaiDiLab.text = [NSString stringWithFormat:@"快递邮寄￥%.02f",[model1.freight floatValue] * [model1.number floatValue]];
            
        }else{
            
            
            cell.GoodsKuaiDiLab.text = [NSString stringWithFormat:@"线下自取￥0.00"];
        }
        
        
        //        [cell.SendWayButton addTarget:self action:@selector(TypeWaySendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section==0) {
        
        return [[UIView alloc]init];
        
    }if (section==_StoreArrM.count+1) {
        
        return [[UIView alloc]init];
        
    }else{
        
        
        footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        
        CartStoreModel *model = _StoreArrM[section-1];
        
        footer.delegate=self;
        
        footer.WordTF.delegate=self;
        
        footer.WordTF.tag = [model.mid integerValue];
        
        _WordTfTag = section+1;
        
        _WordSection = section;
        
        if (![_WordTextViewTag containsObject:[NSString stringWithFormat:@"%d",(int)_WordSection]]) {
            
            
            [_WordTextViewTag addObject:[NSString stringWithFormat:@"%d",(int)_WordSection]];
            
        }
        
        
        NSLog(@"===footer.WordTF.tag===%ld====%ld",(long)footer.WordTF.tag,(long)_WordTextViewTag.count);
        
//        footer.WordTF.returnKeyType =UIReturnKeyDone;
        
        NSString *string = _LabelArrM[section-1];
        
        NSString *red = _RedArrM[section-1];
        
        NSLog(@"====******==(long)section==%ld",(long)section);
        
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
        //
        NSRange range = [string rangeOfString:red];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                    
        footer.HeJiLabel.attributedText=mAttStri;
        
        return footer;
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        
        return [[UIView alloc]init];
        
        
    }if (section==_StoreArrM.count+1) {
        
        return [[UIView alloc]init];
        
        
    }else{
        
        CartDingDanHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
        
        CartStoreModel *model = _StoreArrM[section-1];
        
        
        header.carModel = model;
        
        header.delegate=self;
        
        header.ShopLab.text = model.storename;
    
        
        return header;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        return 139;
        
    }if (indexPath.section==_StoreArrM.count+1) {
        
        return 80;
        
    }else{
        
       return 170;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        
        return 0.00000000001;
        
    }if (section==_StoreArrM.count+1) {
        
        return 0.00000000001;
        
    }else{
        
        return 50;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section==0) {
        
        return 0.00000000000001;
        
    }if (section==_StoreArrM.count+1) {
        
        return 0.00000000000001;
        
    }else{
        
        
        return 180;
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.view endEditing:YES];
    
    if (indexPath.section==0) {
        
        NSLog(@"==========");
        
        if (_AddressArrM.count==0 && [self.AddressReloadString isEqualToString:@"66"]) {
            
            YTAddressViewController *vc=[[YTAddressViewController alloc] init];
            
            vc.YTString=@"100";
            
            vc.delegate=self;
            
            self.navigationController.navigationBar.hidden=YES;
            
            [self.navigationController pushViewController:vc animated:NO];
            
        }else{
            
            YTAddressManngerViewController *vc=[[YTAddressManngerViewController alloc] init];
            
            vc.back=@"100";
            
            vc.YTString=@"200";
            
            vc.delegate=self;
            
            [self.navigationController pushViewController:vc animated:NO];
            
            self.navigationController.navigationBar.hidden=YES;
            
            
        }
        
    }
}

#pragma Mark-新增收货代理方法

-(void)setUserName:(NSString *)name andPhone:(NSString *)phone andDetailAddress:(NSString *)address andType:(NSString *)type andID:(NSString *)addressID andAddressReload:(NSString *)reload
{
    
    NSLog(@"======>>%@",name);
    NSLog(@"======>>%@",phone);
    NSLog(@"======>>%@",address);
    NSLog(@"======>>%@",type);
    NSLog(@"======>>%@",addressID);
    NSLog(@"======>>%@",reload);
    
    
    self.AddressAid = addressID;
    
    self.AddressPhone = phone;
    
    
    self.UserName=name;
    self.UserAddress=address;
    self.UserPhone=phone;
    
    self.UserType=type;
    self.UserID=addressID;
    
    self.AddressReloadString = reload;
    
//    [_AddressArrM removeAllObjects];
//    
//    [_StoreArrM removeAllObjects];
//    
//    [self getDatas];
    
    [_tableView reloadData];
    
    
}

-(void)YTData
{
    
    
}

-(void)reshData
{
    
    
}

//===================================

#pragma  Mark-收货地址管理代理方法
-(void)setUserNameWithString:(NSString *)name andPhoneWithString:(NSString *)phone andDetailAddressWithString:(NSString *)address andType:(NSString *)type andIDWithString:(NSString *)addressID andAddressReloadString:(NSString *)reload
{
    
    
    self.AddressAid = addressID;
    
    self.AddressPhone = phone;
    
    
    self.UserName=name;
    self.UserAddress=address;
    self.UserPhone=phone;
    
    self.UserType=type;
    self.UserID=addressID;
    
    self.AddressReloadString=reload;
    
    NSLog(@"======>>%@",self.UserAddress);
    NSLog(@"======>>%@",self.UserName);
    NSLog(@"======>>%@",self.UserPhone);
    NSLog(@"======>>%@",self.UserType);
    NSLog(@"======>>%@",self.UserID);
    
    
//    
//    [_AddressArrM removeAllObjects];
//    
//    [_StoreArrM removeAllObjects];
//    
//    [self getDatas];
    
    [_tableView reloadData];
    
    
}

#pragma mark - Footer结算代理方法
-(void)footerCountMoney:(UILabel *)Money
{
    
    CartDingDanFooter *CartFooter = (CartDingDanFooter *)[Money superview];
    
    
}


//使用积分
-(void)switchAction:(id)sender
{
    
    UISwitch *switchButton = (UISwitch*)sender;
    isButtonOn = [switchButton isOn];
    
    if (isButtonOn) {
        NSLog(@"on");
        
        _isIntegerAdd_Reduce = @"11";
       
        
        
        
        [_tableView reloadData];
        
    }else {
        NSLog(@"off");
        
        
        _isIntegerAdd_Reduce = @"22";
        
    
    }
    
    
    
    [_tableView reloadData];
    
}


//配送方式
-(void)TypeWaySendBtnClick:(UIButton *)sender
{
    

}


//配送方式代理方法
- (void)sheet:(CustomActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((long)buttonIndex==0) {
        
        
        sheet.SelectString=@"1";
        
        CartDingDanCell *CartCell = (CartDingDanCell *)[self.view viewWithTag:_SelectCell];
        
        CartCell.GoodsKuaiDiLab.text = [NSString stringWithFormat:@"快递邮寄￥0.00"];
        
        //=====================修改配送方式=================================
        for (int i=0; i < _StoreArrM.count; i++) {
            
            CartStoreModel *model = _StoreArrM[i];
            
            footer.goodsArray  = model.goodsList;
            
            for (int j=0; j < model.goodsList.count; j++) {
                
                
                CartGoodsModel *goods = model.goodsList[j];
                
//                NSLog(@"-----_SelectSection------%ld-----_SelectIndexPath----%ld--",(long)_SelectSection,(long)_SelectIndexPath);
                
                if (i==(int)_SelectSection-1 && j==(int)_SelectIndexPath) {
                    
                    
//                    NSLog(@"===goods.exchange_type==%@=goods.exchange=%@===",goods.exchange_type,goods.exchange);
                    
                    goods.exchange_type = @"0";
                    
                    
                }
                
//                NSLog(@"===goods.exchange_type==%@=goods.exchange=%@===",goods.exchange_type,goods.exchange);
                
                
            }
        }
        
        //============================修改运费 小计==================================
        
        [_LabelArrM removeAllObjects];
        [_RedArrM removeAllObjects];
        _GoodsCount=0;
        _MaxInteger=0;
        _GoodsAllPrice=0;
        
        NSMutableArray *priceArrM = [NSMutableArray new];
        
        NSMutableArray *OtherArrM = [NSMutableArray new];
        
        
        NSInteger nnnnn = 0;
        
        float number = 0;
        
        for (int i=0; i < _StoreArrM.count; i++) {
            
            CartStoreModel *model = _StoreArrM[i];
            
//            nnnnn = model.goodsList.count;
//            _GoodsCount += model.goodsList.count;//商品总件数
            
            footer.goodsArray  = model.goodsList;
            
            for (int j=0; j < model.goodsList.count; j++) {
                
                CartGoodsModel *goods = model.goodsList[j];
                
                
                nnnnn += [goods.number intValue];
                _GoodsCount += [goods.number intValue];//商品总件数
                
                
                NSString *price ;
                
                //判断配送方式
                if ([goods.exchange_type isEqualToString:@"0"]) {
                    
                    
                    if ([goods.freight isEqualToString:@"0"]) {
                        
                        price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue]];
                        
                    }else{
                        
                        price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue] + [goods.freight floatValue] * [goods.number floatValue]];
                        
                    }
                    
                    
                }else{
                    
                    
                    price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue]];
                    
                }
                
                
                _MaxInteger +=[goods.pay_integer floatValue] *[goods.number floatValue];
                
                [priceArrM addObject:price];
                
                
                
            }
            
            
            //                            NSLog(@"==666===%@",priceArrM);
            
            OtherArrM = [[NSMutableArray alloc] initWithArray:priceArrM];
            
            
            
            
            
            
            for (NSString *price in priceArrM) {
                
                
                //                                NSLog(@"==price==%@",price);
                
                number += [price floatValue];
                
                _GoodsAllPrice += [price floatValue];
                
                
            }
            
            [priceArrM removeAllObjects];
            
            NSString *string = [NSString stringWithFormat:@"共%ld件商品 小计：￥%.02f",nnnnn,number];
            
            //                           NSLog(@"===111====%@",string);
            
            NSString *red = [NSString stringWithFormat:@"￥%.02f",number];
            
            //                           NSLog(@"===222====%@",red);
            
            [_LabelArrM addObject:string];
            
            [_RedArrM addObject:red];
            
            number=0;
            
            nnnnn=0;
            
            
            
        }
        
        
        
        
        [_tableView reloadData];
        
        
        
        
    }else if ((long)buttonIndex==1){
        
       sheet.SelectString=@"2";
        
       
        for (int i=0; i < _StoreArrM.count; i++) {
            
            CartStoreModel *model = _StoreArrM[i];
            
            footer.goodsArray  = model.goodsList;
            
            for (int j=0; j < model.goodsList.count; j++) {
                
                
                CartGoodsModel *goods = model.goodsList[j];
                
                //                NSLog(@"-----_SelectSection------%ld-----_SelectIndexPath----%ld--",(long)_SelectSection,(long)_SelectIndexPath);
                
                if (i==(int)_SelectSection-1 && j==(int)_SelectIndexPath) {
                    
                    
//                    NSLog(@"===goods.exchange_type==%@=goods.exchange=%@===",goods.exchange_type,goods.exchange);
                    
                    goods.exchange_type = @"1";
                    
                    
                }
                
                //                NSLog(@"===goods.exchange_type==%@=goods.exchange=%@===",goods.exchange_type,goods.exchange);
                
                
            }
        }
        
        //============================修改运费 小计==================================
        
        [_LabelArrM removeAllObjects];
        [_RedArrM removeAllObjects];
        _GoodsCount=0;
        _MaxInteger=0;
        _GoodsAllPrice=0;
        
        
        NSMutableArray *priceArrM = [NSMutableArray new];
        
        NSMutableArray *OtherArrM = [NSMutableArray new];
        
        
        NSInteger nnnnn = 0;
        
        float number = 0;
        
        for (int i=0; i < _StoreArrM.count; i++) {
            
            CartStoreModel *model = _StoreArrM[i];
            
//            nnnnn = model.goodsList.count;
//            _GoodsCount += model.goodsList.count;//商品总件数
            
            
            footer.goodsArray  = model.goodsList;
            
            for (int j=0; j < model.goodsList.count; j++) {
                
                CartGoodsModel *goods = model.goodsList[j];
                
                
                nnnnn += [goods.number intValue];
                _GoodsCount += [goods.number intValue];//商品总件数
                
                
                
                
                NSString *price ;
                
                //判断配送方式
                if ([goods.exchange_type isEqualToString:@"0"]) {
                    
                    
                    if ([goods.freight isEqualToString:@"0"]) {
                        
                        price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue]];
                        
                    }else{
                        
                        price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue] + [goods.freight floatValue] * [goods.number floatValue]];
                        
                    }
                    
                    
                }else{
                    
                    
                    price = [NSString stringWithFormat:@"%.02f",[goods.pay_maney floatValue] * [goods.number floatValue] + [goods.pay_integer floatValue] *[goods.number floatValue]];
                    
                }
                
                
                _MaxInteger +=[goods.pay_integer floatValue] *[goods.number floatValue];
                
                [priceArrM addObject:price];
                
                
                
            }
            
            
            //                            NSLog(@"==666===%@",priceArrM);
            
            OtherArrM = [[NSMutableArray alloc] initWithArray:priceArrM];
            
            
            
            
            
            
            for (NSString *price in priceArrM) {
                
                
                //                                NSLog(@"==price==%@",price);
                
                number += [price floatValue];
                
                _GoodsAllPrice += [price floatValue];
                
                
            }
            
            [priceArrM removeAllObjects];
            
            
            NSString *string = [NSString stringWithFormat:@"共%ld件商品 小计：￥%.02f",nnnnn,number];
            
            //                           NSLog(@"===111====%@",string);
            
            NSString *red = [NSString stringWithFormat:@"￥%.02f",number];
            
            //                           NSLog(@"===222====%@",red);
            
            [_LabelArrM addObject:string];
            
            [_RedArrM addObject:red];
            
            number=0;
            
            nnnnn=0;
            
        }
        
        
        
        
        [_tableView reloadData];
    }
}

//更改配送方式代理方法

-(void)cellSelectTypeClick:(UIButton *)sender
{
    
    CartDingDanCell *CartCell = (CartDingDanCell *)[sender superview];
    
    NSIndexPath *indexPath;
    indexPath = [_tableView indexPathForCell:CartCell];
    
    
//    NSLog(@"=======选择的是====%ld===%ld===",(long)indexPath.section,(long)indexPath.row);
    
    _SelectIndexPath = indexPath.row;
    
    _SelectSection = indexPath.section;
    
    CartStoreModel *bigModel = _StoreArrM[indexPath.section-1];
    CartGoodsModel *cellModel = bigModel.goodsList[indexPath.row];
    
    NSLog(@"=======%@",cellModel.exchange);
    
    
    if ([cellModel.exchange integerValue] == 1|| [cellModel.exchange integerValue] == 2) {
        
        //只有一种配送方式
        //快递邮寄0
        
    }else if([cellModel.exchange integerValue] == 3|| [cellModel.exchange integerValue] == 4){
        
        CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄",@"线下自取"]];
        
        mySheet.cancelTitle=@"关闭";
        
        mySheet.delegate = self;
        
        
        if ([cellModel.exchange_type isEqualToString:@"0"]) {
            
            mySheet.SelectString= @"1";
            
            
        }else{
            
            mySheet.SelectString= @"2";
            
        }
        
        [mySheet show];
        
    }
    
}


//输入积分时，调用
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    UITextField *TF = (UITextField *)[self.view viewWithTag:100];
    
    NSLog(@"SH==%d",isButtonOn);
    
    NSLog(@"=======%.02f",[textField.text floatValue]);
    if (TF == textField && isButtonOn==YES) {
        
        NSLog(@"=111==我输入了==%@===%@====%.02f=====%.02f",textField.text,self.UserInteger,_MaxInteger,_GoodsAllPrice);
        
        //用户积分大于抵扣积分
        if ([self.UserInteger floatValue] >= _MaxInteger) {
            
            //输入的积分大于最大抵扣积分
            if ([textField.text floatValue] >= _MaxInteger) {
                
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",_MaxInteger];
                ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",_MaxInteger];
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice-_MaxInteger];
                NSLog(@"==111==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice-_MaxInteger];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = [NSString stringWithFormat:@"%.02f",_MaxInteger];
                
                
                
            }else if([textField.text floatValue] < 0){
                
                [JRToast showWithText:@"输入的积分不能为负数！" duration:1.0f];
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",_MaxInteger];
                
            }else{//用户输入积分小于最大抵扣积分
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",[textField.text floatValue]];
                ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",[textField.text floatValue]];
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice-[textField.text floatValue]];
                NSLog(@"==111==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice-[textField.text floatValue]];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = [NSString stringWithFormat:@"%.02f",[textField.text floatValue]];
                
            }
            
            
        }else{//用户积分小于抵扣积分
            
            
            //输入的积分大于用户积分
            if ([textField.text floatValue] >= [self.UserInteger floatValue]) {
                
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",[self.UserInteger floatValue]];
                ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",[self.UserInteger floatValue]];
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice-[self.UserInteger floatValue]];
                NSLog(@"==111==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice-[self.UserInteger floatValue]];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = [NSString stringWithFormat:@"%.02f",[self.UserInteger floatValue]];
                
            }else if([textField.text floatValue] < 0){
                

                [JRToast showWithText:@"输入的积分不能为负数！" duration:1.0f];
                    
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",[self.UserInteger floatValue]];
                    
            
            }else{//用户输入积分小于用户积分
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",[textField.text floatValue]];
                ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",[textField.text floatValue]];
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice-[textField.text floatValue]];
                NSLog(@"==111==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice-[textField.text floatValue]];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = [NSString stringWithFormat:@"%.02f",[textField.text floatValue]];
                
                
            }
            
            
        }
        
        
        
    }else{
        
        NSLog(@"=222==我输入了==%@===%@====%.02f=====%.02f",textField.text,self.UserInteger,_MaxInteger,_GoodsAllPrice);
        
        //用户积分大于抵扣积分
        if ([self.UserInteger floatValue] >= _MaxInteger) {
            
            //输入的积分大于最大抵扣积分
            if ([textField.text floatValue] >= _MaxInteger) {
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",_MaxInteger];
                ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",_MaxInteger];
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice];
                NSLog(@"==111==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = @"0";
                
            }else{
                
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",[textField.text floatValue]];
                ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",[textField.text floatValue]];
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice];
                NSLog(@"==111==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = @"0";
                
            }
            
        }else{
            
            
            
            //输入的积分大于用户积分
            if ([textField.text floatValue] >= [self.UserInteger floatValue]) {
                
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",[self.UserInteger floatValue]];
                ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",[self.UserInteger floatValue]];
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice];
                
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = @"0";
                
            }else{//用户输入积分小于用户积分
                
                ScoreCell.ScoreTF.text = [NSString stringWithFormat:@"%.02f",[textField.text floatValue]];
                ScoreCell.DuiHuanLab.text = [NSString stringWithFormat:@"积分兑换￥%.02f",[textField.text floatValue]];
                
                NSString *string = [NSString stringWithFormat:@"共%ld件，合计：￥%.02f",(long)_GoodsCount,_GoodsAllPrice];
                NSLog(@"==111==string==%@====",string);
                NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",_GoodsAllPrice];
                
                NSString *stringForColor1 = [NSString stringWithFormat:@"%ld",(long)_GoodsCount];
                
                
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
                //
                NSRange range = [string rangeOfString:stringForColor];
                NSRange range1 = [string rangeOfString:stringForColor1];
                
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
                
                [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                
                
                priceLabel.attributedText=mAttStri;
                
                deductionIntegral = @"0";
                
                
            }
        }
    }
}

-(void)backBtnClick
{
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(CartGoToDingDanReloadData)]) {
        
        [_delegate CartGoToDingDanReloadData];
        
    }
    
    if ([self.PanDuan isEqualToString:@"100"]) {
        
        self.tabBarController.tabBar.hidden=NO;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if ([self.PanDuan isEqualToString:@"200"]){
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}


//NSNotification:  消息的类
/*
 name, object, userInfo
 */
- (void)keyboardWillShow:(NSNotification *)notification andTextField:(UITextField *)textField
{
//    NSLog(@"---%@", notification);
    
    //获得键盘的高度
    CGRect rect =  [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    //CGRectValue, 将字符串---> 结构体
    //将结构体转换为字符串
    //NSStringFromCGRect(<#CGRect rect#>)
    
    CGFloat height = rect.size.height;
    
    //将self.view 的y坐标-height
    CGRect frame = _tableView.frame;
    if (frame.origin.y == 0) {
        frame.origin.y = frame.origin.y - height;
        _tableView.frame = frame;
    }
    
}

//当键盘掉下的时候， 会调用这个方法
- (void)keyboardWiilHide:(NSNotification *)notification andTextField:(UITextField *)textField
{
    
    CGRect rect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGFloat height = rect.size.height;
    
    CGRect frame = _tableView.frame;
    
    if (frame.origin.y < 0) {
        frame.origin.y = frame.origin.y + height;
        _tableView.frame = frame;
    }
    
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //获取当前textField的rect
        
        CartUseScoreCell *cell2 = (CartUseScoreCell *)textField.superview;
        if (kIOSVersions < 8.0) {
            cell2 = (CartUseScoreCell *)textField.superview.superview;
        }
        
        
        
        NSIndexPath *indexPath = [_tableView indexPathForCell:cell2];
        CGRect rectInTableView = [_tableView rectForRowAtIndexPath:indexPath];
        
        
        CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
//        NSLog(@"rect==%@", NSStringFromCGRect(rect));//rect.origin.y
        textField_rect =rect;
        
        return YES;
    
}

//键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (_tableView.frame.origin.y+_tableView.frame.size.height) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    
    return YES;
    
}

//键盘掉下
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

//用户留言
//控制输入文字的长度和内容，可通调用以下代理方法实现
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location==0)
    {
        //控制输入文本的长度
        //        textView.text=@"选填，有什么小要求在这提醒卖家";
        
        return  YES;
        
    }else if (range.location>=200){
        
        return NO;
        
    }
    
    if ([text isEqualToString:@"\n"]) {
        //禁止输入换行
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"选填，有什么小要求在这里提醒买家"] ) {
        textView.text=@"";
    }
    
}


//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView.text.length==0) {
        
        textView.text=@"选填，有什么小要求在这提醒卖家";
        
    }
    
    NSLog(@"=====textView.tag======%ld",textView.tag);
    
    
    NSLog(@"=====6666====%@",_WordTextViewTag);
    
    
    int number1 = 0;
    
    for (int i=0; i < _StoreArrM.count; i++) {
        
        
        CartStoreModel *model = _StoreArrM[i];
        
//        for (int j=0; j < _WordTextViewTag.count; j++) {
//            
//            
//            number1 = [_WordTextViewTag[j] intValue];
//            
//            NSLog(@"===6666===+++==%d",number1);
//            
//        }
        
        if ([model.mid integerValue]==textView.tag) {
            
//            CartStoreModel * newModel = [[CartStoreModel alloc] init];
//            
//            CartStoreModel *model = _StoreArrM[i];
            
            
            model.remark = textView.text;
            
            
//            newModel.mid = model.mid;
//            
//            newModel.storename = model.storename;
//            
//            newModel.remark = textView.text;
//            
//            newModel.goodsList = model.goodsList;
//            
//            [_StoreArrM replaceObjectAtIndex:i withObject:newModel];
            
            NSLog(@"====&&&&&&===%@",model.remark);
            
        }
        
        
        
    }
    
    _WordSection=0;
    
//    NSLog(@"==&&&&===%@=====%ld",textView.text,(long)textView.tag);
    
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        
        textView.text=@"选填，有什么小要求在这提醒卖家";
        //        textView.textColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    }
    return YES;
    
    
}


//提交订单
-(void)SubmitBtnClick:(UIButton *)sender
{
    
    
    
    if(self.AddressPhone.length==0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请先添加收货地址" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else{
        
        
    
    
//    NSLog(@"====deductionIntegral====%@",deductionIntegral);
    
        
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            
            [hud dismiss:YES];
            
        });
        
        
    NSMutableArray *_YYYYYArrM;
    
    NSMutableArray *_WWWWWArrM;
    
    NSMutableArray *_ZZZZZArrM;
    
    NSDictionary *dict1;
    
    NSDictionary *nameDict;
    
    _YYYYYArrM = [NSMutableArray new];
    
    _WWWWWArrM = [NSMutableArray new];
    
    _ZZZZZArrM = [NSMutableArray new];
    
    
    [_YYYYYArrM removeAllObjects];
    
    [_WWWWWArrM removeAllObjects];
    
    
    
    for (int i=0; i < _StoreArrM.count; i++) {
        
        CartStoreModel *model = _StoreArrM[i];
        
//        UITextView *CartFooter = (UITextView *)[self.view viewWithTag:[_WordTextViewTag[0] intValue]];
//        
//        NSLog(@"************%@",CartFooter.text);
        
        NSLog(@"====model.remark=====%@",model.remark);
        
        
        for (int j=0; j < model.goodsList.count; j++) {
            
            
            CartGoodsModel *goods = model.goodsList[j];
            
            dict1 = @{@"sid":goods.sid,@"gid":goods.gid,@"number":goods.number,@"detailId":goods.detailId,@"exchange_type":goods.exchange_type,@"good_type":goods.good_type};
            
            [_YYYYYArrM addObject:dict1];
            
            
        }
        
        _WWWWWArrM = [[NSMutableArray alloc] initWithArray:_YYYYYArrM];
        ;
        
        
        [_YYYYYArrM removeAllObjects];
        
        if (model.remark.length==0) {
            
            model.remark = @"";
            
        }
         nameDict= @{@"mid":model.mid,@"remark":[NSString stringWithFormat:@"%@",model.remark],@"goodslist":_WWWWWArrM};
        
         [_ZZZZZArrM addObject:nameDict];
        
        
    }
    
        deductionIntegral=[NSString stringWithFormat:@"%@",deductionIntegral];
        if ([deductionIntegral isEqualToString:@""]||[deductionIntegral containsString:@"null"]) {
            deductionIntegral=@"0";
        }

        
        NSDictionary *dict = @{@"deductionIntegral":deductionIntegral,@"aid":self.AddressAid,@"phone":self.AddressPhone,@"goods":_ZZZZZArrM};
    
    
    NSString *str = [self dictionaryToJson:dict];
    
    NSLog(@"====提交订单数据===%@",str);
    
    
    NSNull *null = [[NSNull alloc] init];
    
    [HTTPRequestManager POST:@"submitOrder_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"json":str} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"====%@===",responseObj);
        
        
        if (responseObj) {
            
            for (NSDictionary *dict in responseObj) {
                
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    //发送通知，购物车刷新数据
                    NSNotification *notification1 = [[NSNotification alloc] initWithName:@"PaySuccessBackCart" object:nil userInfo:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:notification1];
                    
                    
                    [self ReloadCartNumber];
                    
                    self.PayType = dict[@"type"];
                    
                    self.Status=dict[@"status"];
                    
                    self.successurl=dict[@"successurl"];
                    
                    self.APP_ID = dict[@"APP_ID"];
                    
                    self.SELLER = dict[@"SELLER"];
                    
                    self.RSA_PRIVAT = dict[@"RSA_PRIVAT"];
                    
                    self.Pay_orderno = dict[@"orderno"];
                    
                    self.Notify_url = dict[@"notify_url"];
                    
                    self.Pay_money = dict[@"pay_money"];
                    
                    self.Money_url = dict[@"money"];
                    
                    self.Return_url = dict[@"returnurl"];
                    
                    if ([dict[@"type"] isEqualToString:@"2"] && ![dict[@"money"] isEqualToString:@""] && ![dict[@"money"] isEqual:null]){//组合支付
                        
                        
                        //调用支付宝支付
                        
                        [self saveAlipayRecord];
                        
                        
                        
                    }else{
                         [JRToast showWithText:dict[@"message"] duration:3.0f];
                    }
                    
                    
                }else{
                    
                    
                    [JRToast showWithText:dict[@"message"] duration:3.0f];
                    
                }
                
                
            }
            
            
        }else{
            
            [TrainToast showWithText:error.localizedDescription duration:2.0];
            NSLog(@"error");
            
        }
        
        
    }];
        
    }
    
   
}


-(void)ReloadCartNumber
{
    [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {
        
        
//        NSLog(@"====%@===",responseObj);
        
        
        if (responseObj) {
            
            
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                
                
                [UserMessageManager AppDelegateCartNumber:responseObj[@"goods_sum"]];
                
            }
            
            
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];
    
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

#pragma mark - 进店看看代理方法
-(void)GoToLookShopStore:(NSString *)mid
{
    
//    GotoShopLookViewController *look=[[GotoShopLookViewController alloc] init];
//    
//    
//    look.mid=mid;
//    
//    
//    [self.navigationController pushViewController:look animated:NO];
    
}

-(void)saveAlipayRecord
{
    
    NSLog(@"====self.Pay_orderno=====%@",self.Pay_orderno);
    NSLog(@"====self.Money_url=====%@",self.Money_url);
    NSLog(@"====self.Return_url=====%@",self.Return_url);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@saveAlipayRecord.shtml",URL_Str1];
    //saveUserExchange_mob.shtml
    
    
    NSDictionary *dic = @{@"pay_order":self.Pay_orderno,@"pay_money":self.Money_url,@"clientId":@"10003",@"describe":@"IOS",@"returnurl":self.Return_url};
    
    //        NSDictionary *dic=nil;
    //        NSDictionary *dic = @{@"classId":@"129"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"========保存支付宝信息==%@",dic);
            
            for (NSDictionary *dict1 in dic) {
                
                self.Alipay_Goods_name =dict1[@"goods_name"];
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                    
                    [self GoALiPay];
                    
                    
                }else{
                    
                    [JRToast showWithText:dict1[@"message"] duration:2.0f];
                }
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
//        [self NoWebSeveice];
        [TrainToast showWithText:error.localizedDescription duration:2.0];
        NSLog(@"%@",error);
    }];
    
    

    
    
    
    
}

-(void)GoALiPay
{
    
    
    
//    [UserMessageManager removeUserWord];
    
    NSLog(@"===self.APP_ID===%@===self.SELLER=%@===self.RSA_PRIVAT=%@==self.Pay_money===%@==self.Pay_orderno===%@==self.Notify_url==%@",self.APP_ID,self.SELLER,self.RSA_PRIVAT,self.Pay_money,self.Pay_orderno,self.Notify_url);
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    //    NSString *appID = @"2016102002254231";
    
    NSString *appID = self.APP_ID;
    
    //    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMTmGiHlcAdESK9KcP7vmvSS8uO75JBW+O5ruS1SD+iuWRfFiBplBkZJ57a/LFRwZDvaC/7klSXTRhn4KbHuVfIGXc3j6F1BpWkh7Cks8FOGb86o5wHbbsLWC6JmMAhTIypcIuREKWQ5a9219GTzG/PhBeNdg+EklvlFyr3rCBlRAgMBAAECgYEAsWNoma8eDb3sCdh0EomFPeCB6L/nPE7Ot+XfD8CFyqgAZhU0+CqZy4tbsV1sL6qN8woPkpUW9dvwpQbZcY76Z5uQ29w6NyXn20rqlcw2qNUPCgxagHAKVohQSFpMl3hj2L2Nw1q3KapwVkZ918r5ksLUBrlb3cCBo9WdxtyAGB0CQQDpgsz4TPAXA4jFfAD3FMxoom3Xdy+AJC43sGflUTyureqL0g/xHTB4CQW9n2ygGn9qk+Now08tV0J6RRrJ7zNjAkEA19yhy90/NwdHBpOK/6dGzweSud+hZx7UYNy4JhC9pppVP5ECNnJC7rnN3BIMuIKSkr8DwKi6HSn5Bgo7uRkwuwJAT9kEUdutNZFl0XHHurWH+Deiq8z7lyvICg7uWAHhaDHcRBd+kApVKpabOe4r7MtiyoTrfEVc67os5zZ+JJMA1QJAM83PRo2iTiKA+SMPiKssYyL+I313zrenYFeYGgqKeSEwtECot0hUp9YPgXETfHRZmL4euG3FvJoGGVz7WECjYQJBAL8W1pQpZcUgLppoSwgsjitLv1Xe0GNWJm0vql7zCLsAMF7+w1fY3LHuJP/RfHDX5aswfSa/s7Ox6iV5MSlgGnk=";
    
    NSString *privateKey = self.RSA_PRIVAT;
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    
    //回调
    order.notify_url=self.Notify_url;
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"2.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    order.return_url = self.successurl;
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"安淘惠";
    order.biz_content.subject = self.Alipay_Goods_name;
    
    //    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.out_trade_no = self.Pay_orderno; //订单ID（由商家自行制定）
    
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.02f", [self.Pay_money floatValue]]; //商品价格
    if (ISTEXTPRICE) {
        order.biz_content.total_amount = [NSString stringWithFormat:@"%.02f", 0.01]; //商品价格
    }
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"aTaohPay";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            
            
            NSLog(@"reslut = %@",resultDic);
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                //读取数组NSArray类型的数据
                
                
                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"0" AndIndexType:2];
                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
                [self.navigationController pushViewController:vc animated:NO];
                
                
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
                
                [JRToast showWithText:@"正在处理中" duration:2.0f];
                
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
                
                
                [JRToast showWithText:@"订单支付失败" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                
                [JRToast showWithText:@"用户中途取消" duration:2.0f];
                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"0" AndIndexType:1];
                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
                [self.navigationController pushViewController:vc animated:NO];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
                
                [JRToast showWithText:@"网络连接出错" duration:2.0f];
            }
            
            
        }];
        //
        
        
        
    }
    
    
}

-(void)resultStatus:(NSNotification *)text
{


    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {

        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据


        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"0" AndIndexType:2];
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
        [self.navigationController pushViewController:vc animated:NO];



    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){

        [JRToast showWithText:@"正在处理中" duration:2.0f];


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){


        [JRToast showWithText:@"订单支付失败" duration:2.0f];

    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"0" AndIndexType:1];
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
        [self.navigationController pushViewController:vc animated:NO];
        [JRToast showWithText:@"用户中途取消" duration:2.0f];

    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){

        [JRToast showWithText:@"网络连接出错" duration:2.0f];
    }


}

-(void)HuoQuanXian
{
    
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    //    NSString *pid = @"2088712201847501";
    //    NSString *appID = @"2016102002254231";
    //    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMTmGiHlcAdESK9KcP7vmvSS8uO75JBW+O5ruS1SD+iuWRfFiBplBkZJ57a/LFRwZDvaC/7klSXTRhn4KbHuVfIGXc3j6F1BpWkh7Cks8FOGb86o5wHbbsLWC6JmMAhTIypcIuREKWQ5a9219GTzG/PhBeNdg+EklvlFyr3rCBlRAgMBAAECgYEAsWNoma8eDb3sCdh0EomFPeCB6L/nPE7Ot+XfD8CFyqgAZhU0+CqZy4tbsV1sL6qN8woPkpUW9dvwpQbZcY76Z5uQ29w6NyXn20rqlcw2qNUPCgxagHAKVohQSFpMl3hj2L2Nw1q3KapwVkZ918r5ksLUBrlb3cCBo9WdxtyAGB0CQQDpgsz4TPAXA4jFfAD3FMxoom3Xdy+AJC43sGflUTyureqL0g/xHTB4CQW9n2ygGn9qk+Now08tV0J6RRrJ7zNjAkEA19yhy90/NwdHBpOK/6dGzweSud+hZx7UYNy4JhC9pppVP5ECNnJC7rnN3BIMuIKSkr8DwKi6HSn5Bgo7uRkwuwJAT9kEUdutNZFl0XHHurWH+Deiq8z7lyvICg7uWAHhaDHcRBd+kApVKpabOe4r7MtiyoTrfEVc67os5zZ+JJMA1QJAM83PRo2iTiKA+SMPiKssYyL+I313zrenYFeYGgqKeSEwtECot0hUp9YPgXETfHRZmL4euG3FvJoGGVz7WECjYQJBAL8W1pQpZcUgLppoSwgsjitLv1Xe0GNWJm0vql7zCLsAMF7+w1fY3LHuJP/RfHDX5aswfSa/s7Ox6iV5MSlgGnk=";
    
    NSString *pid = self.SELLER;
    NSString *appID = self.APP_ID;
    NSString *privateKey = self.RSA_PRIVAT;
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少pid或者appID或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //生成 auth info 对象
    APAuthV2Info *authInfo = [APAuthV2Info new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"aTaohPay";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:authInfoStr];
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, @"RSA"];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               
                                               
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    }
    
}


@end
