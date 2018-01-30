//
//  PersonalShoppingRefundFooterView.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingRefundFooterView.h"
@interface PersonalShoppingRefundFooterView()


@property (nonatomic,strong)UIImageView *lineView;

@property (nonatomic,strong)UIButton *checkLogisticBut;

@property (nonatomic,strong)UIView *fenGeView;

@end

@implementation PersonalShoppingRefundFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //在这里向contentView添加控件
        [self setUpSubviews];

    }
    return self;
}


-(void)setUpSubviews
{

    self.lineView=[[UIImageView alloc] init];
    [self.contentView addSubview:self.lineView];

    self.checkLogisticBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkLogisticBut setTitleColor:RGB(255, 92, 94) forState:UIControlStateNormal];
    self.checkLogisticBut.titleLabel.font=KNSFONTM(14);
    [self.contentView addSubview:self.checkLogisticBut];

    self.fenGeView=[[UIView alloc] init];
    [self.fenGeView setBackgroundColor:RGB(244, 244, 244)];
    [self.contentView addSubview:self.fenGeView];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.userInteractionEnabled=YES;
    [self.contentView setBackgroundColor:[UIColor whiteColor]];

    [self.lineView setFrame:CGRectMake(0, 0, kScreen_Width, 1)];

    [self.checkLogisticBut setFrame:CGRectMake(kScreenWidth-Width(15)-90, 1+Height(12), 90, 27)];

    [self.checkLogisticBut.layer setCornerRadius:13.5];

    [self.checkLogisticBut.layer setBorderWidth:1];
    [self.checkLogisticBut.layer setBorderColor:RGB(255, 93, 94).CGColor];
    [self.checkLogisticBut addTarget:self action:@selector(checkDetailInfoButClick:) forControlEvents:UIControlEventTouchUpInside];

    [_fenGeView setFrame:CGRectMake(0, 1+Height(24)+27, kScreenWidth, Height(10))];

    if (_dataModel.goods_order_list.count>1) {
        [self.lineView setFrame:CGRectZero];
        [self.checkLogisticBut setFrame:CGRectZero];
        [_fenGeView setFrame:CGRectMake(0,1, kScreenWidth, Height(10))];
    }
}

-(void)checkDetailInfoButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(checkDetailInfoWithModel:)]) {
        [_delegate checkDetailInfoWithModel:_dataModel];
    }
}

-(void)setDataModel:(XLDingDanModel *)dataModel
{
    _dataModel=dataModel;
    [self.lineView setImage:KImage(@"分割线-拷贝")];
    [self.checkLogisticBut setTitle:@"查看详情" forState:UIControlStateNormal];
}


@end
