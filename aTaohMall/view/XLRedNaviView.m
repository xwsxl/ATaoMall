//
//  XLRedNaviView.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "XLRedNaviView.h"
@interface XLRedNaviView ()
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UIImageView *backIV;
@property (nonatomic,strong)UIButton *qurtBut;

@property (nonatomic,strong)UIImage *BackImage;

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *imgNam;
@end
@implementation XLRedNaviView
-(NSString *)title
{
    if (!_title) {
        _title=@"订单详情";
    }
    return _title;
}
-(NSString *)imgNam
{
    if (!_imgNam) {
        _imgNam=@"iconfont-fanhui2";
    }
    return _imgNam;
}


-(instancetype)initWithFrame:(CGRect )frame AndMessage:(NSString *)msg ImageName:(NSString *)imgName
{
    if (msg&&![msg isEqualToString:@""]&&![msg containsString:@"null"]) {
        self.title=msg;
    }
    if (imgName&&![imgName isEqualToString:@""]&&![imgName containsString:@"null"]) {
        self.imgNam=imgName;
    }
    return [self initWithFrame:frame];
}

-(instancetype)initWithMessage:(NSString *)msg ImageName:(NSString *)imgName
{
    if (msg&&![msg isEqualToString:@""]&&![msg containsString:@"null"]) {
        self.title=msg;
    }
    if (imgName&&![imgName isEqualToString:@""]&&![imgName containsString:@"null"]) {
        self.imgNam=imgName;
    }
    CGRect frame=CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight);
    return [self initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews
{

    self.backIV = [[UIImageView alloc] init];
    //CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    UIImage *img=[self.BackImage getSubImage:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight)];
    [self.backIV setImage:img];
    self.backIV.userInteractionEnabled=YES;
    [self addSubview:self.backIV];

//    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 1)];
//
//    line.image = [UIImage imgNamed:@"分割线-拷贝"];
//
//     [self.view addSubview:line];

    //返回按钮

   self.qurtBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.qurtBut setImage:[UIImage imageNamed:self.imgNam] forState:UIControlStateNormal];
    [self.qurtBut addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backIV addSubview:self.qurtBut];

    //创建搜索
    self.titleLab=[[UILabel alloc] init];

    self.titleLab.text =self.title;

    self.titleLab.textColor = [UIColor whiteColor];

    self.titleLab.font = KNSFONT(19);

    self.titleLab.textAlignment = NSTextAlignmentCenter;

    [self.backIV addSubview:self.titleLab];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    [self.titleLab setFrame:CGRectMake(80, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-160, 30)];

    [self.qurtBut setFrame:CGRectMake(10, 25+KSafeTopHeight, 30, 30)];

    [self.backIV setFrame:self.frame];
}

-(UIImage *)BackImage
{

    if (!_BackImage) {
        _BackImage=[UIImage imageWithImageView:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight+Height(92)) StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, KSafeAreaTopNaviHeight+Height(92))];
    }
    return _BackImage;

}

-(void)QurtBtnClick
{
    if (_delegate&&[_delegate respondsToSelector:@selector(QurtBtnClick)]) {
        [_delegate QurtBtnClick];
    }
}

@end
