//
//  BuyCountView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyCountView : UIView<UITextFieldDelegate>
@property(nonatomic, retain)UILabel *lb;
@property(nonatomic, retain)UIButton *bt_reduce;
@property(nonatomic, retain)UITextField *tf_count;

//@property(nonatomic, retain)UILabel *tf_count;
@property(nonatomic, retain)UIButton *bt_add;

@property(nonatomic,copy) NSString *YTCount;

@end
