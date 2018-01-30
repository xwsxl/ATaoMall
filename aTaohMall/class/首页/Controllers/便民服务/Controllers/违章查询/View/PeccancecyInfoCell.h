//
//  PeccancecyInfoCell.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeccancecyInfoCell : UITableViewCell

@property(nonatomic,strong)UILabel *markAndFineLab;

@property(nonatomic,strong)UILabel *updateTimeLab;

@property(nonatomic,strong)UILabel *typeLab;

@property(nonatomic,strong)UILabel *placeLab;


-(void)changeFrame;

-(void)setStatesWithCanHandle:(NSString *)canHandle andType:(NSString *)type;
@end
