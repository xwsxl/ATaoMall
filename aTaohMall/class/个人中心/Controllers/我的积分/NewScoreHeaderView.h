//
//  NewScoreHeaderView.h
//  aTaohMall
//
//  Created by JMSHT on 2016/12/5.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewScoreHeaderViewDelegate<NSObject>

-(void)AllScoreButClick:(UIButton *)sender;

-(void)ShouRuScoreButClick:(UIButton *)sender;

-(void)ZhiChuScoreButClick:(UIButton *)sender;

@end
@interface NewScoreHeaderView : UITableViewHeaderFooterView

@property(nonatomic,strong)UILabel *JiFenLabel;//积分
@property (weak, nonatomic) IBOutlet UIImageView *lineIV;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *Score;


@property (nonatomic,weak)id<NewScoreHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *RedView;
@property (nonatomic,strong)UIImage *BackImage;

-(void)BtnClick1;
-(void)BtnClick2;
-(void)BtnClick3;
@end
