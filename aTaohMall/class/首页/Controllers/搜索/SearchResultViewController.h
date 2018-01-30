//
//  SearchResultViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchResultViewControllerDelegate<NSObject>
-(void)searchNewInformation:(NSString *)str;

@end

@interface SearchResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *searchResultTextField;//结果显示

@property(nonatomic,strong)NSMutableArray *resultArrM;

@property(nonatomic,copy) NSString * attribute;

@property (nonatomic,weak)id<SearchResultViewControllerDelegate> delegate;

@end
