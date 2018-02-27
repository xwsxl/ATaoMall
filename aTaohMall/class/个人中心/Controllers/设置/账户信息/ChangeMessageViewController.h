//
//  ChangeMessageViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/17.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeQQDelegate <NSObject>

-(void)setQQWithString:(NSString *)string;

@end
@interface ChangeMessageViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *ChangeMessageTextField;//修改输入框

@property(nonatomic,copy)NSString *ChangeString;//上级页面传的信息

@property(nonatomic,weak) id <ChangeQQDelegate> delegate;

@property(nonatomic,copy)NSString *sigens;
@end
