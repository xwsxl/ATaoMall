//
//  RecomdViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/12/5.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecomdViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *GoToShallButton;

@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,copy) NSString *Score;//积分

@property(nonatomic,copy) NSString *Code;//积分


@property(nonatomic,copy) NSString *YTString;//积分


@property(nonatomic,copy) NSString *NnmberString;//邀请码

@property(nonatomic,copy) NSString *href;//生成二维码链接
@end
