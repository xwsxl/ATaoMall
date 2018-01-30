//
//  NoGoodsDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/7/28.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NoGoodsDetailViewController.h"

#import "NineAndNineViewController.h"
#import "YTScoreViewController.h"

#import "YTGoodsDetailViewController.h"
@interface NoGoodsDetailViewController ()

@end

@implementation NoGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//返回
- (IBAction)BackBtnClick:(UIButton *)sender {
    
    NSArray *vcArray = self.navigationController.viewControllers;
    
//    NSInteger index;
    
    
    if (vcArray.count==1 || vcArray.count==2) {
        
        [self.navigationController popToViewController:vcArray[0] animated:YES];
        
    }else if (vcArray.count==3){
        
        [self.navigationController popToViewController:vcArray[0] animated:YES];
        
    }else if (vcArray.count==4){
        
        [self.navigationController popToViewController:vcArray[1] animated:YES];
        
    }else if (vcArray.count==5){
        
        [self.navigationController popToViewController:vcArray[2] animated:YES];
        
    }else if (vcArray.count==6){
        
        [self.navigationController popToViewController:vcArray[3] animated:YES];
        
    }else if (vcArray.count==7){
        
        [self.navigationController popToViewController:vcArray[4] animated:YES];
        
    }else if (vcArray.count==8){
        
        [self.navigationController popToViewController:vcArray[5] animated:YES];
        
    }else if (vcArray.count==9){
        
        [self.navigationController popToViewController:vcArray[6] animated:YES];
        
    }else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
//    for(UIViewController *vc in vcArray)
//    {
//        if ([vc isKindOfClass:[YTGoodsDetailViewController class]])
//        {
//           // [self.navigationController popToViewController:vc animated:YES];
//            
//            
//            [self.navigationController popToViewController:vc animated:YES];
//            
//        }
//    }
    
    
 //   [self.navigationController popViewControllerAnimated:YES];
    
    
    
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
