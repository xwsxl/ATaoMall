//
//  MallBaseTabBarController.m
//  Mall
//
//  Created by DingDing on 14-12-25.
//  Copyright (c) 2014年 QJM. All rights reserved.
//

#import "MallBaseTabBarController.h"
#import "MallBaseNavigationController.h"

#import "NearbyViewController.h"

@implementation MallBaseTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    [self.baseTabBar setTintColor:[UIColor colorWithRed:255/255.0 green:66/255.0 blue:72/255.0 alpha:1.0]];
    [self.baseTabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_back"]];
    
//    [self.baseTabBar setSelectionIndicatorImage:[UIImage imageNamed:@"toolBar_shade"]];
    
    UIImage *tabImage = [[UIImage imageNamed:@"toolBar_shade"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGSize tabSize = CGSizeMake(CGRectGetWidth(self.view.frame)/ 5 , 49);
    UIGraphicsBeginImageContext(tabSize);
    [tabImage drawInRect:CGRectMake(0, 0, tabSize.width, tabSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.baseTabBar setSelectionIndicatorImage:reSizeImage];
    
    
    //UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    
    //view1.backgroundColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1.0];
    
    //[self.baseTabBar setBackgroundColor:[UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1.0]];
    //[self.baseTabBar insertSubview:view1 atIndex:0];
    
    NSArray *itemImgArr_on = @[@"home_on_",@"commodity_on_",
                               @"business_on_",@"near_on_"];
    NSArray *itemImgArr = @[@"home_",@"commodity_",
                             @"business_",@"near_"];
    
    
    NSArray *itemImgArr_on1 = @[@"首页@3x",@"分类2@3x",
                               @"商圈@3x",@"个人中心2@3x",@"个人中心2@3x"];
    NSArray *itemImgArr1 = @[@"首页@3x (2)",@"分类@3x",
                            @"商圈@3x (2)",@"个人中心@3x",@"个人中心@3x"];
    NSArray *nameStr = @[@"首页",@"分类",@"商圈",@"购物车",@"个人中心"];
    
    
    
    NSDictionary *textDic = @{NSForegroundColorAttributeName:[UIColor grayColor]};
    NSDictionary *textDicON = @{NSForegroundColorAttributeName:[UIColor redColor]};
    
    
    //更改tabbar的颜色
    for (NSInteger i = 0; i < itemImgArr1.count; i++) {
        

        UIImage *normalImg = [UIImage imageNamed:[itemImgArr_on1 objectAtIndex:i]];
        UIImage *selectImg = [UIImage imageNamed:[itemImgArr1 objectAtIndex:i]];
        
        UITabBarItem *item = [[self.baseTabBar.items objectAtIndex:i]initWithTitle:[nameStr objectAtIndex:i] image:normalImg selectedImage:selectImg];

        

        //显示购物车件数
        
        if (i==3) {
            
//            item.badgeValue=@"9";
            
            item.tag=100;
            
            
        }
        
        
        
        [item setTitleTextAttributes:textDic forState:UIControlStateNormal];
        [item setTitleTextAttributes:textDicON forState:UIControlStateSelected];
    }
}

@end
