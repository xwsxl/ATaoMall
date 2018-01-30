//
//  CartHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/29.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "CartHeaderView.h"

#define HeaderHeight [[UIScreen mainScreen] bounds].size.height*0.1049

#import "StoreModel.h"
@interface CartHeaderView()
/** 内部的label */

{
    
    
    
}

@end


@implementation CartHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        [self setUI];
        
    }
    return self;
}


-(void)setUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
//    _ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
//    
//    _ImgView.image=[UIImage imageNamed:@"为勾选"];
    
//    [self.contentView addSubview:_ImgView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeaderHeight*0.1428)];
    
    bgView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.contentView addSubview:bgView];
    
    self.line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    
    self.line1.image = [UIImage imageNamed:@"分割线e2"];
    
    [bgView addSubview:self.line1];
    
    
    _ImgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _ImgButton.frame = CGRectMake(20, (HeaderHeight-20-HeaderHeight*0.1428)/2+HeaderHeight*0.1428, 20, 20);
    [_ImgButton setBackgroundImage:[UIImage imageNamed:@"为勾选"] forState:UIControlStateNormal];
    [_ImgButton setBackgroundImage:[UIImage imageNamed:@"勾"] forState:UIControlStateSelected];
    
//    _ImgButton.frame = CGRectMake(0, 0, 40, 60);
//    [_ImgButton setBackgroundImage:[UIImage imageNamed:@"New未选中40x60"] forState:UIControlStateNormal];
//    [_ImgButton setBackgroundImage:[UIImage imageNamed:@"New选中40x60"] forState:UIControlStateSelected];
    
    [_ImgButton addTarget:self action:@selector(ImgButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.contentView addSubview:_ImgButton];
    
    
    UIImageView *LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, (HeaderHeight-20-HeaderHeight*0.1428)/2+HeaderHeight*0.1428, 20, 20)];
    
    LogoImgView.image = [UIImage imageNamed:@"店铺111"];
    
    [self.contentView addSubview:LogoImgView];
    
    
    // label
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(75, (HeaderHeight-20-HeaderHeight*0.1428)/2+HeaderHeight*0.1428, [UIScreen mainScreen].bounds.size.width-150, 20);
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [self.contentView addSubview:label];
    
    
    self.label = label;
    
    
    self.GoToStoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.GoToStoreButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    self.GoToStoreButton.frame = CGRectMake(60, 10, [UIScreen mainScreen].bounds.size.width-120, 60);
    [self.GoToStoreButton addTarget:self action:@selector(GotoShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.GoToStoreButton];
    
    
    _edit=[UIButton buttonWithType:UIButtonTypeCustom];
    _edit.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60, (HeaderHeight-30-HeaderHeight*0.1428)/2+HeaderHeight*0.1428, 40, 30);
    [_edit setTitle:@"编辑" forState:UIControlStateNormal];
    [_edit setTitle:@"完成" forState:UIControlStateSelected];
    
    _edit.titleLabel.font=[UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [_edit setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:0];
    
    [self.contentView addSubview:_edit];
    
    [_edit addTarget:self action:@selector(HeaderEditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(45, HeaderHeight-0.5, [UIScreen mainScreen].bounds.size.width-45, 0.5)];
    
    line.image = [UIImage imageNamed:@"分割线e2"];
    
    [self.contentView addSubview:line];
    
}


//进入店铺

-(void)GotoShopBtnClick:(UIButton *)sender
{
    NSLog(@"===mid===%@",_carModel.mid);
    
    if (_delegate && [_delegate respondsToSelector:@selector(enterShopStore:)]) {
        
        [_delegate enterShopStore:_carModel.mid];
        
        
    }
    
    
}
//组头编辑
-(void)HeaderEditBtnClick:(UIButton *)sender
{
    
    sender.selected = !sender.selected;
    NSLog(@"%d",_edit.selected);
    if ([self.delegate respondsToSelector:@selector(EditGoods:)]) {
        [self.delegate EditGoods:sender];
    }
    
}

-(void)ImgButtonBtnClick:(UIButton *)sender
{
    
    NSLog(@"++++++==%ld=",sender.tag);
    
//    _ImgButton = (UIButton *)[self viewWithTag:sender.tag];
    
//    if (sender.selected) {
//        
//        [_ImgButton setImage:[UIImage imageNamed:@"勾"] forState:0];
//        
//        sender.selected=NO;
//        
//    }else{
//        
//        [_ImgButton setImage:[UIImage imageNamed:@"为勾选"] forState:0];
//        
//        sender.selected=YES;
//    }
    
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(selectOrEditGoods:)]) {
        [self.delegate selectOrEditGoods:sender];
    }
    
    
    
}


- (void)setEditBtnTag:(NSInteger)editBtnTag{
    if (_edit.tag == editBtnTag) {
        
    }else{
        _editBtnTag = editBtnTag;
        _edit.tag = editBtnTag;
    }
    
}


- (void)setText:(NSString *)text
{
    _text = text;
    
    NSLog(@"====width==%@=",_text);
    
    CGRect tempRect = [_text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-150,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
//    NSLog(@"====width==%f===height==%f",tempRect.size.width,tempRect.size.height);
    
//    self.label = [[UILabel alloc] init];
//    self.label.frame = CGRectMake(80, 20, tempRect.size.width, 20);
//    self.label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
//    self.label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.label.text = [NSString stringWithFormat:@"%@",text];
    
//    [self.contentView addSubview:self.label];
//
    
    [self.gogo removeFromSuperview];
    
    self.gogo = [[UIImageView alloc] initWithFrame:CGRectMake(75+tempRect.size.width+2, (HeaderHeight-13-HeaderHeight*0.1428)/2+1+HeaderHeight*0.1428, 13, 13)];
    
    self.gogo.image = [UIImage imageNamed:@"iconfont-enter111"];
    
    [self.contentView addSubview:self.gogo];
    
    
}


-(void)setSelectBtnTag:(NSInteger)selectBtnTag
{
    
    if (_ImgButton.tag == selectBtnTag) {
        
    }else{
        _selectBtnTag = selectBtnTag;
        _ImgButton.tag = selectBtnTag;
    }
    _selectBtnTag = selectBtnTag;
    _ImgButton.tag = selectBtnTag;
    
}

- (void)setSelectBtnState:(BOOL)state{
    _ImgButton.selected = state;
}
//设置全选按钮的状态
- (void)setHeaderViewAllSelectBtnState:(BOOL)headerViewAllSelectBtnState{
    _headerViewAllSelectBtnState = headerViewAllSelectBtnState;
    _ImgButton.selected = headerViewAllSelectBtnState;
}


//设置编辑按钮的状态
- (void)setHeaderViewEditBtnState:(BOOL)headerViewEditBtnState{
    _headerViewEditBtnState = headerViewEditBtnState;
    _edit.selected = headerViewEditBtnState;
}

- (void)setHiddenEidtBtn:(BOOL)hiddenEidtBtn{
    _hiddenEidtBtn = hiddenEidtBtn;
    if (hiddenEidtBtn) {
        _edit.hidden = YES;
    }else{
        _edit.hidden = NO;
    }
}


- (void)setCarModel:(StoreModel *)carModel{
    
    _carModel = carModel;
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
