//
//  DuiHuanSuccessViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/9/1.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "DuiHuanSuccessViewController.h"



#import "PersonalAllDanVC.h"
#import "NewGoodsDetailViewController.h"

#import "YTGoodsDetailViewController.h"

@interface DuiHuanSuccessViewController ()

@end

@implementation DuiHuanSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//返回
- (IBAction)BackBtnClick:(UIButton *)sender {
    
    
    NSArray *vcArray = self.navigationController.viewControllers;
    
    
    for(UIViewController *vc in vcArray)
    {
        if ([vc isKindOfClass:[YTGoodsDetailViewController class]]){
            
            [self.navigationController popToViewController:vc animated:YES];
            
        }
    }
 //   [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
}

//查看我的订单
- (IBAction)LookMyTipBtnClick:(UIButton *)sender {
    
    
//    JiaoYiNoSendViewController *vc=[[JiaoYiNoSendViewController alloc] init];
//    
//    vc.backType=self.backType;
//    //                        vc.orderno=self.orderno;//传订单号
//    vc.orderno=self.orderno;//传订单号
//    
//    vc.sigen=self.sigen;
//    vc.logo=self.logo;
//    vc.storename=self.storename;
//    
//    
//    [self.navigationController pushViewController:VC animated:NO];
//    
//    self.navigationController.navigationBar.hidden=YES;
//    
    
    PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
    [vc selectedDingDanType:@"1" AndIndexType:2];
    self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    
}
@end
