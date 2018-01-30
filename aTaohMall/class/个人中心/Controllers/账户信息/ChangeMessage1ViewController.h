//
//  ChangeMessage1ViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/3.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ChangeEmailDelegate <NSObject>

-(void)setEmailWithString:(NSString *)string;

@end

@interface ChangeMessage1ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *ChangeEmailTF;//修改邮箱

@property(nonatomic,copy)NSString *sigens;

@property(nonatomic,copy)NSString *ChangeString;//上级页面传的信息

@property(nonatomic,weak) id <ChangeEmailDelegate> delegate;
@end
