//
//  AuthcodeView.h
//  MFTextView
//
//  Created by lanouhn on 16/4/29.
//  Copyright © 2016年 Mifiste. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthcodeView : UIView

@property (nonatomic, strong) NSArray *dataArray;//字符素材数组

@property (nonatomic, strong) NSMutableString *authcodeString;//验证码字符串

- (void)getAuthcode;
@end
