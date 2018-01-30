//
//  FanLiViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FanLiViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;

@property (weak, nonatomic) IBOutlet UIImageView *ErImgView;

@property(nonatomic,copy) NSString *href;//生成二维码链接
@end
