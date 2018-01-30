//
//  XLNaviVIew.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "XLNaviVIew.h"
@interface XLNaviView ()
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UIImageView *backIV;
@property (nonatomic,strong)UIButton *qurtBut;

@property (nonatomic,strong)UIImage *BackImage;

@property (nonatomic,strong) UIImageView *line;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *imgNam;
@end

@implementation XLNaviView

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
        _imgNam=@"iconfont-fanhui2yt";
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

//    self.backIV = [[UIImageView alloc] init];
//    //CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
//    UIImage *img=[self.BackImage getSubImage:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight)];
//    [self.backIV setImage:img];
//    self.backIV.userInteractionEnabled=YES;

    [self setBackgroundColor:[UIColor whiteColor]];
    self.userInteractionEnabled=YES;
    [self addSubview:self.backIV];

    self.line = [[UIImageView alloc] init];


    self.line.image = [UIImage imageNamed:@"分割线-拷贝"];

     [self addSubview:self.line];

    //返回按钮

    self.qurtBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.qurtBut setImage:[UIImage imageNamed:self.imgNam] forState:UIControlStateNormal];
    [self.qurtBut addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.qurtBut];

    //创建搜索
    self.titleLab=[[UILabel alloc] init];

    self.titleLab.text =self.title;

    self.titleLab.textColor = RGB(51, 51, 51);

    self.titleLab.font = KNSFONT(19);

    self.titleLab.textAlignment = NSTextAlignmentCenter;

    [self addSubview:self.titleLab];

}

-(void)layoutSubviews
{
    [super layoutSubviews];

    [self.titleLab setFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];

    [self.qurtBut setFrame:CGRectMake(10, 25+KSafeTopHeight, 30, 30)];
    [self.line setFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    [self.backIV setFrame:self.frame];
}

-(void)QurtBtnClick
{
    if (_delegate&&[_delegate respondsToSelector:@selector(QurtBtnClick)]) {
        [_delegate QurtBtnClick];
    }
}








@end
